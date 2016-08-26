//
//  PersonalListModel.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "PersonalListResponse.h"

@interface PersonalListModel : HTAbstractDataSource
- (void)getPersonalListWithUid:(NSString *)uid;

@end
