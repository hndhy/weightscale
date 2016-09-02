//
//  TeamListModel.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "TeamLineResponse.h"
@interface TeamListModel : HTAbstractDataSource
- (void)getTeamLisetInfoWithTeamID:(NSString *)teamID offset:(NSString *)offset;
@end
