//
//  TimelineViwController.h
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface TimelineViwController : HTBaseViewController <UIScrollViewDelegate>
@property (nonatomic,strong) UISegmentedControl * segment;
@property (nonatomic,strong) UIScrollView * scroll;
@end
