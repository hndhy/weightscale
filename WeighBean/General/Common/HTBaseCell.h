//
//  HTBaseCell.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Ext.h"
#import "UtilsMacro.h"

@interface HTBaseCell : UITableViewCell

@property (nonatomic, weak) UIView *highlightedView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)initSubViews;

@end
