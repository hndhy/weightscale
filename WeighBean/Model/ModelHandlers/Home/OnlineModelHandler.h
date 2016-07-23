//
//  OnlineModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "OnlineListResponse.h"
@protocol OnlineModelProtocol <NSObject>

- (void)syncFinished:(OnlineListResponse *)response;
- (void)syncFailure;

@end

@interface OnlineModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<OnlineModelProtocol> *)controller;

@end
