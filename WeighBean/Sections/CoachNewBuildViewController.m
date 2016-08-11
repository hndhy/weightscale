//
//  CoachNewBuildViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachNewBuildViewController.h"

@implementation CoachNewBuildViewController


- (id)initWithType:(int)type
{
    self = [super init];
    if (self) {
        teamType = type;
    }
    return self;
}

- (id)initWithUserID:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)name
{
    self = [super init];
    if (self) {
        userid = uid;
        teamid = tid;
        teamname = name;
    }
    return self;
}


- (void)initNavbar
{
    self.title = @"新建战队";
//    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [shareBtn setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
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
    
    coachNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 40)];
    coachNameLabel.textColor = [UIColor blackColor];
    coachNameLabel.font = [UIFont systemFontOfSize:13];
    coachNameLabel.textAlignment = NSTextAlignmentLeft;
    coachNameLabel.text = @"战队名称";
    [view1 addSubview:coachNameLabel];
    
    nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.frame = CGRectMake(self.view.frame.size.width-100,5,80,40);
    [nameBtn setTitle:@"点击修改" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [nameBtn addTarget:self action:@selector(changeDicClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:nameBtn];

    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom+5, self.view.frame.size.width, 50)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    allowExchangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 90, 40)];
    allowExchangeLabel.textColor = [UIColor blackColor];
    allowExchangeLabel.font = [UIFont systemFontOfSize:13];
    allowExchangeLabel.textAlignment = NSTextAlignmentLeft;
    allowExchangeLabel.text = @"允许队员交流";
    [view2 addSubview:allowExchangeLabel];
    
    allowSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 10, 80, 40)];
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
    

    introDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, self.view.frame.size.width-100, 130)];
    introDetailLabel.textColor = [UIColor blackColor];
    introDetailLabel.font = [UIFont systemFontOfSize:13];
    introDetailLabel.numberOfLines = 0;
    introDetailLabel.text = @"体育总局各个房间圣诞快fwqfweqfewqfsa乐福建省拉fsaf杜坎肌肤fdsafsdaver";
    [view3 addSubview:introDetailLabel];
    
    
    
    
    buildBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, self.view.frame.size.width-20, 50)];
    buildBtn.backgroundColor = BLUECOLOR;
    [buildBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buildBtn setTitle:@"成立" forState:UIControlStateNormal];
    buildBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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

- (void)showEditAlert:(NSString *)title tag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {
        int tag = (int)alertView.tag;
        if (1 == tag) {
            [nameBtn setTitle:[alertView textFieldAtIndex:0].text forState:UIControlStateNormal];
//            self.nameLabel.text = [alertView textFieldAtIndex:0].text;
            NSLog(@"");
        } else if (2 == tag) {
            NSLog(@"");

//            self.numLabel.text = [alertView textFieldAtIndex:0].text;
        } else if (3 == tag) {
//            self.phoneLabel.text = [alertView textFieldAtIndex:0].text;
        }
    }
}



- (void)presentLeftMenuViewController:(id)sender
{
    
}

- (void)allowAction:(id)sender
{
    
}

- (void)changeDicClick
{
    [self showEditAlert:@"修改用户名" tag:1];

}

- (void)buildDidClick
{
    HTUserData *userData = [HTUserData sharedInstance];
    if (allowSwitch.on == YES) {
        ischat = 1;
    } else
    {
        ischat = 0;
    }
    [self.createCoachModel creatCoachWithUid:userData.uid teamType:teamType teamName:nameBtn.titleLabel.text isChat:ischat description:introDetailLabel.text target:nil];
}
@end
