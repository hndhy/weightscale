//
//  BDListCell.h
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseCell.h"
#import "BodyData.h"

@interface BDListCell : HTBaseCell

- (void)bindBodyDataInfo:(BodyData*)model;

@end
