//
//  ZouMaDengInfoModel.h
//  WeighBean
//
//  Created by liumadu on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol ZouMaDengInfoModel <NSObject>

@end

@interface ZouMaDengInfoModel : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;

@end
