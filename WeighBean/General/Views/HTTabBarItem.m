//
//  HTTabBarItem.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTabBarItem.h"
#import "UILabel+Ext.h"
#import "UIView+Ext.h"
#import "UtilsMacro.h"

@interface HTTabBarItem ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HTTabBarItem

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self initSubViews];
  }
  return self;
}

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
  self.imageView = [[UIImageView alloc] init];
  [self addSubview:self.imageView];
  self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, self.width, 12.0f)
                                         withSize:10.0f
                                        withColor:UIColorFromRGB(195.0f, 195.0f, 195.0f)];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.highlightedTextColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
  [self addSubview:self.titleLabel];
}

- (void)setNormal:(NSString *)normal seleted:(NSString *)selected title:(NSString *)title
{
  self.imageView.image = [UIImage imageNamed:normal];
  self.imageView.highlightedImage = [UIImage imageNamed:selected];
  [self.imageView sizeToFit];
    self.imageView.top = !title.length ? 2 : 9.0f;
  self.imageView.centerX = self.centerX - self.left;
  self.titleLabel.text = title;
  self.titleLabel.top = self.height - 17.0f;
}

- (void)setSelected:(BOOL)selected
{
  _selected = selected;
  [self.imageView setHighlighted:selected];
  [self.titleLabel setHighlighted:selected];
}

@end
