//
//  BodyAgeViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BodyAgeViewController.h"

@implementation BodyAgeViewController

- (void)initNavbar
{
  self.title = @"身体年龄";
}

- (void)initView
{
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  scrollView.scrollsToTop = NO;
  [self.view addSubview:scrollView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                        withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
  label.text = @"身体年龄是从基础代谢的角度显示您身体的 实际年龄。“身体年龄”是为综合评价自己 “身体”状况的一个标准。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:18.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
//  label.text = @"身体年龄是以基础代谢为基础计算出的 身体年龄。而基础代谢是在综合体重、 身体脂肪率等多种指数后得出的，所以 身体年龄是一个高于";
    label.text = @"身体年龄是以基础代谢为基础计算的身体年龄。而基础代谢是在综合体重、身体脂肪率等多种指数后得出的";
  [label sizeToFit];
  [scrollView addSubview:label];
  view.height = label.height + 16.0f;
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 16.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"即使测量者的身高、体重都一样，因身体 成分和基础代谢量的不同也会导致身体年 龄上的差异";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"body_age.png"]];
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  label = [UILabel createLabelWithFrame:CGRectMake(0, imageView.bottom + 10.0f, scrollView.width, 0)
                               withSize:12.0f withColor:[UIColor grayColor]];
  label.numberOfLines = 0;
  label.text = @"（例） A：实际年龄30 岁、身高158 cm、体重54.8 kg";
  label.textAlignment = NSTextAlignmentCenter;
  [scrollView addSubview:label];
  [label sizeToFit];
  scrollView.contentSize = CGSizeMake(scrollView.width, label.bottom + 5.0f);
}

@end
