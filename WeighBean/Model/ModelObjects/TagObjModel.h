//
//  TagObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol TagObjModel <NSObject>

@end

@interface TagObjModel : JSONModel
@property (nonatomic,copy)NSString *recommend;
@property (nonatomic,copy)NSString *shortTag;
@property (nonatomic,copy)NSString *tagName;
@property (nonatomic,copy)NSString *userTag;

@end
