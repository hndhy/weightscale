//
//  HTBaseModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "BaseResponse.h"
#import "HTBaseViewController.h"

@interface HTBaseModelHandler : NSObject<HTDataSourceDelegate>

@property (nonatomic, weak) HTBaseViewController *controller;

- (id)initWithController:(HTBaseViewController *)controller;

@end
