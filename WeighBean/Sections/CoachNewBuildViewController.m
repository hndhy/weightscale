//
//  CoachNewBuildViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachNewBuildViewController.h"

@implementation CoachNewBuildViewController


- (id)initWithUserID:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)name
{
    self = [super init];
    if (self) {
        userid = uid;
        teamid = tid;
        teamname = name;
//        ischat = chat;
//        teamdescription = description;
    }
    return self;
}

- (void)initNavbar
{
    self.title = @"新建战队";
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [shareBtn setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initModel
{
    self.createCoachModelHandler = [[CreateCoachModelHandler alloc] initWithController:self];
    self.createCoachModel = [[CreateCoachModel alloc] initWithHandler:self.createCoachModelHandler];
}

- (void)initView
{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 50)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    coachNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 40)];
    coachNameLabel.textColor = [UIColor blackColor];
    coachNameLabel.font = [UIFont systemFontOfSize:13];
    coachNameLabel.textAlignment = NSTextAlignmentLeft;
    coachNameLabel.text = @"战队名称";
    [view1 addSubview:coachNameLabel];
    
    nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.frame = CGRectMake(self.view.frame.size.width-100,5,80,20);
    [nameBtn setTitle:@"点击修改" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [nameBtn addTarget:self action:@selector(changeDicClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:nameBtn];

    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom+5, self.view.frame.size.width, 50)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    allowExchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 40)];
    allowExchangeLabel.textColor = [UIColor blackColor];
    allowExchangeLabel.font = [UIFont systemFontOfSize:13];
    allowExchangeLabel.textAlignment = NSTextAlignmentLeft;
    allowExchangeLabel.text = @"允许队员交流";
    [view2 addSubview:allowExchangeLabel];
    
    allowSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, 40)];
    allowSwitch.on = YES;
    [allowSwitch addTarget:self action:@selector(allowAction:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:allowSwitch];
    
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.bottom+5, self.view.frame.size.width, 150)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    
    introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 40)];
    introductionLabel.textColor = [UIColor blackColor];
    introductionLabel.font = [UIFont systemFontOfSize:13];
    introductionLabel.textAlignment = NSTextAlignmentLeft;
    introductionLabel.text = @"战队介绍";
    [view3 addSubview:introductionLabel];
    

    introDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, self.view.frame.size.width-90, 130)];
    introDetailLabel.textColor = [UIColor blackColor];
    introDetailLabel.font = [UIFont systemFontOfSize:13];
    introDetailLabel.text = @"体育总局各个房间圣诞快乐福建省拉杜坎肌肤";
    [view3 addSubview:introDetailLabel];
    
    
    
    
    buildBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width-20, 50)];
    buildBtn.titleLabel.textColor = [UIColor whiteColor];
    buildBtn.backgroundColor = [UIColor blueColor];
    buildBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buildBtn.titleLabel.text = @"成立";
    [buildBtn addTarget:self action:@selector(buildDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buildBtn];
    
    
    if (userid && teamid && teamname) {
//        nameBtn.titleLabel.text = teamname;
        [nameBtn setTitle:teamname forState:UIControlStateNormal];
        isEditType = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark createcoachprotocol
- (void)createCoachFinished:(CreateCoachResponse *)response
{
   
}

#pragma mark action
- (void)presentLeftMenuViewController:(id)sender
{
    
}

- (void)allowAction:(id)sender
{
    
}

- (void)changeDicClick
{
}

- (void)buildDidClick
{
    HTUserData *userData = [HTUserData sharedInstance];
    
    [self.createCoachModel creatCoachWithUid:@"2868B375-B110-817D-DB49-6EBC0572D2E5" teamType:1 teamName:@"nihao" isChat:1 description:@"fsdfsdfs" target:nil];
}
@end
