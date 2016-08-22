//
//  TimelineViwController.h
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface TimelineViwController : HTBaseViewController <UIScrollViewDelegate>

{
    NSString *teamid;
}
@property (nonatomic,strong) UISegmentedControl * segment;
@property (nonatomic,strong) UIScrollView * scroll;
- (id)initWithTeamID:(NSString *)tid;
@end
