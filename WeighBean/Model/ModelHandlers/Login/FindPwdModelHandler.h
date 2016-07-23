//
//  FindPwdModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UserResponse;

@protocol FindPwdModelProtocol <NSObject>

- (void)findPwdFinished:(UserResponse *)response;

@end

@interface FindPwdModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<FindPwdModelProtocol> *)controller;

@end
