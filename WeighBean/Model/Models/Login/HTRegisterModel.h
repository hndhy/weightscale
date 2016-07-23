//
//  HTRegisterModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UserResponse.h"

@interface HTRegisterModel : HTAbstractDataSource

- (void)registerWithNick:(NSString *)nick pwd:(NSString *)pwd height:(NSString *)height sex:(int)sex birthday:(NSString *)birthday tel:(NSString *)tel coachTel:(NSString *)coachTel avatar:(NSString *)avatar device:(NSString *)device;

@end
