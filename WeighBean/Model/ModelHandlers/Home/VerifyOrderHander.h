//
//  VerifyOrderHander.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "VerfiyOrderResponse.h"

@protocol VerifyOrderModelProtocol <NSObject>

- (void)syncFinished:(VerfiyOrderResponse *)response;
- (void)syncFailure;

@end


@interface VerifyOrderHander : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<VerifyOrderModelProtocol> *)controller;

@end
