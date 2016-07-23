//
//  WaterViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/19.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "WaterViewController.h"

@interface WaterViewController ()

@end

@implementation WaterViewController


- (void)initNavbar
{
    self.title = @"体水分";
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
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"water_2.0"]];
    imageView.top = 20.0f;
    imageView.centerX = scrollView.centerX;
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, imageView.bottom + 10.0f, scrollView.width - 40.0f, 0)
                                          withSize:14.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
//    label.text = @"肌肉里70%都是水分，充足的水分是增肌减脂不可或缺的条件.\n没有水的参与脂肪率不会变小，每公斤体重每天要保证摄入50ml水，但一般建议不要超过4000ml/天，因为肾代谢不了会出问题.";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    [scrollView addSubview:imageView];
    scrollView.contentSize = CGSizeMake(scrollView.width, label.bottom + 40.0f);
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, label.bottom+20);
    
}

@end
