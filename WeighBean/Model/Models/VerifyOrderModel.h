//
//  VerifyOrderModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "VerfiyOrderResponse.h"

@interface VerifyOrderModel : HTAbstractDataSource

- (void)getProductid:(NSString *)pid;

@end
