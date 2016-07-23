//
//  HTBaseCell.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseCell.h"
#import "UtilsMacro.h"

@implementation HTBaseCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    //cancel selected background color
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initSubViews];
  }
  return self;
}

- (void)initSubViews
{
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
  if(nil == self.highlightedView) {
    return ;
  }
  if (highlighted) {
    self.highlightedView.backgroundColor = UIColorFromRGB(233.0f, 233.0f, 233.0f);
  } else {
    self.highlightedView.backgroundColor = [UIColor whiteColor];
  }
}

@end
