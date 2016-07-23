//
//  HTTextField.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTextField.h"

@implementation HTTextField

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
  self.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.autocorrectionType = UITextAutocorrectionTypeNo;
  self.clearButtonMode = UITextFieldViewModeWhileEditing;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)drawRect:(CGRect)rect
{
  if ([_hint length] > 0) {
    if (!_hintLabel) {
      _hintLabel = [[UILabel alloc] initWithFrame:rect];
      _hintLabel.backgroundColor = [UIColor clearColor];
      _hintLabel.textAlignment = self.textAlignment;
      _hintLabel.font = self.font;
      _hintLabel.alpha = 0;
      [self addSubview:_hintLabel];
    }
    _hintLabel.text = _hint;
    if (_hintColor == nil) {
      _hintLabel.textColor = [UIColor grayColor];
    } else {
      _hintLabel.textColor = _hintColor;
    }
    [self sendSubviewToBack:_hintLabel];
  }
  [self layoutGUI];
  [super drawRect:rect];
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
  [[UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f] setFill];
  [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)textChanged:(NSNotification *)notification
{
  if (notification.object == self) {
    [self layoutGUI];
  }
}

- (void)layoutGUI
{
  _hintLabel.alpha = [self.text length] > 0 || [_hint length] == 0 ? 0 : 1;
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
