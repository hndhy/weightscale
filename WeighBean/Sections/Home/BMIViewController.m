//
//  BMIViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BMIViewController.h"

@implementation BMIViewController

- (void)initNavbar
{
  self.title = @"BMI";
}

- (void)initView
{
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
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20, scrollView.width - 40.0f, 0)
                                          withSize:14.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.text = @"体重指数BMI等于体重（千克）除以身高（米）的平方。";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bmi_1_2.0"]];
    imageView.top = label.bottom + 10.0f;
    imageView.centerX = scrollView.centerX;
    [scrollView addSubview:imageView];
    
    label = [UILabel createLabelWithFrame:CGRectMake(20.0f, imageView.bottom + 10, scrollView.width - 40.0f, 0)
                                          withSize:14.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.text = @"同样的BMI可能代表人体的状态是不一样的，还需要结合体脂率指标综合考量";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    NSString *name = [NSString stringWithFormat:@"bmi_2_2.0_%d.png", index];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
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
  label.text = @"Body Mass Index」（＝体格指数）的开头字母“B・M・I”的缩写，它是判断肥胖的国际标准。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"BMI ＝\n体重(kg) ÷ 身高(m) ÷ 身高(m)";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 16.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
  HTUserData *userData = [HTUserData sharedInstance];
  int height = userData.height;
  [NSString stringWithFormat:@"理想体重是BMI 为“22”时的体重\n您的理想体重是%0.1f公斤。", 22 * (height / 100.0f) * (height / 100.0f)];
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 20.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(153.0f, 209.0f, 234.0f)];
  label.numberOfLines = 0;
  label.text = @"由于BMI 是根据身高和体重求得的，所以对于那些因肌肉多而体重较重的运动员并不能做出正确判定。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bmi.png"]];
  imageView.top = label.bottom + 20.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom);
    */
}
//10~33	5.0%~8.5%	8.6%~19.3%	19.4%~25.0%	25.1%~50.0%
- (int)calculateFat:(float)fat
{
    /*
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
        } else if (age >= 34&& age <= 49) {
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
     */
    int tmpInt = 0;
    HTUserData *userData = [HTUserData sharedInstance];
    int sex = userData.sex;
    if (0 == sex) {
        if (fat<17.0) {
            tmpInt = 1;
        } else if (fat >= 17.0 && fat <= 23.0) {
            tmpInt = 2;
        }else {
            tmpInt = 3;
        }
        
    } else {
        if (fat<10) {
            tmpInt = 1;
        } else if (fat >= 10.0 && fat <= 17.0) {
            tmpInt = 2;
        }else {
            tmpInt = 3;
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
