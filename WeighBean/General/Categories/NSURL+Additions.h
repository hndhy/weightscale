//
//  NSURL+Additions.h
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Additions)
// append query string to url
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
@end
