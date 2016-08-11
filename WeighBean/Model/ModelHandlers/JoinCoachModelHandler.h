//
//  JoinCoachModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/11.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "JoinCoachResponse.h"

@protocol JoinCoachModelProtocol <NSObject>

- (void)JoinCoachFinished:(JoinCoachResponse *)response;

@end

@interface JoinCoachModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<JoinCoachModelProtocol> *)controller;

@end
