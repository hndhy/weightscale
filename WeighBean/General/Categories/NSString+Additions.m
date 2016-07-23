//
//  NSString+Additions.m
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
  if (![queryString length]) {
    return [NSURL URLWithString:self];
  }
  
  NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@", self,
                         [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
  NSURL *theURL = [NSURL URLWithString:urlString];
  return theURL;
}

- (NSString *)URLStringByAppendingQueryString:(NSString *)queryString {
  if (![queryString length]) {
    return self;
  }
  return [NSString stringWithFormat:@"%@%@%@", self,
          [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
}

- (float)heightForFont:(UIFont*)font width:(float)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
  CGSize sizeToFit = [self sizeWithFont:font
                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                      lineBreakMode:lineBreakMode];
  return sizeToFit.height;
}

+ (NSString *)filterString:(NSString*)aString filterWith:(NSString*)fStr
{
  aString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if ([aString rangeOfString:fStr].location != NSNotFound) {
    aString = [aString stringByReplacingOccurrencesOfString:fStr withString:@""];
    [self filterString:aString filterWith:fStr];
  }
  return aString;
}

- (BOOL)isPureInt
{
  NSScanner *scan = [NSScanner scannerWithString:self];
  int val;
  return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat
{
  NSScanner* scan = [NSScanner scannerWithString:self];
  float val;
  return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isMobile
{
  NSString *mobileRegex = @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$";
  NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
  return [regexTestMobile evaluateWithObject:self];
}

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
  NSScanner *theScanner = [NSScanner scannerWithString:html];
  NSString *text = nil;
  
  while ([theScanner isAtEnd] == NO) {
    // find start of tag
    [theScanner scanUpToString:@"<" intoString:NULL] ;
    // find end of tag
    [theScanner scanUpToString:@">" intoString:&text] ;
    // replace the found tag with a space
    //(you can filter multi-spaces out later if you wish)
    html = [html stringByReplacingOccurrencesOfString:
            [ NSString stringWithFormat:@"%@>", text]
                                           withString:@""];
  }
  return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

@end
