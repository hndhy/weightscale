//
//  ViewCoachObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol ViewCoachObjModel <NSObject>

@end

@interface ViewCoachObjModel : JSONModel

@property (nonatomic,copy)NSString *teamName;
@property (nonatomic,copy)NSString *teamType;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,copy)NSString *teamId;
@property (nonatomic,copy)NSString *brisk_num;
@property (nonatomic,copy)NSString *sum_num;
@property (nonatomic,copy)NSString *meanfat;
@property (nonatomic,copy)NSString *loseWeight;
@property (nonatomic,copy)NSString *muscleBuilder;
@property (nonatomic,copy)NSString *dynamite;
@property (nonatomic,copy)NSString *underway;
@property (nonatomic,copy)NSString *complete;
@property (nonatomic,copy)NSString *meanfat_complete;
@property (nonatomic,copy)NSString *loseWeight_complete;
@property (nonatomic,copy)NSString *muscleBuilder_complete;
@property (nonatomic,copy)NSString *dynamite_complete;

@end
