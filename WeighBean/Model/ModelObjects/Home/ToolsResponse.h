//
//  ToolsResponse.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/29.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "ToolsObjModel.h"

@interface ToolsResponse : BaseResponse

@property (nonatomic,copy) NSString *onlineCount;
@property (nonatomic,strong) NSArray <ToolsObjModel>*results;

@end
