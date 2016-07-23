//
//  TrendModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/10.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "TrendResponse.h"

@protocol TrendModelProtocol <NSObject>

- (void)syncFinished:(TrendResponse *)response;
- (void)syncFailure;

@end

@interface TrendModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<TrendModelProtocol> *)controller;

@end
