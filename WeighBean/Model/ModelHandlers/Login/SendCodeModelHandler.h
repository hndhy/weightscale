//
//  SendCodeModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol SendCodeModelProtocol <NSObject>

- (void)sendCodeFinished:(BaseResponse *)response;

@end

@interface SendCodeModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<SendCodeModelProtocol> *)controller;

@end
