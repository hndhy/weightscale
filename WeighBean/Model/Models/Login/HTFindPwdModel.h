//
//  HTFindPwdModel.h
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UserResponse.h"

@interface HTFindPwdModel : HTAbstractDataSource

- (void)findPwdWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd;

@end
