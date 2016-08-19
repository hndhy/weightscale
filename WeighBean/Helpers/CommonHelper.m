//
//  CommonHelper.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CommonHelper.h"

#import "UIView+Ext.h"
#import "UILabel+Ext.h"
#import "UtilsMacro.h"
#import "NSDate+Utilities.h"
#import "MeasureInfoModel.h"
#import "State.h"
#import "HTUserData.h"

@implementation CommonHelper

+ (UIImage *)createImageWithColor:(UIColor *)color
{
  CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}

//创建播放，收藏，分享，喜欢，评论的小图标和文字
+ (UILabel *)addSmallIcon:(NSString *)icon left:(CGFloat)left centerY:(CGFloat)centerY text:(NSString *)text superview:(UIView *)superview
{
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
  iconImageView.left = left;
  iconImageView.centerY = centerY;
  [superview addSubview:iconImageView];
  UILabel *textLabel = [UILabel createLabelWithFrame:CGRectMake(iconImageView.right + 3.0f, 0, 46.0f, 12.0f) withSize:10.0f
                                           withColor:UIColorFromRGB(153.0f, 153.0f, 153.0f)];
  textLabel.text = text;
  textLabel.centerY = centerY;
  [superview addSubview:textLabel];
  return textLabel;
}

+ (NSString *)standardTimeWithDate:(NSDate *)date
{
  NSString *text = [[NSString alloc] init];
  NSInteger minuInterval = [date minutesBeforeDate:[NSDate date]];
  NSInteger min = [[[NSDate date] stringWithFormat:@"mm"] integerValue];
  NSInteger hour = [[[NSDate date] stringWithFormat:@"HH"] integerValue];
  NSInteger countMinu = hour *60 + min;
  NSInteger hourInterval = minuInterval / 60;
  if (countMinu < minuInterval) {
    if (hourInterval < 24) {
      text = [date stringWithFormat:@"昨天 HH:mm"];
    }else if (hourInterval > 24){
      text = [date stringWithFormat:@"MM-dd  HH:mm"];
    }
  }else if (countMinu >= minuInterval){
    if (minuInterval < 60) {
      if (0 == minuInterval) {
        text = @"刚刚";
      } else {
        text = [NSString stringWithFormat:@"%d分钟前", (int)minuInterval];
      }
    }else if (minuInterval >= 60){
      text = [NSString stringWithFormat:@"%d小时前", (int)hourInterval];
    }
  }
  return text;
}

+ (NSString *)DecToHex4:(int)value
{
  NSString *tmp = [NSString stringWithFormat:@"%X", value];
  int i = 4 - tmp.length;
  if (0 == i) {
    return tmp;
  } else if (1 == i) {
    return [NSString stringWithFormat:@"0%@", tmp];
  } else if (2 == i) {
    return [NSString stringWithFormat:@"00%@", tmp];
  } else if (3 == i) {
    return [NSString stringWithFormat:@"000%@", tmp];
  } else {
    return @"0000";
  }
}

+ (NSString *)DecToHexH4:(int)value
{
  NSString *tmp = [NSString stringWithFormat:@"%X", value];
  int i = 4 - tmp.length;
  if (0 == i) {
    return tmp;
  } else if (1 == i) {
    return [NSString stringWithFormat:@"%@0", tmp];
  } else if (2 == i) {
    return [NSString stringWithFormat:@"%@00", tmp];
  } else if (3 == i) {
    return [NSString stringWithFormat:@"%@000", tmp];
  } else {
    return @"0000";
  }
}

+ (NSString *)DecToHex2:(int)value
{
  NSString *tmp = [NSString stringWithFormat:@"%X", value];
  int i = 2 - tmp.length;
  if (0 == i) {
    return tmp;
  } else if (1 == i) {
    return [NSString stringWithFormat:@"0%@", tmp];
  } else {
    return @"00";
  }
}

+ (int)HexToDec:(NSString *)value
{
  int len = value.length;
  double sum = 0;
  int powNum = len;
  for (int i = 0; i < len; i++) {
    NSString *tmp = [value substringWithRange:NSMakeRange(i, 1)];
    powNum--;
    sum += [CommonHelper HexToDec1:tmp] * pow (16, powNum);
  }
  return (int)sum;
}

