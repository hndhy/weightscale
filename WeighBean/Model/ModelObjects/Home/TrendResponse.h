//
//  TrendResponse.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/10.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "SyncBodyData.h"
#import "HTUserData.h"

@protocol TrendResponse <NSObject>

@end

@interface TrendResponse : BaseResponse

@property(nonatomic, strong) NSArray<SyncBodyData> *results;
@property(nonatomic, strong) NSString *stamp;
@property(nonatomic, strong) Userinfo *userinfo;


/*
 
 bmc = 29;
 bmi = "24.29999923706055";
 bodyAge = 65;
 boneMass = 0;
 fat = "5.5";
 id = 69672;
 kcal = 1336;
 lbm = "58.09999847412109";
 measureTime = 1449622363000;
 smr = 0;
 tbw = 10;
 uid = "ed35f5b6-00d9-449d-bbee-d8d0a024305d";
 vat = 4;
 w = "64.59999847412109";
 */

@end
