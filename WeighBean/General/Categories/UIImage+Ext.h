//
//  UIImage+Ext.h
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

+ (UIImage *)stretchableImage:(NSString *)imagePath left:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
