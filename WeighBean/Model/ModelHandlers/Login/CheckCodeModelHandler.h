//
//  CheckCodeModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol CheckCodeModelProtocol <NSObject>

- (void)checkCodeFinished:(BaseResponse *)response;

@end

@interface CheckCodeModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<CheckCodeModelProtocol> *)controller;

@end
