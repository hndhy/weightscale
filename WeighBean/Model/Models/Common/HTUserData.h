//
//  HTUserData.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface HTUserData : NSObject

@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *coachTel;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL isCoach;
@property (nonatomic, assign) BOOL isFresh;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *token;

+ (instancetype)sharedInstance;
- (void)save;
- (NSString *)requestCode;

@end

@protocol Userinfo <NSObject>

@end


@interface Userinfo : JSONModel

/*
 
 age = 37;
 avatar = "http://7xl3qx.com1.z0.glb.clouddn.com/qn_6cf94086-311a-44fa-9b51-21e500d55b88";
 birthday = 19781108;
 height = 174;
 nick = "\U6797\U96f7";
 sex = 1;
 */

@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) int height;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) int sex;

@end