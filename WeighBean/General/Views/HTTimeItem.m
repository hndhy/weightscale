//
//  HTTimeItem.m
//  WeighBean
//
//  Created by liumadu on 15/8/12.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTimeItem.h"

#import "UILabel+Ext.h"
#import "UIView+Ext.h"
#import "UtilsMacro.h"

@interface HTTimeItem ()

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@end

@implementation HTTimeItem

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
  self.monthLabel = [UILabel createLabelWithFrame:CGRectMake(0, 5.0f, self.width, 17.0f)
                                         withSize:14.0f withColor:UIColorFromRGB(189.0f, 208.0f, 216.0f)];
  self.monthLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:self.monthLabel];
  self.dayLabel = [UILabel createLabelWithFrame:CGRectMake(0, self.height - 27.0f, self.width, 22.0f)
                                       withSize:18.0f withColor:UIColorFromRGB(198.0f, 219.0f, 228.0f)];
  self.dayLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:self.dayLabel];
}

- (void)setMonth:(int)month day:(int)day
{
  self.monthLabel.text = [NSString stringWithFormat:@"%d月", month];
  self.dayLabel.text = [NSString stringWithFormat:@"%d", day];
}

- (void)setHight
{
  self.monthLabel.textColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  self.dayLabel.textColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
}

@end
