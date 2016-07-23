//
//  HTTabBarItem.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTTabBarItem : UIView

@property (nonatomic, assign, getter=isSelected) BOOL selected;

- (void)setNormal:(NSString *)normal seleted:(NSString *)selected title:(NSString *)title;

@end
