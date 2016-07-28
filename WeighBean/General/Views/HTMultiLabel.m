//
//  HTMultiLabel.m
//  WeighBean
//
//  Created by sealband on 16/7/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTMultiLabel.h"
#import "UILabel+Ext.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"

@implementation HTMultiLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    //数字
    self.weightNumLabel = [UILabel createLabelWithFrame:CGRectMake(0, 10, self.frame.size.width, 36.0f) withSize:32.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
//    self.weightNumLabel.text = @"0";
    self.weightNumLabel.textAlignment = NSTextAlignmentCenter;
//    [self.weightNumLabel addTapCallBack:self sel:@selector(onWeightClick:)];
    [self addSubview:self.weightNumLabel];
    
    //类别
    self.weightTitleLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.weightNumLabel.bottom, self.frame.size.width / 2.0f, 21.0f) withSize:12.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
    self.weightTitleLabel.textAlignment = NSTextAlignmentRight;
//    self.weightTitleLabel.text = @"体重";
    [self addSubview:self.weightTitleLabel];
    
    //单位
    self.weightTagLabel = [UILabel createLabelWithFrame:CGRectMake(self.weightTitleLabel.right, self.weightTitleLabel.top, self.frame.size.width/2.0f, 15.0f) withSize:12.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
    self.weightTagLabel.textAlignment = NSTextAlignmentLeft;
    self.weightTagLabel.centerY = self.weightTitleLabel.centerY;
//    self.weightTagLabel.text = @"公斤";
//    [self.weightTagLabel addTapCallBack:self sel:@selector(onWeightClick:)];
    [self addSubview:self.weightTagLabel];
    
    //状况
    self.weightStatLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.frame.size.height - 50.0f, 56.0f, 22.0f) withSize:12.0f withColor:[UIColor whiteColor]];
    self.weightStatLabel.centerX = self.frame.size.width/2;
    self.weightStatLabel.textAlignment = NSTextAlignmentCenter;
//    self.weightStatLabel.text = @"危险";
//    self.weightStatLabel.layer.cornerRadius = 4.0f;
    self.weightStatLabel.layer.masksToBounds = YES;
    self.weightStatLabel.backgroundColor = APP_BLUE;
//    [self.weightStatLabel addTapCallBack:self sel:@selector(onWeightClick:)];
    [self addSubview:self.weightStatLabel];
    
    //表情
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.weightStatLabel.bottom, 30, 30)];
    self.iconView.centerX = self.centerX;
    [self addSubview:self.iconView];
}

- (void)setInfoForNumber:(CGFloat)number titleLabel:(NSString *)title tagLabel:(NSString *)tag stateLabel:(NSString *)state
{
    self.weightNumLabel.text = [NSString stringWithFormat:@"%f",number];
    self.weightTitleLabel.text = title;
    self.weightTagLabel.text = tag;
    self.weightStatLabel.text = state;
}

@end