+ (int)HexToDec1:(NSString *)value
{
  NSString *tmp = [value uppercaseString];
  if ([@"A" isEqualToString:tmp]) {
    return 10;
  } else if ([@"B" isEqualToString:tmp]) {
    return 11;
  } else if ([@"C" isEqualToString:tmp]) {
    return 12;
  } else if ([@"D" isEqualToString:tmp]) {
    return 13;
  } else if ([@"E" isEqualToString:tmp]) {
    return 14;
  } else if ([@"F" isEqualToString:tmp]) {
    return 15;
  } else {
    return [value intValue];
  }
}

+ (MeasureInfoModel *)parseValue:(NSString *)value
{
    NSInteger oldLength = [value rangeOfString:@"EB90024111"].length;
    BOOL isOld = oldLength > 0 ? YES : NO;
    MeasureInfoModel *infoModel = [[MeasureInfoModel alloc] init];
    infoModel.bmc = 0;
    NSString *tmpStr = [[value uppercaseString] substringFromIndex:12];
    NSLog(@"====>%@", tmpStr);
    if (tmpStr.length < 28 ) {
        return infoModel;
    }
    // 体重
    NSString *weightStr = [tmpStr substringWithRange:NSMakeRange(0, 4)];
    if ([@"FFFF" isEqualToString:weightStr]) {
        infoModel.weight = 0;
    } else {
        NSString *weightStr1 = [weightStr substringToIndex:2];
        NSString *weightSt2 = [weightStr substringFromIndex:2];
        infoModel.weight = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", weightSt2, weightStr1]] / 10.0f;
    }
    // 体脂率
    NSString *fatStr = [tmpStr substringWithRange:NSMakeRange(4, 4)];
    if ([@"FFFF" isEqualToString:fatStr]) {
        infoModel.fat = 61;
    } else {
        NSString *fatStr1 = [fatStr substringToIndex:2];
        NSString *fatStr2 = [fatStr substringFromIndex:2];
        infoModel.fat = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", fatStr2, fatStr1]] / 10.0f;
    }
    // BMI
    NSString *bmiStr = [tmpStr substringWithRange:NSMakeRange(8, 4)];
    if ([@"FFFF" isEqualToString:bmiStr]) {
        infoModel.bmi = 0;
    } else {
        NSString *bmiStr1 = [bmiStr substringToIndex:2];
        NSString *bmiStr2 = [bmiStr substringFromIndex:2];
        infoModel.bmi = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", bmiStr2, bmiStr1]] / 10.0f;
    }
    // 体水分
    NSString *tbwStr = [tmpStr substringWithRange:NSMakeRange(12, 4)];
    if ([@"FFFF" isEqualToString:tbwStr]) {
        infoModel.tbw = 0;
    } else {
        NSString *tbwStr1 = [tbwStr substringToIndex:2];
        NSString *tbwStr2 = [tbwStr substringFromIndex:2];
        infoModel.tbw = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", tbwStr2, tbwStr1]] / 10.0f;
    }
    // 内脂
    NSString *vatStr = [tmpStr substringWithRange:NSMakeRange(16, 2)];
    if ([@"FF" isEqualToString:vatStr]) {
        infoModel.vat = 0;
    } else {
    infoModel.vat = [CommonHelper HexToDec:vatStr];
    }
    // 肌肉量
    NSString *lbmStr = [tmpStr substringWithRange:NSMakeRange(18, 4)];
    if ([@"FFFF" isEqualToString:lbmStr]) {
        infoModel.lbm = 0;
    } else {
        NSString *lbmStr1 = [lbmStr substringToIndex:2];
        NSString *lbmStr2 = [lbmStr substringFromIndex:2];
        infoModel.lbm = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", lbmStr2, lbmStr1]] / 10.0f;
    }
    // 基础代谢
    NSString *kcalStr = [tmpStr substringWithRange:NSMakeRange(22, 4)];
    if ([@"FFFF" isEqualToString:kcalStr]) {
        infoModel.kcal = 0;
    } else {
        NSString *kcalStr1 = [kcalStr substringToIndex:2];
        NSString *kcalStr2 = [kcalStr substringFromIndex:2];
        infoModel.kcal = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", kcalStr2, kcalStr1]];
    }
    // 身体年龄
    NSString *bodyAgeStr = [tmpStr substringWithRange:NSMakeRange(26, 2)];
    if ([@"FF" isEqualToString:bodyAgeStr]) {
        infoModel.bodyAge = 0;
    } else {
        infoModel.bodyAge = [CommonHelper HexToDec:bodyAgeStr];
    }
    
    // 骨骼率
    NSString *boneMassStr = @"FFFF";
    if (tmpStr.length >= 36)
    {
       boneMassStr = [tmpStr substringWithRange:NSMakeRange(32, 4)];
    }
    
    if (![@"FFFF" isEqualToString:boneMassStr]&&!isOld) {
        NSString *boneMassStr1 = [boneMassStr substringToIndex:2];
        NSString *boneMassStr2 = [boneMassStr substringFromIndex:2];
        float boneMass = [CommonHelper HexToDec:[NSString stringWithFormat:@"%@%@", boneMassStr2, boneMassStr1]] / 10.0f;
//        NSLog(@"骨骼率 = %0.1f",boneMass);
        infoModel.smr = boneMass;
    }
    else
    {
        infoModel.smr = 0;
    }
  return infoModel;
}

