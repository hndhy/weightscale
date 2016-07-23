//
//  HideModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/8.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "HideModelResponse.h"

@protocol HideModelProtocol <NSObject>

- (void)syncFinished:(HideModelResponse *)response;
- (void)syncFailure;

@end

@interface HideModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<HideModelProtocol> *)controller;

@end
