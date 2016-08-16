//
//  UserDataModel.h
//  WeighBean
//
//  Created by sealband on 16/8/15.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"


@protocol UserDataModel <NSObject>


@end

@interface UserDataModel : JSONModel

@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *coachTel;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL isCoach;
@property (nonatomic, assign) BOOL isFresh;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *uid;

@end
