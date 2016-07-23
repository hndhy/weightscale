//
//  HTTextView.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTextView.h"

#import "UILabel+Ext.h"
#import "UIView+Ext.h"

@interface HTTextView()

@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation HTTextView

- (id)init
{
  self = [super init];
  if (self) {
    [self initialize];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self initialize];
  }
  return self;
}

- (void)initialize
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)drawRect:(CGRect)rect
{
  if ([self.hint length] > 0) {
    if (!self.hintLabel) {
      self.hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
      self.hintLabel.backgroundColor = [UIColor clearColor];
      self.hintLabel.textAlignment = self.textAlignment;
      self.hintLabel.numberOfLines = 0;
      self.hintLabel.font = self.font;
      self.hintLabel.alpha = 0;
      [self addSubview:self.hintLabel];
    }
    self.hintLabel.text = self.hint;
    CGFloat height = [UILabel calculateTextHeightWithFont:self.font withContent:self.hint withWidth:self.width];
    self.hintLabel.frame = CGRectMake(5.0f, 8.0f, self.width, height);
    if (self.hintColor == nil) {
      self.hintLabel.textColor = [UIColor grayColor];
    } else {
      self.hintLabel.textColor = self.hintColor;
    }
    [self sendSubviewToBack:self.hintLabel];
  }
  [self layoutGUI];
  [super drawRect:rect];
}

- (void)textChanged:(NSNotification *)notification
{
  if (notification.object == self) {
    [self layoutGUI];
  }
}

- (void)layoutGUI
{
  self.hintLabel.alpha = [self.text length] > 0 || [self.hint length] == 0 ? 0 : 1;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setText:(NSString *)text
{
  [super setText:text];
  [self layoutGUI];
}

- (void)setHint:(NSString *)hint
{
  _hint = hint;
  [self setNeedsDisplay];
}

- (void)setHintColor:(UIColor *)hintColor
{
  _hintColor = hintColor;
  [self setNeedsDisplay];
}

- (NSString *)textValue
{
  return [[super text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
