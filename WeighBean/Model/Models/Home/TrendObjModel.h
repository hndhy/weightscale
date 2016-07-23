//
//  TrendObjModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/10.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface TrendObjModel : HTAbstractDataSource

- (void)getFristDataWithUid:(NSString *)uid;

- (void)getMoreWithUid:(NSString *)uid lastId:(NSString *)lastid;

@end
