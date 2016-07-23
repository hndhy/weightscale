//
// UIScrollView+SVPullToRefresh.m
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "TZXActivityIndicatorView.h"
#import "UtilsMacro.h"

#define fequalzero(a) (fabs(a) < FLT_EPSILON)

static CGFloat const SVPullToRefreshViewHeight = 40;

@interface SVPullToRefreshView ()

@property (nonatomic, copy) void (^pullToRefreshActionHandler)(void);

@property (nonatomic, strong) TZXActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) SVPullToRefreshState state;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *viewForState;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) CGFloat originalTopInset;

@property (nonatomic, assign) BOOL wasTriggeredByUser;
@property (nonatomic, assign) BOOL showsPullToRefresh;
@property(nonatomic, assign) BOOL isObserving;

- (void)resetScrollViewContentInset;
- (void)setScrollViewContentInsetForLoading;
- (void)setScrollViewContentInset:(UIEdgeInsets)insets;

@end



#pragma mark - UIScrollView (SVPullToRefresh)
#import <objc/runtime.h>

static char UIScrollViewPullToRefreshView;

@implementation UIScrollView (SVPullToRefresh)

@dynamic pullToRefreshView, showsPullToRefresh;

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler {
  
  if(!self.pullToRefreshView) {
    SVPullToRefreshView *view = [[SVPullToRefreshView alloc] initWithFrame:CGRectMake(0, -SVPullToRefreshViewHeight, self.bounds.size.width, SVPullToRefreshViewHeight)];
    view.pullToRefreshActionHandler = actionHandler;
    view.scrollView = self;
    [self addSubview:view];
    self.pullToRefreshView = view;
    self.showsPullToRefresh = YES;
  }
}

- (void)triggerPullToRefresh {
  self.pullToRefreshView.state = SVPullToRefreshStateTriggered;
  [self.pullToRefreshView startAnimating];
}

- (void)setPullToRefreshView:(SVPullToRefreshView *)pullToRefreshView {
  [self willChangeValueForKey:@"SVPullToRefreshView"];
  objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView,
                           pullToRefreshView,
                           OBJC_ASSOCIATION_ASSIGN);
  [self didChangeValueForKey:@"SVPullToRefreshView"];
}

- (SVPullToRefreshView *)pullToRefreshView {
  return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}

