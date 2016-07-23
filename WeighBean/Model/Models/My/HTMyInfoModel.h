//
//  HTMyInfoModel.h
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UserResponse.h"

@interface HTMyInfoModel : HTAbstractDataSource

- (void)getMyInfo:(NSString *)uid;

@end
