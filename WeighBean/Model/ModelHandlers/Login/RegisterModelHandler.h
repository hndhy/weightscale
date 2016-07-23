//
//  RegisterModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UserResponse;

@protocol RegisterModelProtocol <NSObject>

- (void)registerFinished:(UserResponse *)response;

@end

@interface RegisterModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<RegisterModelProtocol> *)controller;

@end
