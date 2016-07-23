//
//  NSString+Additions.h
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)
// append query string to url
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
// append query string to url
- (NSString *)URLStringByAppendingQueryString:(NSString *)queryString;
// 计算字符串的高度
- (float)heightForFont:(UIFont*)font width:(float)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
/** 过滤字符 */
+ (NSString *)filterString:(NSString*)aString filterWith:(NSString*)fStr;
/** 判断是否为整形 */
- (BOOL)isPureInt;
/** 判断是否为浮点形 */
- (BOOL)isPureFloat;
/** 判断是否是手机号 */
- (BOOL)isMobile;
/** 却掉html标签*/
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

@end
