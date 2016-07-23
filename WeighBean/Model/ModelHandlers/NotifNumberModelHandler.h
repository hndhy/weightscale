//
//  NotifNumberModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/26.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "NotifNumberResponse.h"

@protocol NotifNumberModelProtocol <NSObject>

- (void)syncFinished:(NotifNumberResponse *)response;
- (void)syncFailure;

@end

@interface NotifNumberModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<NotifNumberModelProtocol> *)controller;

@end