+ (NSInteger )bodyAgeWithFat:(int)fat measureAge:(int)mage
{
    /*
     
     标准体脂率：男生17%; 女生23%；
     0<实测体脂率-标准体脂率<5   身体年龄=实测年龄+3
     5<=实测体脂率-标准体脂率<10  身体年龄=实测年龄+5
     10<=实测体脂率-标准体脂率<15 身体年龄=实测年龄+7
     15<=实测体脂率-标准体脂率<20 身体年龄=实测年龄+10
     20<=实测体脂率-标准体脂率<30 身体年龄=实测年龄+13
     30<=实测体脂率-标准体脂率 身体年龄=实测年龄+15
     
     */
    if (fat == 0 || mage == 0)
    {
        return 0;
    }
    HTUserData *userData = [HTUserData sharedInstance];
    int sex = userData.sex;
    int age = mage;
    int cha = fat - (sex == 0 ? 23 : 17);
    if (cha > 0 && cha < 5)
    {
        age += 3;
    }
    else if (cha >= 5 && cha < 10)
    {
        age += 5;
    }
    else if (cha >= 10 && cha < 15)
    {
        age += 7;
    }
    else if (cha >= 15 && cha < 20)
    {
        age += 10;
    }
    else if (cha >= 20 && cha < 30)
    {
        age += 13;
    }
    else if(cha >= 30)
    {
        age += 15;
    }
    return age;
}


#pragma mark - Calculate
+ (State *)calculateBMI:(float)bmi
{
  State *state = [[State alloc] init];
 /* if (bmi <= 18.4) {
    state.text = @"不足";
    state.color = APP_ORANGE;
  } else if (bmi >=18.5 && bmi <= 24.9f) {
    state.text = @"标准";
    state.color = BLUECOLOR;
  } else if (bmi >= 25.0f && bmi <= 29.9) {
    state.text = @"警告";
    state.color = APP_ORANGE;
  } else {
    state.text = @"危险";
    state.color = APP_RED;
  }*/
    if (bmi < 18.5) {
        state.text = @"略低";
        state.color = UIColorFromRGB(180, 180, 180);
    } else if (bmi >= 18.5 && bmi <= 23.9) {
        state.text = @"正常";
        state.color = BLUECOLOR;
    } else {
        state.text = @"较高";
        state.color = APP_ORANGE;
    }
  return state;
}

