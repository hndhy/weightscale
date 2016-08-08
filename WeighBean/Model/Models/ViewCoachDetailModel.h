//
//  ViewCoachDetailModel.h
//  WeighBean
//
//  Created by sealband on 16/8/8.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "ViewCoachDetailResponse.h"

@interface ViewCoachDetailModel : HTAbstractDataSource
- (void)viewCoachDetailWithUid:(NSString *)uid;

@end
