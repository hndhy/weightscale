//
//  SyncBodyData.h
//  WeighBean
//
//  Created by heng on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//
#import "JSONModel.h"

@protocol SyncBodyData <NSObject>

@end

@interface SyncBodyData : JSONModel

@property(nonatomic, strong)  NSString* bmi;
@property(nonatomic, strong)  NSString* bodyAge;
@property(nonatomic, strong)  NSString* boneMass;
@property(nonatomic, strong)  NSString* fat;
@property(nonatomic, strong)  NSString <Optional>*id;
@property(nonatomic, strong)  NSString* kcal;
@property(nonatomic, strong)  NSString* lbm;
@property(nonatomic, strong)  NSString* measureTime;
@property(nonatomic, strong)  NSString <Optional>*smr;
@property(nonatomic, strong)  NSString* tbw;
@property(nonatomic, strong)  NSString* uid;
@property(nonatomic, strong)  NSString* vat;
@property(nonatomic, strong)  NSString* w;
@end
