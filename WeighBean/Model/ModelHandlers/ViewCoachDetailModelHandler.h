//
//  ViewCoachDetailModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "ViewCoachDetailResponse.h"

@protocol ViewCoachDetailModelProtocol <NSObject>

- (void)viewCoachDetailFinished:(ViewCoachDetailResponse *)response;

@end

@interface ViewCoachDetailModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<ViewCoachDetailModelProtocol> *)controller;

@end
