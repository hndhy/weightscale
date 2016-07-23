//
//  UpdateInfoModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UserResponse;

@protocol UpdateInfoModelProtocol <NSObject>

- (void)updateInfoFinished:(UserResponse *)response;

@end

@interface UpdateInfoModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<UpdateInfoModelProtocol> *)controller;

@end
