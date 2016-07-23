//
//  TrendListCell.h
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseCell.h"
#import "BodyData.h"

@protocol SelOrDesSelCellDelegate <NSObject>

@required
- (void)onSelOrDesSelItem:(BodyData *)model button:(UIButton *)button;

@end

@interface TrendListCell : HTBaseCell

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, weak) BodyData *model;
@property (nonatomic, assign) id<SelOrDesSelCellDelegate> delegate;
- (void)bindBodyDataInfo:(BodyData*)model;

@end