+ (State *)calculateFat:(float)fat
{
  State *state = [[State alloc] init];
  HTUserData *userData = [HTUserData sharedInstance];
//  int age = userData.age;
  int sex = userData.sex;
  if (0 == sex) {
      if (fat<17.0) {
          state.text = @"略少";
          state.color = APP_ORANGE;
      } else if (fat >= 17.0 && fat <= 23.0) {
          state.text = @"正常";
          state.color = BLUECOLOR;
      }else {
          state.text = @"较高";
          state.color = APP_ORANGE;
      }
      /*
    if (age >= 10 && age <= 33) {
        
      if (fat >= 5.0f && fat <= 20.8) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 20.9 && fat <= 32.5) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 32.6 && fat <= 38.2) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
    } else if (age >= 34&& age <= 49) {
      if (fat >= 5.0f && fat <= 23.4) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 23.5 && fat <= 35.1) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 35.2 && fat <= 40.8) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
       
    } else {
      if (fat >= 5.0f && fat <= 24.4) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 24.5 && fat <= 36.1) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 36.2 && fat <= 41.8) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
    }
       */
  } else {
      if (fat<10) {
          state.text = @"略少";
          state.color = APP_ORANGE;
      } else if (fat >= 10.0 && fat <= 17.0) {
          state.text = @"正常";
          state.color = BLUECOLOR;
      }else {
          state.text = @"较高";
          state.color = APP_ORANGE;
      }
      /*
    if (age >= 10 && age <= 33) {
      if (fat >= 5.0f && fat <= 8.5) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 8.6 && fat <= 19.3) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 19.4 && fat <= 25.0) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
    } else if (age >= 34&& age <= 49) {
      if (fat >= 5.0f && fat <= 11.7) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 11.8 && fat <= 22.5) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 22.6 && fat <= 27.6) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
    } else {
      if (fat >= 5.0f && fat <= 13.7) {
        state.text = @"不足";
        state.color = APP_ORANGE;
      } else if (fat >= 13.8 && fat <= 24.5) {
        state.text = @"标准";
        state.color = BLUECOLOR;
      } else if (fat >= 24.6 && fat <= 30.2) {
        state.text = @"警告";
        state.color = APP_ORANGE;
      } else {
        state.text = @"危险";
        state.color = APP_RED;
      }
    }
      */
  }
  return state;
}

+ (State *)calculateVat:(float)vat
{
  State *state = [[State alloc] init];
  if (vat >= 1.0 && vat <= 3.0) {
    state.text = @"正常";
    state.color = BLUECOLOR;
  } else if (vat >= 4.0f && vat <= 6.0) {
    state.text = @"警告";
    state.color = APP_ORANGE;
  } else {
    state.text = @"危险";
    state.color = APP_RED;
  }
  return state;
}

+ (State *)calculateLBM:(float)lbm
{
  State *state = [[State alloc] init];
  HTUserData *userData = [HTUserData sharedInstance];
  int sex = userData.sex;
    
  if (1 == sex) {
    /*if (lbm <= 34.5) {//lbm >= 8.0f && lbm <= 34.5
      state.text = @"不足";
      state.color = APP_ORANGE;
    } else if (lbm >= 34.6 && lbm <= 38.5) {
      state.text = @"正常";
      state.color = BLUECOLOR;
    } else {
      state.text = @"优秀";
      state.color = APP_GREEN;
    }*/
      if (userData.height<160)
      {
          if (lbm <42.5-4.0)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >=42.5-4.0 && lbm <=42.5+4.0)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm >42.5+4.0)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }else if (userData.height>=160 && userData.height <= 170)
      {
          if (lbm <48.5-4.2)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >=48.5-4.2 && lbm <=48.5+4.2)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm >48.5+4.2)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }
      else if (userData.height > 170)
      {
          if (lbm < 54.4-5.0)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >= 54.4-5.0 && lbm <= 54.4+5.0)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm > 54.4+5.0)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }
  } else {
      if (userData.height<150)
      {
          if (lbm < 31.4-2.8)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >= 31.4-2.8 && lbm <= 31.4+2.8)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm > 31.4+2.8)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }else if (userData.height>=150 && userData.height <= 160)
      {
          if (lbm < 35.2-2.3)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >= 35.2-2.3 && lbm <= 35.2+2.3)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm > 35.2+2.3)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }
      else if (userData.height > 160){
          if (lbm < 39.5-3.0)
          {
              state.text = @"不足";
              state.color = APP_ORANGE;
          }
          else if (lbm >= 39.5-3.0 && lbm <= 39.5+3.0)
          {
              state.text = @"正常";
              state.color = BLUECOLOR;
          }
          else if (lbm > 39.5+3.0)
          {
              state.text = @"优秀";
              state.color = APP_GREEN;
          }
      }
    /*if (lbm <= 27.3) {
      state.text = @"不足";
      state.color = APP_ORANGE;
    } else if (lbm >= 27.4 && lbm <= 31.3) {
      state.text = @"正常";
      state.color = BLUECOLOR;
    } else {
      state.text = @"优秀";
      state.color = APP_GREEN;
    }*/
  }
  return state;
}