- (void)setShowsPullToRefresh:(BOOL)showsPullToRefresh {
  self.pullToRefreshView.hidden = !showsPullToRefresh;
  
  if(!showsPullToRefresh) {
    if (self.pullToRefreshView.isObserving) {
      [self removeObserver:self.pullToRefreshView forKeyPath:@"contentOffset"];
      [self removeObserver:self.pullToRefreshView forKeyPath:@"frame"];
      [self.pullToRefreshView resetScrollViewContentInset];
      self.pullToRefreshView.isObserving = NO;
    }
  }
  else {
    if (!self.pullToRefreshView.isObserving) {
      [self addObserver:self.pullToRefreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
      [self addObserver:self.pullToRefreshView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
      self.pullToRefreshView.isObserving = YES;
    }
  }
}

- (BOOL)showsPullToRefresh {
  return !self.pullToRefreshView.hidden;
}

@end

#pragma mark - SVPullToRefresh
@implementation SVPullToRefreshView

// public properties
@synthesize pullToRefreshActionHandler;

@synthesize state = _state;
@synthesize scrollView = _scrollView;
@synthesize showsPullToRefresh = _showsPullToRefresh;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    
    // default styling values
    self.state = SVPullToRefreshStateStopped;
//    self.titles = [NSMutableArray arrayWithObjects:NSLocalizedString(@"Pull to refresh",),
//                   NSLocalizedString(@"Release to refresh",),
//                   NSLocalizedString(@"Refreshing",),
//                   nil];
    self.titles = [NSMutableArray arrayWithObjects:@"下拉刷新", @"释放立即刷新", @"正在刷新", nil];
    self.viewForState = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
  }
  
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  if (self.superview && newSuperview == nil) {
    //use self.superview, not self.scrollView. Why self.scrollView == nil here?
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if (scrollView.showsPullToRefresh) {
      if (self.isObserving) {
        //If enter this branch, it is the moment just before "SVPullToRefreshView's dealloc", so remove observer here
        [scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [scrollView removeObserver:self forKeyPath:@"frame"];
        self.isObserving = NO;
      }
    }
  }
}

- (void)layoutSubviews
{
  for(id otherView in self.viewForState) {
    if([otherView isKindOfClass:[UIView class]])
      [otherView removeFromSuperview];
  }
  
  id customView = [self.viewForState objectAtIndex:self.state];
  BOOL hasCustomView = [customView isKindOfClass:[UIView class]];
  
  self.titleLabel.hidden = hasCustomView;
  
  if(hasCustomView) {
    [self addSubview:customView];
    CGRect viewBounds = [customView bounds];
    CGPoint origin = CGPointMake(roundf((self.bounds.size.width-viewBounds.size.width)/2), roundf((self.bounds.size.height-viewBounds.size.height)/2));
    [customView setFrame:CGRectMake(origin.x, origin.y, viewBounds.size.width, viewBounds.size.height)];
  }
  else {
    self.titleLabel.text = [self.titles objectAtIndex:self.state];
    switch (self.state) {
      case SVPullToRefreshStateStopped:
        [self.activityIndicatorView stopAnimation];
        break;
        
      case SVPullToRefreshStateTriggered:
        //                [self rotateArrow:(float)M_PI hide:NO];
        break;
        
      case SVPullToRefreshStateLoading:
        [self.activityIndicatorView startRotateAnimation];
        //                [self rotateArrow:0 hide:YES];
        break;
    }
  }
}

#pragma mark - Scroll View
- (void)resetScrollViewContentInset {
  UIEdgeInsets currentInsets = self.scrollView.contentInset;
  currentInsets.top = self.originalTopInset;
  [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForLoading {
  CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0);
  UIEdgeInsets currentInsets = self.scrollView.contentInset;
  currentInsets.top = MIN(offset, self.originalTopInset + self.bounds.size.height);
  [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
  [UIView animateWithDuration:0.3
                        delay:0
                      options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                   animations:^{
                     self.scrollView.contentInset = contentInset;
                   }
                   completion:NULL];
}

#pragma mark - Observing
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if([keyPath isEqualToString:@"contentOffset"])
    [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
  else if([keyPath isEqualToString:@"frame"])
    [self layoutSubviews];
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset {
  if(self.state != SVPullToRefreshStateLoading) {
    
    CGFloat scrollOffsetThreshold = self.frame.origin.y-self.originalTopInset;
    
    CGFloat yOffset = contentOffset.y;
    CGFloat progress = ((yOffset + self.originalTopInset) / - SVPullToRefreshViewHeight);
    [self.activityIndicatorView drawPathAnimation:progress];
    if(!self.scrollView.isDragging && self.state == SVPullToRefreshStateTriggered) {
      self.state = SVPullToRefreshStateLoading;
    } else if(contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging && self.state == SVPullToRefreshStateStopped) {
      self.state = SVPullToRefreshStateTriggered;
    } else if(contentOffset.y >= scrollOffsetThreshold && self.state != SVPullToRefreshStateStopped) {
      self.state = SVPullToRefreshStateStopped;
    }
  } else {
    CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
    offset = MIN(offset, self.originalTopInset + self.bounds.size.height);
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
  }
}

#pragma mark - Getters
- (TZXActivityIndicatorView *)activityIndicatorView {
  if(!_activityIndicatorView) {
    _activityIndicatorView = [[TZXActivityIndicatorView alloc] initWithFrame:CGRectMake(110.0f, 10.0f, 20.0f, 20.0f)];
    [self addSubview:_activityIndicatorView];
  }
  return _activityIndicatorView;
}

- (UILabel *)titleLabel {
  if(!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(135.0f, 10.0f, 102.0f, 20.0f)];
    _titleLabel.text = NSLocalizedString(@"Pull to refresh",);
    _titleLabel.font = UIFontOfSize(14.0f);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor colorWithRed:59.0f/255.0f green:61.0f/255.0f blue:65.0f/255.0f alpha:1.0f];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}

#pragma mark - Setters
- (void)setTitle:(NSString *)title forState:(SVPullToRefreshState)state {
  if(!title)
    title = @"";
  if(state == SVPullToRefreshStateAll)
    [self.titles replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:@[title, title, title]];
  else
    [self.titles replaceObjectAtIndex:state withObject:title];
  
  [self setNeedsLayout];
}

- (void)setCustomView:(UIView *)view forState:(SVPullToRefreshState)state {
  id viewPlaceholder = view;
  
  if(!viewPlaceholder)
    viewPlaceholder = @"";
  
  if(state == SVPullToRefreshStateAll)
    [self.viewForState replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:@[viewPlaceholder, viewPlaceholder, viewPlaceholder]];
  else
    [self.viewForState replaceObjectAtIndex:state withObject:viewPlaceholder];
  
  [self setNeedsLayout];
}

#pragma mark -

- (void)triggerRefresh {
  [self.scrollView triggerPullToRefresh];
}

- (void)startAnimating {
  if(fequalzero(self.scrollView.contentOffset.y)) {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -self.frame.size.height) animated:YES];
    self.wasTriggeredByUser = NO;
  } else {
    self.wasTriggeredByUser = YES;
  }
  self.state = SVPullToRefreshStateLoading;
}

- (void)stopAnimating {
  self.state = SVPullToRefreshStateStopped;
  if(!self.wasTriggeredByUser && self.scrollView.contentOffset.y < -self.originalTopInset)
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -self.originalTopInset) animated:YES];
}

- (void)setState:(SVPullToRefreshState)newState {
  
  if(_state == newState)
    return;
  
  SVPullToRefreshState previousState = _state;
  _state = newState;
  
  [self setNeedsLayout];
  
  switch (newState) {
    case SVPullToRefreshStateStopped:
      [self resetScrollViewContentInset];
      break;
      
    case SVPullToRefreshStateTriggered:
      break;
      
    case SVPullToRefreshStateLoading:
      [self setScrollViewContentInsetForLoading];
      
      if(previousState == SVPullToRefreshStateTriggered && pullToRefreshActionHandler)
        pullToRefreshActionHandler();
      
      break;
  }
}

@end
