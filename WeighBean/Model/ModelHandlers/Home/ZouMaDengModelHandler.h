//
//  ZouMaDengModelHandler.h
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class ZouMaDengListResponse;

@protocol ZouMaDengModelProtocol <NSObject>

- (void)getZouMaDengFinished:(ZouMaDengListResponse *)response;

@end

@interface ZouMaDengModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<ZouMaDengModelProtocol> *)controller;

@end
