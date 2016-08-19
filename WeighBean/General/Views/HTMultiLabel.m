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
    self.weightNumLabel = [UILabel createLabelWithFrame:CGRectMake(0, 20, self.frame.size.width, 38.0f) withSize:40.0f withColor:[UIColor blackColor]];
    self.weightNumLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weightNumLabel];
    
    //类别
    self.weightTitleLabel = [UILabel createLabelWithFrame:CGRectMake(10, self.weightNumLabel.bottom+5, self.frame.size.width / 2.0f, 21.0f) withSize:12.0f withColor:[UIColor blackColor]];
    self.weightTitleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.weightTitleLabel];
    
    //单位
    self.weightTagLabel = [UILabel createLabelWithFrame:CGRectMake(self.weightTitleLabel.right, self.weightTitleLabel.top+4, self.frame.size.width/2.0f-10, 15.0f) withSize:10.0f withColor:[UIColor lightGrayColor]];
    self.weightTagLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.weightTagLabel];
    
    //状况
    self.weightStatLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.weightTitleLabel.bottom+6, 56.0f, 22.0f) withSize:13.0f withColor:[UIColor whiteColor]];
    self.weightStatLabel.centerX = self.frame.size.width/2;
    self.weightStatLabel.textAlignment = NSTextAlignmentCenter;
    self.weightStatLabel.backgroundColor = BLUECOLOR;
    [self addSubview:self.weightStatLabel];
}

- (void)setInfoForNumber:(NSString *)number titleLabel:(NSString *)title tagLabel:(NSString *)tag stateLabel:(State *)state;
{
    self.weightNumLabel.text = number;
    self.weightTitleLabel.text = title;
    self.weightTagLabel.text = [NSString stringWithFormat:@"(%@)",tag];
    self.weightStatLabel.text = state.text;
    self.weightStatLabel.backgroundColor = state.color;
}

@end
