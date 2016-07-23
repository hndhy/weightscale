//
//  PlanDetailViewController.h
//  WeighBean
//
//  Created by heng on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface WebViewDetailViewController : HTBaseViewController


@property(nonatomic, strong) NSString *titleName;
@property(nonatomic, strong) NSString *urlName;

@property (nonatomic,assign) BOOL isOutNav;

@property (nonatomic,copy) NSString *otherUid;
@property(nonatomic, strong) NSString *wid;
@end
