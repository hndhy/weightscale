//
//  JournalObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol JournalObjModel <NSObject>


@end

@interface JournalObjModel : JSONModel
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *pics;
@property (nonatomic,copy) NSString *uid;
@end
