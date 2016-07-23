//
//  HTLoginModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UserResponse.h"

@interface HTLoginModel : HTAbstractDataSource

- (void)loginWithName:(NSString *)name pwd:(NSString *)pwd;

@end
