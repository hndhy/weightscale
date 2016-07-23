//
//  PlayClickModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/7/1.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol PlayClickModelProtocol<NSObject>

- (void)playClickFinished:(BaseResponse *)response;

@end

@interface PlayClickModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<PlayClickModelProtocol> *)controller;

@end
