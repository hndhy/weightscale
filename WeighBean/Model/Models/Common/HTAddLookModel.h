//
//  HTAddLookModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface HTAddLookModel : HTAbstractDataSource

- (void)searchChengYan:(NSString *)tel;

- (void)joinMyTeamId:(NSString *)uid;

@end
