//
//  CreateCoachModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "CreateCoachResponse.h"

@protocol CreateCoachModelProtocol <NSObject>

- (void)createCoachFinished:(CreateCoachResponse *)response;

@end

@interface CreateCoachModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<CreateCoachModelProtocol> *)controller;

@end
