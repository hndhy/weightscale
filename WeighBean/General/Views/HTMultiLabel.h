//
//  HTMultiLabel.h
//  WeighBean
//
//  Created by sealband on 16/7/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMultiLabel : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,strong) UILabel *weightNumLabel;
@property (nonatomic,strong) UILabel *weightTitleLabel;
@property (nonatomic,strong) UILabel *weightTagLabel;
@property (nonatomic,strong) UILabel *weightStatLabel;
@property (nonatomic,strong) UIImageView * iconView;

//- (void)setInfoForNumber:(CGFloat)number titleLabel:(NSString *)title tagLabel:(NSString *)tag stateLabel:(NSString *)state;
- (void)setInfoForNumber:(NSString *)number titleLabel:(NSString *)title tagLabel:(NSString *)tag stateLabel:(NSString *)state;

@end
