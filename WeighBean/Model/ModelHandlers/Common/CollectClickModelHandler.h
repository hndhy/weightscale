//
//  CollectClickModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol CollectClickModelProtocol<NSObject>

- (void)collectClickFinished:(BaseResponse *)response;

@end

@interface CollectClickModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<CollectClickModelProtocol> *)controller;

@end
