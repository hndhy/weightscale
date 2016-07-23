//
//  OLProductModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/30.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol OLProductModel <NSObject>

@end

@interface OLProductModel : JSONModel

@property (nonatomic,copy)NSString *afterTel;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *origin;
@property (nonatomic,copy)NSString *pic;
@property (nonatomic,copy)NSString *preTel;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *saler;
@property (nonatomic,copy)NSString *taobaourl;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *weight;


@end
