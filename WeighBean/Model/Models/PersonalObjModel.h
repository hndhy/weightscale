//
//  PersonalObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/18.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"
#import "MeasureObjModel.h"


@protocol PersonalObjModel <NSObject>


@end

@interface PersonalObjModel : JSONModel
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *comment_num;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *dakaid;
@property (nonatomic,copy)NSString *favour;

@property (nonatomic,copy)NSString *nick;
@property (nonatomic,copy)NSString *pics;
@property (nonatomic,copy)NSString *tag;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *uid;

@property (nonatomic,assign)NSArray <Optional>*comment_list;
@property (nonatomic,assign)NSArray <Optional>*favour_list;
@property (nonatomic,assign)MeasureObjModel *measure;

@end
