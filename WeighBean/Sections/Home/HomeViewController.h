//
//  HomeViewController.h
//  WeighBean
// 13146007747 123456
/*
数据库：
rdsg1ez4573xd5lk1b7x.mysql.rds.aliyuncs.com
数据库haoyida
dbadmin/haoYIDa007
 
 com.lmd.Here
 com.hengheng.HHMusic
*/
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@class MeasureInfoModel;

@interface HomeViewController : HTBaseViewController

@property (nonatomic, strong) NSString *testStr;
@property (nonatomic, strong) MeasureInfoModel *infoModel;

@end
