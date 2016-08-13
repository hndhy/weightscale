//
//  CoachDetailViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/9.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachDetailViewController.h"

@implementation CoachDetailViewController


//- (id)initWithUserID:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)name
//{
//    self = [super init];
//    if (self) {
//        userid = uid;
//        teamid = tid;
//        teamname = name;
//        //        ischat = chat;
//        //        teamdescription = description;
//    }
//    return self;
//}

- (void)initNavbar
{
    self.title = @"V身战队";
//    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [shareBtn setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [shareBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initModel
{
//    self.createCoachModelHandler = [[CreateCoachModelHandler alloc] initWithController:self];
//    self.createCoachModel = [[CreateCoachModel alloc] initWithHandler:self.createCoachModelHandler];
}

- (void)initView
{
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.frame = CGRectMake(5, 5, DEVICEW-10, DEVICEH);
//    scrollView.backgroundColor = UIColorFromRGB(242.0f, 242.0f, 242.0f);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.layer.cornerRadius = 4.0;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    coachTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 50, 60)];
    coachTypeLbl.backgroundColor = BLUECOLOR;
    [coachTypeLbl setTextColor:[UIColor whiteColor]];
    [coachTypeLbl setFont:[UIFont systemFontOfSize:15]];
    [coachTypeLbl setText:@"增肌"];
    [scrollView addSubview:coachTypeLbl];
    
    startTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, 10, 150, 20)];
    startTimeLbl.backgroundColor = [UIColor clearColor];
    [startTimeLbl setTextColor:[UIColor grayColor]];
    [startTimeLbl setFont:[UIFont systemFontOfSize:11]];
    [startTimeLbl setText:@"开始时间：2016-04-28"];
    [scrollView addSubview:startTimeLbl];
    
    endTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(startTimeLbl.left, startTimeLbl.bottom+5, 150, 20)];
    endTimeLbl.backgroundColor = [UIColor clearColor];
    [endTimeLbl setTextColor:[UIColor grayColor]];
    [endTimeLbl setFont:[UIFont systemFontOfSize:11]];
    [endTimeLbl setText:@"结束时间：暂无"];
    [scrollView addSubview:endTimeLbl];
    
    
    UILabel *idTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 60, 30)];
    idTitleLbl.backgroundColor = [UIColor clearColor];
    [idTitleLbl setTextColor:[UIColor blackColor]];
    [idTitleLbl setFont:[UIFont systemFontOfSize:15]];
    [idTitleLbl setText:@"ID信息"];
    [scrollView addSubview:idTitleLbl];
    
    teamIdLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, idTitleLbl.top, 100, 30)];
    teamIdLbl.backgroundColor = [UIColor clearColor];
    [teamIdLbl setTextColor:[UIColor blackColor]];
    [teamIdLbl setFont:[UIFont systemFontOfSize:14]];
    [teamIdLbl setText:@"223523423"];
    [scrollView addSubview:teamIdLbl];
    
    
    
    UILabel *ingTitleLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 75, 30)];
    ingTitleLbl1.backgroundColor = [UIColor clearColor];
    [ingTitleLbl1 setTextColor:[UIColor blackColor]];
    [ingTitleLbl1 setFont:[UIFont systemFontOfSize:14]];
    [ingTitleLbl1 setText:@"正在进行中"];
    [scrollView addSubview:ingTitleLbl1];
    
    UILabel *ingTitleLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(ingTitleLbl1.right, 120, 160, 30)];
    ingTitleLbl2.backgroundColor = [UIColor clearColor];
    [ingTitleLbl2 setTextColor:[UIColor lightGrayColor]];
    [ingTitleLbl2 setFont:[UIFont systemFontOfSize:11]];
    [ingTitleLbl2 setText:@"(活跃用户人数／总人数)"];
    ingTitleLbl2.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:ingTitleLbl2];
    
    activeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(DEVICEW-60, ingTitleLbl1.top, 60, 30)];
    activeRatioLbl.backgroundColor = [UIColor clearColor];
    [activeRatioLbl setTextColor:UIColorFromRGB(127, 168, 238)];
    [activeRatioLbl setFont:[UIFont systemFontOfSize:14]];
    [activeRatioLbl setText:@"3/6"];
    [scrollView addSubview:activeRatioLbl];
    
    
    
  
    
    UILabel *ingDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 140, 30)];
    ingDataLbl.backgroundColor = [UIColor clearColor];
    [ingDataLbl setTextColor:[UIColor blackColor]];
    [ingDataLbl setFont:[UIFont systemFontOfSize:14]];
    [ingDataLbl setText:@"进行中数据统计"];
    [scrollView addSubview:ingDataLbl];
    
    UILabel *dataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 200, 80, 30)];
    dataLbl1.backgroundColor = [UIColor clearColor];
    [dataLbl1 setTextColor:[UIColor lightGrayColor]];
    [dataLbl1 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl1 setText:@"人均减脂重量"];
    [scrollView addSubview:dataLbl1];
    
    meanfatLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl1.right, dataLbl1.top, 40, 30)];
    meanfatLbl.backgroundColor = [UIColor clearColor];
    [meanfatLbl setTextColor:[UIColor blackColor]];
    [meanfatLbl setFont:[UIFont systemFontOfSize:13]];
    [meanfatLbl setText:@"0.5%"];
    [scrollView addSubview:meanfatLbl];
    
    UILabel *dataLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(meanfatLbl.right+50, dataLbl1.top, 80, 30)];
    dataLbl2.backgroundColor = [UIColor clearColor];
    [dataLbl2 setTextColor:[UIColor lightGrayColor]];
    [dataLbl2 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl2 setText:@"减重比"];
    [scrollView addSubview:dataLbl2];
    
    loseWeightRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl2.right, dataLbl1.top, 40, 30)];
    loseWeightRatioLbl.backgroundColor = [UIColor clearColor];
    [loseWeightRatioLbl setTextColor:[UIColor blackColor]];
    [loseWeightRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [loseWeightRatioLbl setText:@"0.5%"];
    [scrollView addSubview:loseWeightRatioLbl];
    
    UILabel *dataLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl1.left, 240, 80, 30)];
    dataLbl3.backgroundColor = [UIColor clearColor];
    [dataLbl3 setTextColor:[UIColor lightGrayColor]];
    [dataLbl3 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl3 setText:@"人均增肌重量"];
    [scrollView addSubview:dataLbl3];
    
    muscleBuilderLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl3.right, dataLbl3.top, 40, 30)];
    muscleBuilderLbl.backgroundColor = [UIColor clearColor];
    [muscleBuilderLbl setTextColor:[UIColor blackColor]];
    [muscleBuilderLbl setFont:[UIFont systemFontOfSize:13]];
    [muscleBuilderLbl setText:@"0.45%"];
    [scrollView addSubview:muscleBuilderLbl];
    
    UILabel *dataLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(muscleBuilderLbl.right+50, dataLbl3.top, 80, 30)];
    dataLbl4.backgroundColor = [UIColor clearColor];
    [dataLbl4 setTextColor:[UIColor lightGrayColor]];
    [dataLbl4 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl4 setText:@"增重比"];
    [scrollView addSubview:dataLbl4];
    
    dynamiteRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl4.right, dataLbl3.top, 40, 30)];
    dynamiteRatioLbl.backgroundColor = [UIColor clearColor];
    [dynamiteRatioLbl setTextColor:[UIColor blackColor]];
    [dynamiteRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [dynamiteRatioLbl setText:@"0.5%"];
    [scrollView addSubview:dynamiteRatioLbl];


    


    UILabel *ingValid = [[UILabel alloc] initWithFrame:CGRectMake(15, 270, 120, 30)];
    ingValid.backgroundColor = [UIColor clearColor];
    [ingValid setTextColor:[UIColor blackColor]];
    [ingValid setFont:[UIFont systemFontOfSize:14]];
    [ingValid setText:@"进行中有效率"];
    [scrollView addSubview:ingValid];
    
    underwayRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(ingValid.right+100, ingValid.top, 40, 30)];
    underwayRatioLbl.backgroundColor = [UIColor clearColor];
    [underwayRatioLbl setTextColor:[UIColor blackColor]];
    [underwayRatioLbl setFont:[UIFont systemFontOfSize:14]];
    [underwayRatioLbl setText:@"25%"];
    [scrollView addSubview:underwayRatioLbl];
    
    
    
    UILabel *completeValid = [[UILabel alloc] initWithFrame:CGRectMake(15, 300, 120, 30)];
    completeValid.backgroundColor = [UIColor clearColor];
    [completeValid setTextColor:[UIColor blackColor]];
    [completeValid setFont:[UIFont systemFontOfSize:14]];
    [completeValid setText:@"已完成有效率"];
    [scrollView addSubview:completeValid];
    
    completeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(completeValid.right+100, completeValid.top, 40, 30)];
    completeRatioLbl.backgroundColor = [UIColor clearColor];
    [completeRatioLbl setTextColor:[UIColor blackColor]];
    [completeRatioLbl setFont:[UIFont systemFontOfSize:14]];
    [completeRatioLbl setText:@"5%"];
    [scrollView addSubview:completeRatioLbl];
    
    
    
    
    
    
    
    UILabel *completeDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 340, 100, 30)];
    completeDataLbl.backgroundColor = [UIColor clearColor];
    [completeDataLbl setTextColor:[UIColor blackColor]];
    [completeDataLbl setFont:[UIFont systemFontOfSize:13]];
    [completeDataLbl setText:@"已完成数据统计"];
    [scrollView addSubview:completeDataLbl];
    
    UILabel *comDataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 370, 80, 30)];
    comDataLbl1.backgroundColor = [UIColor clearColor];
    [comDataLbl1 setTextColor:[UIColor blackColor]];
    [comDataLbl1 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl1 setText:@"人均减脂重量"];
    [scrollView addSubview:comDataLbl1];
    
    meanfat_completeLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl1.right, comDataLbl1.top, 40, 30)];
    meanfat_completeLbl.backgroundColor = [UIColor clearColor];
    [meanfat_completeLbl setTextColor:[UIColor blackColor]];
    [meanfat_completeLbl setFont:[UIFont systemFontOfSize:13]];
    [meanfat_completeLbl setText:@"0.5%"];
    [scrollView addSubview:meanfat_completeLbl];
    
    UILabel *comDataLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(meanfat_completeLbl.right+50, meanfat_completeLbl.top, 80, 30)];
    comDataLbl2.backgroundColor = [UIColor clearColor];
    [comDataLbl2 setTextColor:[UIColor blackColor]];
    [comDataLbl2 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl2 setText:@"减重比"];
    [scrollView addSubview:comDataLbl2];
    
    loseWeight_completeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl2.right, comDataLbl2.top, 40, 30)];
    loseWeight_completeRatioLbl.backgroundColor = [UIColor clearColor];
    [loseWeight_completeRatioLbl setTextColor:[UIColor blackColor]];
    [loseWeight_completeRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [loseWeight_completeRatioLbl setText:@"0.5%"];
    [scrollView addSubview:loseWeight_completeRatioLbl];
    
    UILabel *comDataLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl1.left, comDataLbl1.bottom, 80, 30)];
    comDataLbl3.backgroundColor = [UIColor clearColor];
    [comDataLbl3 setTextColor:[UIColor blackColor]];
    [comDataLbl3 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl3 setText:@"人均增肌重量"];
    [scrollView addSubview:comDataLbl3];
    
    muscleBuilder_completeLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl3.right, comDataLbl3.top, 40, 30)];
    muscleBuilder_completeLbl.backgroundColor = [UIColor clearColor];
    [muscleBuilder_completeLbl setTextColor:[UIColor blackColor]];
    [muscleBuilder_completeLbl setFont:[UIFont systemFontOfSize:13]];
    [muscleBuilder_completeLbl setText:@"0.45%"];
    [scrollView addSubview:muscleBuilder_completeLbl];
    
    UILabel *comDataLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(muscleBuilder_completeLbl.right+50, muscleBuilder_completeLbl.top, 80, 30)];
    comDataLbl4.backgroundColor = [UIColor clearColor];
    [comDataLbl4 setTextColor:[UIColor blackColor]];
    [comDataLbl4 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl4 setText:@"增重比"];
    [scrollView addSubview:comDataLbl4];
    
    dynamite_completeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl4.right, comDataLbl4.top, 40, 30)];
    dynamite_completeRatioLbl.backgroundColor = [UIColor clearColor];
    [dynamite_completeRatioLbl setTextColor:[UIColor blackColor]];
    [dynamite_completeRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [dynamite_completeRatioLbl setText:@"0.5%"];
    [scrollView addSubview:dynamite_completeRatioLbl];

    
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(0, 440, self.view.size.width/2, 40);
    enterBtn.backgroundColor = [UIColor clearColor];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [enterBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [enterBtn setTitle:@"进入" forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(enterDidClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:enterBtn];
    
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteBtn.frame = CGRectMake(self.view.size.width/2, 440, self.view.size.width/2, 40);
    inviteBtn.backgroundColor = [UIColor clearColor];
    inviteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [inviteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [inviteBtn addTarget:self action:@selector(inviteDicClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:inviteBtn];
    
    
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width-10, 800)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)enterDidClick
{
    
}

- (void)inviteDicClick
{
    
}
@end
