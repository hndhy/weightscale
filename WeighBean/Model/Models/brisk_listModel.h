//
//  brisk_listModel.h
//  WeighBean
//
//  Created by sealband on 16/8/15.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"

@protocol brisk_listModel <NSObject>

@end

@interface brisk_listModel : JSONModel
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *nick;

@end
