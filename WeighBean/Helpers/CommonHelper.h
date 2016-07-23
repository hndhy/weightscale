//
//  CommonHelper.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class State;
@class MeasureInfoModel;

@interface CommonHelper : NSObject

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UILabel *)addSmallIcon:(NSString *)icon left:(CGFloat)left centerY:(CGFloat)centerY text:(NSString *)text superview:(UIView *)superview;
+ (NSString *)standardTimeWithDate:(NSDate *)date;
+ (NSString *)DecToHex4:(int)value;
+ (NSString *)DecToHexH4:(int)value;
+ (NSString *)DecToHex2:(int)value;
+ (int)HexToDec:(NSString *)valu;
+ (MeasureInfoModel *)parseValue:(NSString *)value;

+ (State *)calculateBMI:(float)bmi;
+ (State *)calculateFat:(float)fat;
+ (State *)calculateVat:(float)vat;
+ (State *)calculateLBM:(float)lbm;
+ (State *)calculateBodyAge:(int)bodyAge;
+ (State *)calculateKcal:(int)kcal;
+ (State *)calculateTBW:(float)tbw;
+ (State *)calculateBoneMass:(int)bone;
+ (NSInteger )bodyAgeWithFat:(int)fat measureAge:(int)mage;
@end
