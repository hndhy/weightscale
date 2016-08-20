//
//  TagResponse.h
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "BaseResponse.h"
#import "TagObjModel.h"

@interface TagResponse : BaseResponse
@property (nonatomic,strong) NSArray <TagObjModel>*data;

@end
