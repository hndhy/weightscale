//
//  TimelineViwController.m
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TimelineViwController.h"
#import "PersonalViewController.h"
#import "TeamLineViewController.h"
@implementation TimelineViwController

- (id)initWithTeamID:(NSString *)tid
{
    self = [super init];
    if (self) {
        teamid = tid;
    }
    return self;
}


- (void)initNavbar
{
//    self.title = @"V身战队";
//    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [forwardButton setTitle:@"新建" forState:UIControlStateNormal];
//    [forwardButton addTarget:self action:@selector(createNew) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initView
{
    [self initScroll];
    [self initSegment];
}
-(void)initScroll
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //设置滚动视图的内容大小
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
    //设置滚动视图的代理对象
    _scroll.delegate = self;
    //开启翻页效果
    _scroll.pagingEnabled = YES;
    //这里一定要设置为NO，不然会有bug，因为我们是使用分段控件来控制页面的切换，而没有实现滑动界面实现分段控件的下标进行切换
    _scroll.scrollEnabled = NO;
    //添加到父视图
    [self.view addSubview:_scroll];
    
    //初始化 消息表格视图
    
    PersonalViewController * personalVC = [PersonalViewController  new];
    personalVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //把表格添加到父视图，注意，使用的是addChildViewController
    [self addChildViewController:personalVC];
    //把表格视图添加到滚动视图
    [_scroll addSubview:personalVC.view];

    //初始化 电话表格视图(注释就不写了哈，和初始化消息表格视图一样)
    
    TeamLineViewController * teamLineVC = [[TeamLineViewController alloc] initWithTeamID:teamid];
    teamLineVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self addChildViewController:teamLineVC];
    [_scroll addSubview:teamLineVC.view];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}

-(void)initSegment
{
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 7, 120, 30)];
    
    //小伙伴们，设置分段控件的标题时，一定要注意，是使用insertSegmentWithTitle而不是setTitle哈！
    
    [_segment insertSegmentWithTitle:@"自己" atIndex:0 animated:YES];
    [_segment insertSegmentWithTitle:@"战队" atIndex:1 animated:YES];
    //默认选择下标是0，也就是消息按钮上
    [_segment setSelectedSegmentIndex:0];
    //给分段控件添加事件
    [_segment addTarget:self action:@selector(click_jump:)forControlEvents:UIControlEventValueChanged];
    //把分段控件添加到导航控制器的titleView视图上面
    self.navigationItem.titleView = _segment;
    _segment.selectedSegmentIndex = 1;
    
    [_scroll setContentOffset:CGPointMake(_scroll.bounds.size.width, 0)animated:YES];

}

-(void)click_jump:(UISegmentedControl *)sender
{
    //让滚动视图偏移到指定的位置，小伙伴们，能理解就好，不能理解就慢慢理解哈，或者百度
    [_scroll setContentOffset:CGPointMake(_scroll.bounds.size.width *sender.selectedSegmentIndex, 0)animated:YES];
}


@end
