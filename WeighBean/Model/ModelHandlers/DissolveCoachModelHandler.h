//
//  DissolveCoachModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "DissolveCoachResponse.h"

@protocol DissolveCoachModelProtocol <NSObject>

- (void)dissolveCoachFinished:(DissolveCoachResponse *)response;
@end

@interface DissolveCoachModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<DissolveCoachModelProtocol> *)controller;

@end
