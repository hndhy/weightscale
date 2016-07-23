//
//  ToolsModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/29.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "ToolsResponse.h"

@protocol ToolsModelProtocol <NSObject>

- (void)syncFinished:(ToolsResponse *)response;
- (void)syncFailure;

@end

@interface ToolsModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<ToolsModelProtocol> *)controller;

@end
