//
//  UpdateCoachModel.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "UpdateCoachResponse.h"

@interface UpdateCoachModel : HTAbstractDataSource
- (void)udpateCoachWithUid:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)teamName isChat:(int)isChat description:(NSString *)description;

@end
