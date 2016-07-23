//
//  AccountData.h
//  WeighBean
//
//  Created by heng on 15/8/22.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@interface AccountData : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, assign) long long loginTime;
@property (nonatomic, strong) NSString *nick;

@end
