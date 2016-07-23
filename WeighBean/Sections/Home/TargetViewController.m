//
//  TargetViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "TargetViewController.h"

@implementation TargetViewController

- (void)initNavbar
{
  self.title = @"您属于哪种体型";
}

- (void)initView
{
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  scrollView.scrollsToTop = NO;
  [self.view addSubview:scrollView];
  int index = 1;
  int tmpFat = [self calculateFat:self.fat];
  int tmpBMI = [self calculateBMI:self.bmi];
  if (tmpBMI >= 3 && tmpFat >= 3) {
    index = 1;
  } else if (tmpBMI <= 2 && tmpFat >= 3) {
    index = 2;
  } else if (tmpBMI <= 1 && tmpFat <= 2) {
    index = 3;
  } else if (tmpBMI == 2 && tmpFat <= 2) {
    index = 4;
  } else if (tmpBMI >= 3 && tmpFat <= 2) {
    index = 5;
  }
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"target_%d.png", index]]];
  imageView.top = 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, imageView.bottom + 10.0f, scrollView.width, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  label.text = @"*1 BMI 较低、身体脂肪率较高的“隐形肥胖”";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(5.0f, label.bottom + 10.0f, scrollView.width - 10.0f, 0)
                                        withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"体重在标准以下、身体脂肪所占比例较多的类型。\n脂肪较多，肌肉、血液、骨骼等成分所占的比例较少。如果持续下去则会导致身体机能衰退，损害健康。这种类型的人从外表上是无法看出来的，所以本人很难意识到。如果缺少运动或反复进行节食等极端的减肥活动，即使进食量不多，热量也很容易转变成脂肪。所以平时应该注意膳食的平衡并养成运动的习惯。";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(0, label.bottom + 10.0f, scrollView.width, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  label.text = @"*2 BMI 较高、身体脂肪率较低的“肌肉性肥胖”型”";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(5.0f, label.bottom + 10.0f, scrollView.width - 10.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(96.0f, 97.0f, 99.0f)];
  label.numberOfLines = 0;
  label.text = @"外表看起来很胖，但脂肪处于标准或标准以下。这种类型的人员多是经常进行运动或从事运动量较大的工作。\n当前的状态没有任何问题。但是如果一旦停止运动，而仍然延续原来的饮食习惯，则相对于运动量来说摄取的热量就会过高。同时，以前蓄积的肌肉减少，取而代之的是脂肪的不断增加，这样就可能会迅速变得肥胖。在运动量减少后要注意饮食习惯。";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(5.0f, label.bottom + 10.0f, scrollView.width - 10.0f, 0)
                               withSize:20.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
  label.text = @"■ 不合理的瘦身反而会容易增重";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(5.0f, label.bottom + 10.0f, scrollView.width - 10.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"如果不运动一味地通过节食来减轻体重而不重视营养平衡，即使体重下降，基础代谢也会随着肌肉（骨骼肌）的减少而降低，反而变为更容易肥胖的体质。";
  [label sizeToFit];
  [scrollView addSubview:label];
  imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"target_6.png"]];
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  label = [UILabel createLabelWithFrame:CGRectMake(0, imageView.bottom + 10.0f, scrollView.width, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  label.text = @"为了不导致反弹，通过增加骨骼肌，提高基础代谢的方式来塑造不易肥胖的体质MI 较低、身体脂肪率较高的“隐形肥胖”";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(5.0f, label.bottom + 10.0f, scrollView.width - 10.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(96.0f, 97.0f, 99.0f)];
  label.numberOfLines = 0;
  label.text = @"过度的减肥最容易导致体重的反弹。体重反弹时，内脏脂肪比皮下脂肪更容易聚积在体内。内脏脂肪是导致生活习惯病的主要原因。正是由于体重的反复反弹才导致出现内脏脂肪型肥胖。";
  [label sizeToFit];
  [scrollView addSubview:label];
  scrollView.contentSize = CGSizeMake(scrollView.width, label.bottom + 10.0f);
}

//10~33	5.0%~8.5%	8.6%~19.3%	19.4%~25.0%	25.1%~50.0%
- (int)calculateFat:(float)fat
{
  int tmpInt = 0;
  HTUserData *userData = [HTUserData sharedInstance];
  int age = userData.age;
  int sex = userData.sex;
  if (0 == sex) {
    if (age >= 10 && age <= 33) {
      if (fat >= 5.0f && fat <= 20.8) {
        tmpInt = 1;
      } else if (fat >= 20.9 && fat <= 32.5) {
        tmpInt = 2;
      } else if (fat >= 32.6 && fat <= 38.2) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    } else if (age >= 34&& age >= 49) {
      if (fat >= 5.0f && fat <= 23.4) {
        tmpInt = 1;
      } else if (fat >= 23.5 && fat <= 35.1) {
        tmpInt = 2;
      } else if (fat >= 35.2 && fat <= 40.8) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    }else {
      if (fat >= 5.0f && fat <= 24.4) {
        tmpInt = 1;
      } else if (fat >= 24.5 && fat <= 36.1) {
        tmpInt = 2;
      } else if (fat >= 36.2 && fat <= 41.8) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    }
  } else {
    if (age >= 10 && age <= 33) {
      if (fat >= 5.0f && fat <= 8.5) {
        tmpInt = 1;
      } else if (fat >= 8.6 && fat <= 19.3) {
        tmpInt = 2;
      } else if (fat >= 19.4 && fat <= 25.0) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    } else if (age >= 34&& age >= 49) {
      if (fat >= 5.0f && fat <= 11.7) {
        tmpInt = 1;
      } else if (fat >= 11.8 && fat <= 22.5) {
        tmpInt = 2;
      } else if (fat >= 22.6 && fat <= 27.6) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    } else {
      if (fat >= 5.0f && fat <= 13.7) {
        tmpInt = 1;
      } else if (fat >= 13.8 && fat <= 24.5) {
        tmpInt = 2;
      } else if (fat >= 24.6 && fat <= 30.2) {
        tmpInt = 3;
      } else {
        tmpInt = 4;
      }
    }
  }
  return tmpInt;
}

- (int)calculateBMI:(float)bmi
{
  int tmpInt = 0;
  if (bmi <= 18.4) {
    tmpInt = 1;
  } else if (bmi >=18.5 && bmi <= 24.9f) {
    tmpInt = 2;
  } else if (bmi >= 25.0f && bmi <= 29.9) {
    tmpInt = 3;
  } else {
    tmpInt = 4;
  }
  return tmpInt;
}

@end
