//
//  TeamObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"


@interface TeamObjModel : JSONModel
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *comment_num;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *dakatype;
@property (nonatomic,copy)NSString *favour;

@property (nonatomic,copy)NSString *nick;
@property (nonatomic,copy)NSString *pics;
@property (nonatomic,copy)NSString *teamType;
@property (nonatomic,copy)NSString *uid;

@property (nonatomic,assign) NSDictionary *measure;
@end

