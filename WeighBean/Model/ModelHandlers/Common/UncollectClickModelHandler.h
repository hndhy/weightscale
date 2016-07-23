//
//  UncollectClickModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol UncollectClickModelProtocol<NSObject>

- (void)uncollectClickFinished:(BaseResponse *)response;

@end

@interface UncollectClickModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<UncollectClickModelProtocol> *)controller;

@end
