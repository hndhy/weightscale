//
//  UserResponse.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "HTLoginDataModel.h"

@interface UserResponse : BaseResponse

@property (nonatomic,strong) HTLoginDataModel*data;
@property (nonatomic,copy) NSString *token;

@end