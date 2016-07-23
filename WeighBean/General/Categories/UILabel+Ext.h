//
//  UILabel+Ext.h
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Ext)

@property(nonatomic, readonly) CGFloat contentWidth;
@property(nonatomic, readonly) CGFloat contentHeigh;

+ (UILabel *)createLabelWithFrame:(CGRect)frame withSize:(CGFloat)size withColor:(UIColor *)color;
+ (CGFloat)calculateTextHeightWithFont:(UIFont *)font withContent:(NSString *)contentStr withWidth:(CGFloat)width;

@end
