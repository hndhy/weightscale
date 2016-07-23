//
//  KcalViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "KcalViewController.h"

@implementation KcalViewController

- (void)initNavbar
{
  self.title = @"基础代谢";
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
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kcal_1_2.0"]];
    imageView.top = 20.0f;
    imageView.centerX = scrollView.centerX;
    [scrollView addSubview:imageView];
    
    
    NSString *befor = @"很多减肥的人都有过越减越胖的经历（如上图所示）。这是因为他们的基础代谢被破坏了。";
    NSString *next1 = @"基础代谢指的是维持体温以及呼吸、心脏等生命活动所必须的能量消耗。";
    NSString *next2 = @"即使在24小时一动不动的情况下，也要消耗的能量。";
    NSString *str = [NSString stringWithFormat:@"%@%@%@",befor,next1,next2];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:befor]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString: next1]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:next2]];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, imageView.bottom + 10, scrollView.width - 40.0f, 0)
                                          withSize:15.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.attributedText = text;
    [label sizeToFit];
    [scrollView addSubview:label];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kcal_2_2.0"]];
    imageView.top = label.bottom + 10.0f;
    imageView.centerX = scrollView.centerX;
    [scrollView addSubview:imageView];
    
    label = [UILabel createLabelWithFrame:CGRectMake(20.0f, imageView.bottom + 10, scrollView.width - 40.0f, 0)
                                          withSize:15.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.text = @"基础代谢的分布如下图所示，同等重量的肌肉和脂肪对热量的消耗比是10:1";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kcal_3_2.0"]];
    imageView.top = label.bottom + 15.0f;
    imageView.centerX = scrollView.centerX;
    [scrollView addSubview:imageView];
    
    scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom + 40.0f);
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, imageView.bottom+20);
    
    
/*
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  scrollView.scrollsToTop = NO;
  [self.view addSubview:scrollView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                        withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
  label.text = @"肌肉的维持、增加，与基础代谢有密切的关 系。下面介绍基础代谢率。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:18.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"维持体温以及呼吸、心脏等生命活动所必 须的能量消耗称为基础代谢。即使在24 小时一动不动的情况下，也要消耗与该基 础代谢相当的";
  [label sizeToFit];
  [scrollView addSubview:label];
  view.height = label.height + 16.0f;
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 16.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.textAlignment = NSTextAlignmentCenter;
  label.text = @"基础代谢占1 天总能量消耗的6~7 成";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kcal_1.png"]];
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  CGFloat top = imageView.bottom;
  imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kcal_2.png"]];
  imageView.top = top + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, imageView.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:[UIColor grayColor]];
  label.numberOfLines = 0;
  label.text = @"能量消耗的大致情况是，基础代谢占6~7成、日常活动代谢占2~3 成、进食产热效应占1成。由此可以看出，基础代谢是主要的能量消耗。当1 天的进食量超过“基础代谢+ 日常活动代谢+进食产热效应”时，多余的能量将以脂肪形式蓄积在体内。";
  [scrollView addSubview:label];
  [label sizeToFit];
  label = [UILabel createLabelWithFrame:CGRectMake(20.0f, label.bottom + 10.0f, scrollView.width - 40.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
  label.text = @"如何应对基础代谢随着年龄的增长逐渐减少的问题？";
  [label sizeToFit];
  [scrollView addSubview:label];
  view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:18.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"基础代谢在十几岁的后半期达到峰值之后将会逐年减少。这是因为随着年龄的增长，身体机能会逐渐下降，其中肌肉（骨骼肌）量的减少是主要原因。即使身体肌肉不做任何运动，在1 天内也要消耗一定的能量并发出热量。这些热量对基础代谢的“体温维持”发挥作用。如果肌肉量减少，则1天内的能量消耗也会减少。如果在基础代谢下降的情况下仍然保持和年轻时一样的饮食习惯，则会产生“中年肥胖”的后果。为了避免上述情况的发生，我们应该了解自己的基础代谢，并以坚持运动来维持和增加肌肉（骨骼肌）量。";
  [label sizeToFit];
  [scrollView addSubview:label];
  view.height = label.height + 16.0f;
  scrollView.contentSize = CGSizeMake(scrollView.width, view.bottom + 10.0f);
 */
 }

@end
