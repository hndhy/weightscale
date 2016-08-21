//
//  TeamLineResponse.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "TeamObjModel.h"

@interface TeamLineResponse : BaseResponse
@property (nonatomic,strong) NSArray <TeamObjModel>*data;

@end
