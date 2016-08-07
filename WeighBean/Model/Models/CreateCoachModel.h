//
//  CreateCoachModel.h
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "CreateCoachResponse.h"

@interface CreateCoachModel : HTAbstractDataSource
- (void)creatCoachWithUid:(NSString *)uid teamType:(int)teamType teamName:(NSString *)teamName isChat:(int)isChat description:(NSString *)description target:(NSString *)target;
@end
