//
//  CoachListResponse.h
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "CoachObjModel.h"

@interface CoachListResponse : BaseResponse
@property (nonatomic,strong) NSArray <CoachObjModel>*data;

@end
