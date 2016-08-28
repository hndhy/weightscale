//
//  LikeModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "LikeResponse.h"

@protocol LikeModelProtocol <NSObject>

- (void)likeFinished:(LikeResponse *)response;
- (void)likeFailure;

@end

@interface LikeModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<LikeModelProtocol> *)controller;

@end
