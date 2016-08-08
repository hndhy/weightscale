//
//  UpdateCoachModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "UpdateCoachResponse.h"

@protocol UpdateCoachModelProtocol <NSObject>

- (void)updateCoachFinished:(UpdateCoachResponse *)response;

@end


@interface UpdateCoachModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<UpdateCoachModelProtocol> *)controller;

@end
