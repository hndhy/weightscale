//
//  NSURL+Additions.m
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "NSURL+Additions.h"

@implementation NSURL (Additions)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
  if (![queryString length]) {
    return self;
  }
  
  NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@", [self absoluteString],
                         [self query] ? @"&" : @"?", queryString];
  NSURL *theURL = [NSURL URLWithString:urlString];
  return theURL;
}

@end
