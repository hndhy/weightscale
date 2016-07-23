//
//  MyInfoModelModelHandler.h
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UserResponse;

@protocol MyInfoModelProtocol <NSObject>

- (void)myInfoFinished:(UserResponse *)response;

@end

@interface MyInfoModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<MyInfoModelProtocol> *)controller;

@end
