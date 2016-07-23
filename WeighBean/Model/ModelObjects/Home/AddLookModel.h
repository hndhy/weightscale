//
//  AddLookModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol AddLookModel <NSObject>


@end

@interface AddLookModel : JSONModel

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *coachUid;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) BOOL userExist;

@end
