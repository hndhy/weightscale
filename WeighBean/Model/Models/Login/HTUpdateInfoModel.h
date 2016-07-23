//
//  HTUpdateInfoModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UserResponse.h"

@interface HTUpdateInfoModel : HTAbstractDataSource

- (void)updateInfo:(NSString *)uid name:(NSString *)name avatar:(NSString *)avatar height:(NSString *)height sex:(int)sex birthday:(NSString *)birthday device:(NSString *)device coachTel:(NSString *)coachTel;

@end
