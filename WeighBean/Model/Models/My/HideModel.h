//
//  HideModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/8.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "HideModelResponse.h"


@interface HideModel : HTAbstractDataSource

- (void)getHideStatus;

- (void)setHideStatus:(NSString *)status;

@end
