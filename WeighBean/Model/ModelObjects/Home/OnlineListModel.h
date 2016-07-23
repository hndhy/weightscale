//
//  OnlineListModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "OnlineListResponse.h"

@interface OnlineListModel : HTAbstractDataSource

- (void)getOnlineListPage:(NSInteger )page;

@end
