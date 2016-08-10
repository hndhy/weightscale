//
//  OnlineListResponse.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "OLProductModel.h"

@interface OnlineListResponse : BaseResponse

@property (nonatomic,strong) NSArray <OLProductModel>*data;

@end
