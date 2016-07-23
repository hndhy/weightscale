//
//  TZXActivityIndicatorView.h
//  HYCircleLoadingViewExample
//
//  Created by liumadu on 14-11-3.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZXActivityIndicatorView : UIView

//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;
//default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, readonly) BOOL isAnimating;

//use this to init
- (id)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
- (void)drawPathAnimation:(CGFloat)progress;
- (void)startRotateAnimation;

@end
