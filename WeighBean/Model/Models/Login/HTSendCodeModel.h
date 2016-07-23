//
//  HTSendCodeModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface HTSendCodeModel : HTAbstractDataSource

- (void)sendCode:(NSString *)phone type:(NSString *)type;

@end
