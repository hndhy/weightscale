//
//  WeightViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/19.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "WeightViewController.h"

@interface WeightViewController ()

@end

@implementation WeightViewController

- (void)initNavbar
{
    self.title = @"体重";
}

- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, 90);
    layer.cornerRadius = 5;
    layer.borderWidth = 0.5;
    layer.borderColor = UIColorFromRGB(229, 229, 229).CGColor;
    [scrollView.layer addSublayer:layer];
    
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weight_2.0"]];
    imageView.top = 20.0f;
    imageView.centerX = scrollView.centerX;
    
    [scrollView addSubview:imageView];
    scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom + 40.0f);
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, imageView.bottom+20);
    
}

@end
