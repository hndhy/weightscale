//
//  AddLookResponse.h
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"

#import "AddLookModel.h"

@interface AddLookResponse : BaseResponse

@property (nonatomic, strong) NSString <Optional>*avatar;
@property (nonatomic, strong) NSString <Optional>*coachUid;
@property (nonatomic, strong) NSString <Optional>*nick;
@property (nonatomic, strong) NSString <Optional>*uid;
@property (nonatomic, assign) BOOL userExist;

@end
