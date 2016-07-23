  //
  //  HTNavigationBar.m
  //  HereTravel
  //
  //  Created by liumadu on 15/5/30.
  //  Copyright (c) 2015年 lmd. All rights reserved.
  //

#import "HTNavigationBar.h"

#import "CommonHelper.h"
#import "VersionMacro.h"

static CGFloat const kSpaceToCoverStatusBars = 20.0f;

@interface HTNavigationBar ()

@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, assign) HTBarStyle style;

@end

@implementation HTNavigationBar

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
      self.statusImageView = [[UIImageView alloc] init];
      [self drawStatusBar];
      [self addSubview:self.statusImageView];
    }
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  [[UIImage imageNamed:@"blue_nav_bar.png"] drawInRect:rect];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  if (self.statusImageView) {
    self.statusImageView.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), kSpaceToCoverStatusBars);
  }
}

- (void)changeBarStyle:(HTBarStyle)barStyle
{
  if (barStyle != self.style && self.statusImageView) {
    self.style = barStyle;
    [self drawStatusBar];
    [self  setNeedsDisplay];
  }
}

- (void)drawStatusBar
{
  self.statusImageView.image = [UIImage imageNamed:@"blue_status_bar.png"];
}

@end
