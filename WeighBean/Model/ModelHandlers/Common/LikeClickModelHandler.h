//
//  LikeClickModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol LikeClickModelProtocol<NSObject>

- (void)likeClickFinished:(BaseResponse *)response;

@end

@interface LikeClickModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<LikeClickModelProtocol> *)controller;

@end
