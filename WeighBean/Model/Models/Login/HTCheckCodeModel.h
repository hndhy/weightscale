//
//  HTCheckCodeModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface HTCheckCodeModel : HTAbstractDataSource

- (void)checkCode:(NSString *)code phone:(NSString *)phone;

@end
