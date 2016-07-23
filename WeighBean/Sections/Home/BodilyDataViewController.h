//
//  BodilyDataViewController.h
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableViewController.h"

@interface BodilyDataViewController : HTTableViewController

@property(nonatomic,strong)NSMutableArray *bodilyArray;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *avatar;
@end
