//
//  NSDictionary+GetValue.h
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GetValue)
- (id)getValueForKey:(NSString *)_key;
- (id)getValueForKeyPath:(NSString *)_path;
@end
