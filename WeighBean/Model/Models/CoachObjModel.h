//
//  CoachObjModel.h
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol CoachObjModel <NSObject>

@end

@interface CoachObjModel : JSONModel


@property (nonatomic,copy)NSString *activeNum;
@property (nonatomic,assign)int flag;
@property (nonatomic,copy)NSString *teamName;
@property (nonatomic,copy)NSString *teamType;
@property (nonatomic,copy)NSString *tid;
@property (nonatomic,copy)NSString *valid;

@end
