//
//  JoinCoachModel.h
//  WeighBean
//
//  Created by sealband on 16/8/11.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "JoinCoachResponse.h"

@interface JoinCoachModel : HTAbstractDataSource
- (void)joinCoachWithUid:(NSString *)uid teamID:(NSString *)tid;

@end
