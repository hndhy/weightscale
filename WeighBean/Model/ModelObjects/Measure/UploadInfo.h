//
//  UploadInfo.h
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "JSONModel.h"

@interface UploadInfo : JSONModel

@property (nonatomic, strong) NSString *w;
@property (nonatomic, strong) NSString *bmi;
@property (nonatomic, strong) NSString *fat;
@property (nonatomic, strong) NSString *tbw;
@property (nonatomic, strong) NSString *lbm;
@property (nonatomic, strong) NSString *bmc;
@property (nonatomic, strong) NSString *vat;
@property (nonatomic, strong) NSString *kcal;
@property (nonatomic, strong) NSString *bodyAge;
@property (nonatomic, assign) NSString *measureTime;

@end
