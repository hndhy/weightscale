//
//  HTSyncDataModel.h
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface HTSyncDataModel : HTAbstractDataSource

- (void)syncData:(NSString *)lastSyncTime withData:(NSString*)data;

@end
