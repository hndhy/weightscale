//
//  UILabel+Ext.m
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UILabel+Ext.h"
#import "UtilsMacro.h"

@implementation UILabel (Ext)

- (CGFloat)contentWidth
{
  return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
}

- (CGFloat)contentHeigh
{
  CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:self.font}
                                        context:nil];
  return rect.size.height;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame withSize:(CGFloat)size withColor:(UIColor *)color
{
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  label.font = UIFontOfSize(size);
  label.textColor = color;
  label.backgroundColor = [UIColor clearColor];
  return label;
}

+ (CGFloat)calculateTextHeightWithFont:(UIFont *)font withContent:(NSString *)contentStr withWidth:(CGFloat)width
{
  CGRect rect = [contentStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
  return rect.size.height;
}

@end
