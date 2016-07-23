//
//  DelDatasModelHandler.h
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"


@protocol DelDatasModelProtocol <NSObject>

- (void)delFinished:(BaseResponse *)response;

@end

@interface DelDatasModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<DelDatasModelProtocol> *)controller;

@end
