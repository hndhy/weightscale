//
//  CoachListModel.h
//  WeighBean
//
//  Created by sealband on 16/7/31.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "CoachListResponse.h"

@interface CoachListModel : HTAbstractDataSource
- (void)getCoachListPage:(NSInteger )page;

@end