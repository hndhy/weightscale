//
//  CoachChooseViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/5.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachChooseViewController.h"
#import "CoachNewTypeViewController.h"

@implementation CoachChooseViewController
- (void)initNavbar
{
    self.title = @"V身挑战";
//    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initModel
{
//    self.handle = [[CoachModelHandler alloc] initWithController:self];
//    self.listModel = [[CoachListModel alloc] initWithHandler:self.handle];
//    _dataArray = [[NSMutableArray alloc] init];
//    [self.listModel getCoachListPage:1];
}

- (void)initView
{
    fatLossBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, DEVICEW-10, 280*(DEVICEW-10)/620)];
    [fatLossBtn setBackgroundImage:[UIImage imageNamed:@"looseweight"] forState:UIControlStateNormal];
    [fatLossBtn addTarget:self action:@selector(fatlossDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fatLossBtn];
    
    muscleGainBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, fatLossBtn.bottom+5, DEVICEW-10, 280*(DEVICEW-10)/620)];
    [muscleGainBtn setBackgroundImage:[UIImage imageNamed:@"gainmuscle"] forState:UIControlStateNormal];
    [muscleGainBtn addTarget:self action:@selector(muscleGainDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:muscleGainBtn];
    
    goalSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 320, self.view.frame.size.width, 150)];
    goalSetBtn.backgroundColor = [UIColor redColor];
    [goalSetBtn setTitle:@"个人目标" forState:UIControlStateNormal];
    [goalSetBtn addTarget:self action:@selector(goalSetDicClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:goalSetBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark action
- (void)fatlossDidClick
{
    CoachNewTypeViewController *vc = [[CoachNewTypeViewController alloc] init];
    [vc createType:1];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)muscleGainDidClick
{
    CoachNewTypeViewController *vc = [[CoachNewTypeViewController alloc] init];
    [vc createType:2];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goalSetDicClick
{
    CoachNewTypeViewController *vc = [[CoachNewTypeViewController alloc] init];
    [vc createType:3];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
