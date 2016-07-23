//
//  ToolsObjModel.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/29.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol ToolsObjModel <NSObject>

@end

@interface ToolsObjModel : JSONModel

@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;

@end
