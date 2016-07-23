//
//  TZXActivityIndicatorView.m
//  HYCircleLoadingViewExample
//
//  Created by liumadu on 14-11-3.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "TZXActivityIndicatorView.h"

#define ANGLE(a) 2*M_PI/360*a

@interface TZXActivityIndicatorView ()

//0.0 - 1.0
@property (nonatomic, assign) CGFloat anglePer;

@end

@implementation TZXActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (id)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)setAnglePer:(CGFloat)anglePer
{
  _anglePer = anglePer;
  [self setNeedsDisplay];
}

- (void)startAnimation
{
  if (self.isAnimating) {
    [self stopAnimation];
    [self.layer removeAllAnimations];
  }
  _isAnimating = YES;
  self.anglePer = 0;
}

- (void)stopAnimation
{
  _isAnimating = NO;
  [self stopRotateAnimation];
}

- (void)drawPathAnimation:(CGFloat)progress;
{
  self.anglePer = progress;
  if (self.anglePer >= 1) {
    self.anglePer = 1;
  }
}

- (void)startRotateAnimation
{
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  animation.fromValue = @(0);
  animation.toValue = @(2*M_PI);
  animation.duration = 1.f;
  animation.repeatCount = INT_MAX;
  
  [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
  [UIView animateWithDuration:0.3f animations:^{
    self.alpha = 0;
  } completion:^(BOOL finished) {
    self.anglePer = 0;
    [self.layer removeAllAnimations];
    self.alpha = 1;
  }];
}

- (void)drawRect:(CGRect)rect
{
  if (self.anglePer <= 0) {
    _anglePer = 0;
  }
  CGFloat lineWidth = 1.0f;
  UIColor *lineColor = [UIColor colorWithRed:243.0f/255.0f green:96.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
  if (self.lineWidth) {
    lineWidth = self.lineWidth;
  }
  if (self.lineColor) {
    lineColor = self.lineColor;
  }
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, lineWidth);
  CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
  CGContextAddArc(context,
                  CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                  CGRectGetWidth(self.bounds)/2-lineWidth,
                  ANGLE(60), ANGLE(400)*self.anglePer,
                  0);
  
//  ANGLE(120), ANGLE(120)+ANGLE(330)*self.anglePer,
  CGContextStrokePath(context);
}

@end
