//
//  DissolveCoachModel.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "DissolveCoachResponse.h"

@interface DissolveCoachModel : HTAbstractDataSource
- (void)dissolveCoachWithUid:(NSString *)uid teamID:(NSString *)tid;

@end
