//
//  FatViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "FatViewController.h"

@implementation FatViewController

- (void)initNavbar
{
  self.title = @"体脂率";
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
    
    NSString *befor = @"体脂率是指人体内脂肪重量在人体总体重中所占的比例。";
    NSString *next1 = @"脂肪分为皮下脂肪和内脏脂肪，其含量的多少跟身材的健美程度和身体的健康程度都直接相关。下图为不同体脂率对应的身材示例图。";
    NSString *str = [NSString stringWithFormat:@"%@%@",befor,next1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:next1]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString:befor]];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                          withSize:18.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.attributedText = text;
    [label sizeToFit];
    [scrollView addSubview:label];
    
    label = [UILabel createLabelWithFrame:CGRectMake(20.0f, label.bottom + 5, scrollView.width - 40.0f, 0)
                                          withSize:12.0f withColor:[UIColor redColor]];
    label.numberOfLines = 0;
    label.text = @"【脂肪与身体健康程度的关联，请参考“内脂”解说】";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    label = [UILabel createLabelWithFrame:CGRectMake(20.0f, label.bottom + 5, scrollView.width - 40.0f, 0)
                                 withSize:15.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.text = @"体脂率还应结合肌肉率指标共同参考。";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    
    HTUserData *user = [HTUserData sharedInstance];
    
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:user.sex ? @"fat_explain_2.0":@"fat_explain_2.0_w"]];
    imageView.top = label.bottom + 10.0f;
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
  label.text = @"根据身体脂肪在体内位置的不同，可以分为皮下脂肪和内脏脂肪。身体脂肪率是指全部脂肪的重量在体重中所占的比例。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"身体脂肪率（%） ＝（身体脂肪的重量(kg) ÷ 体重(kg)) x 100 (%)";
  label.textAlignment = NSTextAlignmentCenter;
  [label sizeToFit];
  [scrollView addSubview:label];
  view.height = label.height + 16.0f;
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, view.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
//  label.text = @"男性女性不同年龄的身体脂肪率判定标准不同";
//      label.text = @"身体脂肪率高低还应该结合肌肉率等其它指标综合判定一个人是否健康";
    label.text = @"体脂肪率过高不好，低于正常水平则不一定就是不好，因为还要根据肌肉量进行判定。比如很多运动员都是肌肉量较高，而体脂较低。";
//  label.textAlignment = NSTextAlignmentCenter;
  [label sizeToFit];
  [scrollView addSubview:label];
  HTUserData *userData = [HTUserData sharedInstance];
     */
    /*
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(128.0f, 134.0f, 137.0f)];
  label.numberOfLines = 0;
  float tmpFat = 0;
  int age = userData.age;
  if (1 == userData.sex) {
    if (age <= 33) {
      tmpFat = 19.3f;
    } else if (age >= 34 && age <= 49) {
      tmpFat = 22.5f;
    } else if (age >= 50) {
      tmpFat = 24.5f;
    }
  } else {
    if (age <= 33) {
      tmpFat = 32.5f;
    } else if (age >= 34 && age <= 49) {
      tmpFat = 35.1f;
    } else if (age >= 50) {
      tmpFat = 36.1f;
    }
  }
  label.text = [NSString stringWithFormat:@"您距离理想体脂率还差%0.1f%@", fabs(tmpFat - self.fat), @"%"];
  label.textAlignment = NSTextAlignmentCenter;
  [label sizeToFit];
  [scrollView addSubview:label];*/
    /*
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(153.0f, 209.0f, 234.0f)];
  label.numberOfLines = 0;
  label.text = @"一提到身体脂肪总是给人以不好的印象，其实身体脂肪具有储存能量、保护内脏等各种作用。体脂肪过多自然不好，但过少也不利于身体健康。由于男性和女性的身体脂肪分布不同，所以判定标准也不同。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIImageView *imageView = nil;
  if (0 == userData.sex) {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fat_new_2.png"]];
  } else {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fat_new_1.png"]];
  }
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
    
  [scrollView addSubview:imageView];
  scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom + 10.0f);
     */
}

@end
