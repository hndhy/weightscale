//
//  BodilyDataViewController.h
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableViewController.h"

@interface BodilyDataViewController : HTTableViewController
{
    NSString *dataType;
    UIImageView *popView;
    UIView *maskview;
    BOOL isListShowed;

}

@property(nonatomic,strong)NSMutableArray *bodilyArray;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *avatar;
- (id)initWithType:(NSString *)type;

@end
