//
//  HLoadingView.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/1.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HLoadingView.h"
#import "UtilsMacro.h"
#import "AppDelegate.h"
#import "UIView+Ext.h"
#import "ZouMaDengInfoModel.h"
#import <UIImageView+WebCache.h>
#import "UILabel+Ext.h"

static HLoadingView *__loading = nil;
@implementation HLoadingView

+ (instancetype)defaultView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __loading = [[HLoadingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return __loading;
}

+ (void)show
{
    HLoadingView *view = [HLoadingView defaultView];
    [view startTimer];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window addSubview:view];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.array = [[NSMutableArray alloc] init];
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"zoumadeng_loading"];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        NSLog(@"array = %@",array);
        [self.array addObjectsFromArray:array];
        
        BOOL isPreiOS7 = kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_7_0;
        CGFloat maxY = isPreiOS7 ? 0 : 20;

        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0,maxY,self.width, 64.0f - maxY)];
        _titleView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        _titleView.textColor = [UIColor whiteColor];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleView];
        
        UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(18, _titleView.bottom + 10, 150, 20)];
        tip.font = [UIFont systemFontOfSize:12];
        tip.textColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        tip.text = @"TP:数据同步中，请稍等...";
        [self addSubview:tip];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(18.0f, tip.bottom + 10, self.width - 36.0f, 217.0f)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 8.0f;
        bgView.layer.masksToBounds = YES;
        bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        [self addSubview:bgView];
        
        if (!array.count)
        {
            bgView.hidden = YES;
        }
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bgView.left + 32.0f, bgView.top + 17.0f, 112.0f, 167.0f)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.array.count, self.scrollView.height);
        [self addSubview:self.scrollView];
        
        self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(self.scrollView.right, bgView.top, bgView.width - self.scrollView.right,
                                                                   bgView.height) withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        int len = (int)[self.array count];
        self.dotArray = [NSMutableArray arrayWithCapacity:len];
        CGFloat left = (self.width - 10.0f * len - 10.0f * (len - 1)) / 2.0f;
        for (int i = 0; i < len; i++)
        {
            ZouMaDengInfoModel *model = [self.array objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.scrollView.width, 0,
                                                                                   self.scrollView.width, self.scrollView.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
            imageView.backgroundColor = [UIColor grayColor];
            [self.scrollView addSubview:imageView];
            UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(left, bgView.bottom - 24.0f, 8.0f, 8.0f)];
            if (i == 0)
            {
                self.titleLabel.text = model.title;
                dotView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
            }
            else
            {
                dotView.backgroundColor = UIColorFromRGB(229.0f, 229.0f, 229.0f);
            }
            dotView.layer.cornerRadius = 4.0f;
            dotView.layer.masksToBounds = YES;
            [self addSubview:dotView];
            [self.dotArray addObject:dotView];
            left = dotView.right + 10.0f;
        }
        
        _backLayer = [CALayer layer];
        _backLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        _backLayer.frame = CGRectMake(bgView.left + 10, bgView.bottom + 20, bgView.width - 20, 8);
        _backLayer.cornerRadius = 4;
        _backLayer.masksToBounds = YES;
        [self.layer addSublayer:_backLayer];
        
        _loadLayer = [CALayer layer];
        _loadLayer.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f).CGColor;
        _loadLayer.frame = CGRectMake(bgView.left + 10, bgView.bottom + 20, bgView.width/10, 8);
        _loadLayer.cornerRadius = 4;
        _loadLayer.masksToBounds = YES;
        [self.layer addSublayer:_loadLayer];
        
        _loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_backLayer.frame), CGRectGetMaxY(_backLayer.frame) + 5, 100, 20)];
        _loadLabel.font = [UIFont systemFontOfSize:12];
        _loadLabel.textColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        _loadLabel.text = @"已同步0%";
        [self addSubview:_loadLabel];
        
    }
    return self;
}

- (void)startTimer
{
    CGFloat maxWidth = self.width - 56.0f;
    CGRect rect = _loadLayer.frame;
    rect.size.width = maxWidth*_progress/100.f;
    _loadLayer.frame = rect;
    _loadLabel.text = [NSString stringWithFormat:@"已同步%.0f%@",_progress,@"%"];
    
    [self.timer invalidate];
    self.timer = nil;
    [self.loadTimer invalidate];
    self.loadTimer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(incrementOffset) userInfo:nil repeats:YES];
    self.loadTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(loadAction) userInfo:nil repeats:YES];
}

- (void)setTitle:(NSString *)title
{
    _titleView.text = title;
    _title = title;
}

- (void)incrementOffset
{
    if (!self.superview)
    {
        return;
    }
    self.dotIndex++;
    int len = (int)[self.dotArray count];
    if (self.dotIndex >= len)
    {
        self.dotIndex = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.dotIndex * self.scrollView.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.dotIndex != page)
    {
        if (page < 0 || page > [self.dotArray count])
        {
            return;
        }
        UIView *oldView = [self.dotArray objectAtIndex:self.dotIndex];
        oldView.backgroundColor = UIColorFromRGB(229.0f, 229.0f, 229.0f);
        UIView *newView = [self.dotArray objectAtIndex:page];
        ZouMaDengInfoModel *model = [self.array objectAtIndex:page];
        self.titleLabel.text = model.title;
        newView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        self.dotIndex = page;
    }
}

- (void)loadAction
{
    if (!self.superview)
    {
        return;
    }
    
    if (_progress == 80 && !_isFinish)
    {
        return;
    }
    
    self.progress += 20;
    
    CGFloat maxWidth = self.width - 56.0f;
    
    _loadLabel.text = [NSString stringWithFormat:@"已同步%.0f%@",_progress,@"%"];
    
    CGRect rect = _loadLayer.frame;
    rect.size.width = maxWidth*_progress/100.f;
    _loadLayer.frame = rect;
    
    if (_isFinish && _progress >= 100)
    {
        _progress = 0;
        _isFinish = NO;
        
        [_timer invalidate];
        _timer = nil;
        [_loadTimer invalidate];
        _loadTimer = nil;
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf removeFromSuperview];
        });
    }
}

@end
