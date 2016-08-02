//
//  UserResponse.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"

@interface UserResponse : BaseResponse

//@property (nonatomic, assign) int age;
//@property (nonatomic, strong) NSString *avatar;
//@property (nonatomic, strong) NSString *birthday;
//@property (nonatomic, strong) NSString *coachTel;
//@property (nonatomic, strong) NSString *device;
//@property (nonatomic, assign) int height;
//@property (nonatomic, assign) BOOL isCoach;
//@property (nonatomic, strong) NSString *nick;
//@property (nonatomic, assign) int sex;
//@property (nonatomic, strong) NSString *tel;
//@property (nonatomic, strong) NSString *uid;
//@property (nonatomic, assign) BOOL isFresh;
@property (nonatomic ,strong) NSMutableDictionary *data;
- (id)initWithDic:(NSDictionary *)dic;
- (int) age;
- (NSString *) avatar;
- (NSString *) birthday;
- (NSString *) coachTel;
- (NSString *) device;
- (int) height;
- (BOOL) isCoach;
- (NSString *) nick;
- (int) sex;
- (NSString *)tel;
- (NSString *)uid;
- (BOOL) isFresh;
@end