+ (State *)calculateBodyAge:(int)bodyAge
{
  State *state = [[State alloc] init];
  HTUserData *userData = [HTUserData sharedInstance];
  int tmpAge = bodyAge - userData.age;
  if (bodyAge <= 0) {
    state.text = @"不足";
    state.color = APP_ORANGE;
  } else if (tmpAge > 5) {
    state.text = @"危险";
    state.color = APP_RED;
  } else if (tmpAge > 0 && tmpAge <= 5) {
    state.text = @"警告";
    state.color = APP_ORANGE;
  } else {
    state.text = @"优秀";
    state.color = APP_GREEN;
  }
  return state;
}

+ (State *)calculateTBW:(float)tbw
{
  State *state = [[State alloc] init];
  HTUserData *userData = [HTUserData sharedInstance];
  int sex = userData.sex;
  if (1 == sex) {
    if (tbw < 50.0f) {
      state.text = @"缺水";
      state.color = APP_ORANGE;
    } else if (tbw >= 50.0f && tbw <= 65.0f) {
      state.text = @"正常";
      state.color = BLUECOLOR;
    } else {
      state.text = @"较高";
      state.color = APP_GREEN;
    }
  } else {
    if (tbw < 40.0f) {
      state.text = @"缺水";
      state.color = APP_ORANGE;
    } else if (tbw >= 40.0f && tbw <= 55.0f) {
      state.text = @"正常";
      state.color = BLUECOLOR;
    } else {
      state.text = @"较高";
      state.color = APP_GREEN;
    }
  }
  return state;
}

+ (State *)calculateKcal:(int)kcal
{
  State *state = [[State alloc] init];
  HTUserData *userData = [HTUserData sharedInstance];
  int age = userData.age;
  int sex = userData.sex;
  if (1 == sex) {
    if (age <= 29) {
      if (kcal >= 1550) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else if (age >= 30 && age <= 49) {
      if (kcal >= 1500) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else if (age >= 50 && age <= 69) {
      if (kcal >= 1350) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else {
      if (kcal >= 1220) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    }
  } else {
    if (age <= 29) {
      if (kcal >= 1210) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else if (age >= 30 && age <= 49) {
      if (kcal >= 1170) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else if (age >= 50 && age <= 69) {
      if (kcal >= 1110) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    } else {
      if (kcal >= 1010) {
        state.text = @"正常";
        state.color = BLUECOLOR;
      } else {
        state.text = @"略低";
        state.color = APP_ORANGE;
      }
    }
  }
  return state;
}

+ (State *)calculateBoneMass:(int)bone
{
    State *state = [[State alloc] init];
    HTUserData *userData = [HTUserData sharedInstance];
   
    if (userData.sex == 1) {
//        8%~34.5% 低
        if (bone >= 8 && bone <= 34.5) {
            state.text = @"低";
            state.color = UIColorFromRGB(180, 180, 180);
        }
//        34.6%~38.5% 标准
        else if (bone >= 34.6 && bone <= 38.5)
        {
            state.text = @"标准";
            state.color = BLUECOLOR;
        }
//        38.6%~44.8% 高
        else if (bone >= 38.6 && bone <= 44.8)
        {
            state.text = @"高";
            state.color = APP_GREEN;
        }
//        44.9%~60% 偏高
        else if (bone >= 44.9 && bone <= 60)
        {
            state.text = @"偏高";
            state.color = APP_GREEN;
        }
//        非正常
        else
        {
            state.text = @"N/A";
            state.color = UIColorFromRGB(180, 180, 180);
        }
    }
    else
    {
        //        8%~27.3% 低
        if (bone >= 8 && bone <= 27.3) {
            state.text = @"低";
            state.color = UIColorFromRGB(180, 180, 180);
        }
        //        27.4%~31.3% 标准
        else if (bone >= 27.4 && bone <= 31.3)
        {
            state.text = @"标准";
            state.color = BLUECOLOR;
        }
        //        31.4%~38.7% 高
        else if (bone >= 31.4 && bone <= 38.7)
        {
            state.text = @"高";
            state.color = APP_GREEN;
        }
        //        38.8%~60.0% 偏高
        else if (bone >= 38.8 && bone <= 60)
        {
            state.text = @"偏高";
            state.color = APP_GREEN;
        }
        //        非正常
        else
        {
            state.text = @"N/A";
            state.color = UIColorFromRGB(180, 180, 180);
        }
    }
    return state;
}

@end
