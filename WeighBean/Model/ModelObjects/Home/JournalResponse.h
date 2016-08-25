//
//  JournalResponse.h
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "JournalObjModel.h"

@interface JournalResponse : BaseResponse
@property (nonatomic,strong) NSArray <JournalObjModel>*data;

@end
