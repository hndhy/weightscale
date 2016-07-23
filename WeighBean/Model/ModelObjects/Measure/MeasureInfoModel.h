//
//  MeasureInfoModel.h
//  WeighBean
//
//  Created by liumadu on 15/8/12.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"

@interface MeasureInfoModel : BaseResponse

@property (nonatomic, assign) float weight;
@property (nonatomic, assign) float bmi;
@property (nonatomic, assign) float fat;
@property (nonatomic, assign) float tbw;
@property (nonatomic, assign) float lbm;
@property (nonatomic, assign) float bmc;
@property (nonatomic, assign) float vat;
@property (nonatomic, assign) int kcal;
@property (nonatomic, assign) int bodyAge;
//@property (nonatomic, assign) float boneMass;
@property (nonatomic, assign) float smr;
@property (nonatomic, strong) NSString<Optional> *measuretime;

@end
