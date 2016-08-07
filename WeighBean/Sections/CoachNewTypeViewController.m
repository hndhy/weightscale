//
//  CoachNewTypeViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/5.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachNewTypeViewController.h"
#import "UIView+Ext.h"
#import "CoachNewBuildViewController.h"


@implementation CoachNewTypeViewController
- (void)initView
{
    //减脂
    fatLossBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    fatLossBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fatLossBackView];
    fatLossBackView.hidden = YES;
    
    fatLossLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    fatLossLbl.backgroundColor = [UIColor whiteColor];
    [fatLossLbl setTextColor:[UIColor blackColor]];
    [fatLossLbl setFont:[UIFont systemFontOfSize:15]];
    [fatLossLbl setText:@"减脂"];
    [fatLossBackView addSubview:fatLossLbl];
    
    fatLossTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 250)];
    fatLossTextView.backgroundColor = [UIColor whiteColor];
    [fatLossTextView setTextColor:[UIColor grayColor]];
    [fatLossTextView setFont:[UIFont systemFontOfSize:12]];
    NSString *fatLossStr = @"减脂，就是体内脂肪超过正常范围之内的动物，由于自身形体健康的原因，通过各种手段剪掉自己身上多余脂肪的行为。前言称量体重可能是最简单的检测减肥成果的手段，热衷于减肥的女性心情总是随着体重秤指针的摆动而摆动。如果减肥真的是为了健康和体型美的目的，那么称体重并不一定是最";
    [fatLossTextView setText:fatLossStr];
    [fatLossBackView addSubview:fatLossTextView];
    
    //增肌
    muscleGainBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    muscleGainBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:muscleGainBackView];
    muscleGainBackView.hidden = YES;
    
    muscleGainLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    muscleGainLbl.backgroundColor = [UIColor whiteColor];
    [muscleGainLbl setTextColor:[UIColor blackColor]];
    [muscleGainLbl setFont:[UIFont systemFontOfSize:15]];
    [muscleGainLbl setText:@"增肌"];
    [muscleGainBackView addSubview:muscleGainLbl];
    
    muscleGainTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 250)];
    muscleGainTextView.backgroundColor = [UIColor whiteColor];
    [muscleGainTextView setTextColor:[UIColor grayColor]];
    [muscleGainTextView setFont:[UIFont systemFontOfSize:12]];
    NSString *muscleGainStr = @"减脂，就是体内脂肪超过正常范围之内的动物，由于自身形体健康的原因，通过各种手段剪掉自己身上多余脂肪的行为。前言称量体重可能是最简单的检测减肥成果的手段，热衷于减肥的女性心情总是随着体重秤指针的摆动而摆动。如果减肥真的是为了健康和体型美的目的，那么称体重并不一定是最";
    [muscleGainTextView setText:muscleGainStr];
    [muscleGainBackView addSubview:muscleGainTextView];
    
    //确认和分享按钮
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(5,350,self.view.frame.size.width-10,40);
    confirmBtn.backgroundColor = [UIColor blueColor];
    [confirmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];

    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(5,400,self.view.frame.size.width-10,40);
    shareBtn.backgroundColor = [UIColor blueColor];
    [shareBtn addTarget:self action:@selector(shareDicClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    goalSetBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    goalSetBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:goalSetBackView];
    goalSetBackView.hidden = YES;
    
    for (int i= 0; i<3; i++) {
        for (int j=0; j<3; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*self.view.frame.size.width/3, j*110, self.view.frame.size.width/3-5, 100);
            btn.backgroundColor = [UIColor redColor];
            [goalSetBackView addSubview:btn];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    
    if (currentNewType ==1) {
        muscleGainBackView.hidden=goalSetBackView.hidden=YES;
        fatLossBackView.hidden=NO;
    } else if (currentNewType==2)
    {
        fatLossBackView.hidden=goalSetBackView.hidden=YES;
        muscleGainBackView.hidden=NO;
    }else
    {
        fatLossBackView.hidden=muscleGainBackView.hidden=YES;
        goalSetBackView.hidden=NO;
        confirmBtn.hidden=shareBtn.hidden=YES;
    }
}

- (void)createType:(int)type
{
    currentNewType = type;
}

- (void)btnAction:(id)sender
{
    CoachNewBuildViewController *vc = [[CoachNewBuildViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shareDicClick
{
    
}
@end
