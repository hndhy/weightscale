//
//  CheckTelAndNickModelHandler.h
//  WeighBean
//
//  Created by liumadu on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol CheckInfoModelProtocol <NSObject>

- (void)checkInfoFinished:(BaseResponse *)response;

@end

@interface CheckTelAndNickModelHandler : HTBaseModelHandler

@end


@interface UpdateInfoModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<CheckInfoModelProtocol> *)controller;

@end