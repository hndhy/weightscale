//
//  PersonalListResponse.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "PersonalObjModel.h"

@interface PersonalListResponse : BaseResponse
@property (nonatomic,strong) NSArray <PersonalObjModel>*data;

@end
