//
//  CoachModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "CoachListResponse.h"

@protocol CoachModelProtocol <NSObject>

- (void)syncFinished:(CoachListResponse *)response;
- (void)syncFailure;

@end



@interface CoachModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<CoachModelProtocol> *)controller;

@end

