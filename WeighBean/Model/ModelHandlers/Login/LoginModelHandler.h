//
//  LoginModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UserResponse;

@protocol LoginModelProtocol <NSObject>

- (void)loginFinished:(UserResponse *)response;

@end

@interface LoginModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<LoginModelProtocol> *)controller;

@end
