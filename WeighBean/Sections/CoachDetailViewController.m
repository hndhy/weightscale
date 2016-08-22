//
//  CoachDetailViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/9.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachDetailViewController.h"
#import "TimelineViwController.h"

@implementation CoachDetailViewController
- (id)initWithTeamID:(NSString *)tid
{
    self = [super init];
    if (self) {
        teamID = tid;
    }
    return self;
}

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
    
//    @property (nonatomic,strong)ViewCoachDetailModelHandler *viewCoachDetailModelHandler;
//    @property (nonatomic,strong)ViewCoachDetailModel *viewCoachDetailModel;
    self.viewCoachDetailModelHandler = [[ViewCoachDetailModelHandler alloc] initWithController:self];
    self.viewCoachDetailModel = [[ViewCoachDetailModel alloc] initWithHandler:self.viewCoachDetailModelHandler];
}

- (void)initView
{
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.frame = CGRectMake(5, 5, DEVICEW-10, DEVICEH);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.layer.cornerRadius = 4.0;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    coachTypeLbl = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 40, 60)];
    [coachTypeLbl setBackgroundImage:[UIImage imageNamed:@"coachflag"] forState:UIControlStateNormal];
    [coachTypeLbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    coachTypeLbl.titleLabel.font = UIFontOfSize(15);
    coachTypeLbl.titleLabel.textAlignment = NSTextAlignmentCenter;
    [coachTypeLbl setTitle:@"增肌" forState:UIControlStateNormal];
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
   
    
    lineView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 120, DEVICEW-40, 0.5f)];
    lineView1.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView1];
    
    lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left, lineView1.bottom+44, lineView1.width, 0.5f)];
    lineView2.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView2];
    
    lineView3 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left+5, lineView2.bottom+44, lineView1.width-10, 0.5f)];
    lineView3.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView3];
    
    lineView4 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left+5, lineView3.bottom+44, lineView1.width-10, 0.5f)];
    lineView4.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView4];
    
    lineView5 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left, lineView4.bottom+44, lineView1.width, 0.5f)];
    lineView5.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView5];
    
    lineView6 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left, lineView5.bottom+44, lineView1.width, 0.5f)];
    lineView6.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView6];
    
    lineView7 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left, lineView6.bottom+44, lineView1.width, 0.5f)];
    lineView7.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView7];
    
    lineView8 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left, lineView7.bottom+44, lineView1.width, 0.5f)];
    lineView8.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView8];
    
    lineView9 = [[UIView alloc] initWithFrame:CGRectMake(lineView1.left+5, lineView8.bottom+44, lineView1.width-10, 0.5f)];
    lineView9.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView9];
    
    lineView10 = [[UIView alloc] initWithFrame:CGRectMake(0, lineView9.bottom+44, DEVICEW-10, 0.5f)];
    lineView10.backgroundColor = UIColorFromRGB(238, 238, 238);
    [scrollView addSubview:lineView10];
    
    
    
    UILabel *idTitleLbl = [UILabel createLabelWithFrame:CGRectMake(15, 80, DEVICEW - 40, 40) withSize:14.0f withColor:[UIColor blackColor]];
    idTitleLbl.text = @"ID信息";
    [scrollView addSubview:idTitleLbl];
    
    teamIdLbl = [UILabel createLabelWithFrame:idTitleLbl.frame withSize:14.0f withColor:[UIColor blackColor]];
    teamIdLbl.textAlignment = NSTextAlignmentRight;
    teamIdLbl.text = @"2332221";
    [scrollView addSubview:teamIdLbl];

    
    UILabel *ingTitleLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, lineView1.bottom+5, 75, 30)];
    ingTitleLbl1.backgroundColor = [UIColor clearColor];
    [ingTitleLbl1 setTextColor:[UIColor blackColor]];
    [ingTitleLbl1 setFont:[UIFont systemFontOfSize:14]];
    [ingTitleLbl1 setText:@"正在进行中"];
    [scrollView addSubview:ingTitleLbl1];
    
    UILabel *ingTitleLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(ingTitleLbl1.right, ingTitleLbl1.top, 160, 30)];
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
    
    
    UILabel *ingDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, lineView2.bottom+5, 140, 30)];
    ingDataLbl.backgroundColor = [UIColor clearColor];
    [ingDataLbl setTextColor:[UIColor blackColor]];
    [ingDataLbl setFont:[UIFont systemFontOfSize:14]];
    [ingDataLbl setText:@"进行中数据统计"];
    [scrollView addSubview:ingDataLbl];
    
    UILabel *dataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(25, lineView3.bottom+5, 80, 30)];
    dataLbl1.backgroundColor = [UIColor clearColor];
    [dataLbl1 setTextColor:[UIColor lightGrayColor]];
    [dataLbl1 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl1 setText:@"人均减脂重量"];
    [scrollView addSubview:dataLbl1];
    
    meanfatLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl1.right+15, dataLbl1.top, 40, 30)];
    meanfatLbl.backgroundColor = [UIColor clearColor];
    [meanfatLbl setTextColor:UIColorFromRGB(255, 102, 82)];
    [meanfatLbl setFont:[UIFont systemFontOfSize:13]];
    [meanfatLbl setText:@"0.5%"];
    [scrollView addSubview:meanfatLbl];
    
    UILabel *dataLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(meanfatLbl.right+35, dataLbl1.top, 60, 30)];
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
    
    UILabel *dataLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl1.left, lineView4.bottom+5, 80, 30)];
    dataLbl3.backgroundColor = [UIColor clearColor];
    [dataLbl3 setTextColor:[UIColor lightGrayColor]];
    [dataLbl3 setFont:[UIFont systemFontOfSize:13]];
    [dataLbl3 setText:@"人均增肌重量"];
    [scrollView addSubview:dataLbl3];
    
    muscleBuilderLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataLbl3.right+15, dataLbl3.top, 40, 30)];
    muscleBuilderLbl.backgroundColor = [UIColor clearColor];
    [muscleBuilderLbl setTextColor:UIColorFromRGB(90, 234, 178)];
    [muscleBuilderLbl setFont:[UIFont systemFontOfSize:13]];
    [muscleBuilderLbl setText:@"0.45%"];
    [scrollView addSubview:muscleBuilderLbl];
    
    UILabel *dataLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(muscleBuilderLbl.right+35, dataLbl3.top, 60, 30)];
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
    
    
    
    UILabel *ingValid = [UILabel createLabelWithFrame:CGRectMake(15, lineView5.bottom+5, DEVICEW - 40, 30) withSize:14.0f withColor:[UIColor blackColor]];
    ingValid.text = @"进行中有效率";
    [scrollView addSubview:ingValid];
    
    underwayRatioLbl = [UILabel createLabelWithFrame:ingValid.frame withSize:14.0f withColor:[UIColor blackColor]];
    underwayRatioLbl.textAlignment = NSTextAlignmentRight;
    underwayRatioLbl.text = @"25%";
    [scrollView addSubview:underwayRatioLbl];
    
    
    UILabel *completeValid = [UILabel createLabelWithFrame:CGRectMake(15, lineView6.bottom+5, DEVICEW - 40, 30) withSize:14.0f withColor:[UIColor blackColor]];
    completeValid.text = @"已完成有效率";
    [scrollView addSubview:completeValid];
    
    completeRatioLbl = [UILabel createLabelWithFrame:completeValid.frame withSize:14.0f withColor:[UIColor blackColor]];
    completeRatioLbl.textAlignment = NSTextAlignmentRight;
    completeRatioLbl.text = @"5%";
    [scrollView addSubview:completeRatioLbl];
    
    
    UILabel *completeDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, lineView7.bottom+5, 100, 30)];
    completeDataLbl.backgroundColor = [UIColor clearColor];
    [completeDataLbl setTextColor:[UIColor blackColor]];
    [completeDataLbl setFont:[UIFont systemFontOfSize:13]];
    [completeDataLbl setText:@"已完成数据统计"];
    [scrollView addSubview:completeDataLbl];
    
    
    UILabel *comDataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(25, lineView8.bottom+5, 80, 30)];
    comDataLbl1.backgroundColor = [UIColor clearColor];
    [comDataLbl1 setTextColor:[UIColor lightGrayColor]];
    [comDataLbl1 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl1 setText:@"人均减脂重量"];
    [scrollView addSubview:comDataLbl1];
    
    meanfat_completeLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl1.right+15, comDataLbl1.top, 40, 30)];
    meanfat_completeLbl.backgroundColor = [UIColor clearColor];
    [meanfat_completeLbl setTextColor:UIColorFromRGB(255, 102, 82)];
    [meanfat_completeLbl setFont:[UIFont systemFontOfSize:13]];
    [meanfat_completeLbl setText:@"0.5%"];
    [scrollView addSubview:meanfat_completeLbl];
    
    UILabel *comDataLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(meanfat_completeLbl.right+35, comDataLbl1.top, 60, 30)];
    comDataLbl2.backgroundColor = [UIColor clearColor];
    [comDataLbl2 setTextColor:[UIColor lightGrayColor]];
    [comDataLbl2 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl2 setText:@"减重比"];
    [scrollView addSubview:comDataLbl2];
    
    loseWeight_completeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl2.right, comDataLbl1.top, 40, 30)];
    loseWeight_completeRatioLbl.backgroundColor = [UIColor clearColor];
    [loseWeight_completeRatioLbl setTextColor:[UIColor blackColor]];
    [loseWeight_completeRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [loseWeight_completeRatioLbl setText:@"0.5%"];
    [scrollView addSubview:loseWeight_completeRatioLbl];
    
    UILabel *comDataLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl1.left, lineView9.bottom+5, 80, 30)];
    comDataLbl3.backgroundColor = [UIColor clearColor];
    [comDataLbl3 setTextColor:[UIColor lightGrayColor]];
    [comDataLbl3 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl3 setText:@"人均增肌重量"];
    [scrollView addSubview:comDataLbl3];
    
    muscleBuilder_completeLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl3.right+15, comDataLbl3.top, 40, 30)];
    muscleBuilder_completeLbl.backgroundColor = [UIColor clearColor];
    [muscleBuilder_completeLbl setTextColor:UIColorFromRGB(90, 234, 178)];
    [muscleBuilder_completeLbl setFont:[UIFont systemFontOfSize:13]];
    [muscleBuilder_completeLbl setText:@"0.45%"];
    [scrollView addSubview:muscleBuilder_completeLbl];
    
    
    UILabel *comDataLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(muscleBuilder_completeLbl.right+35, comDataLbl3.top, 60, 30)];
    comDataLbl4.backgroundColor = [UIColor clearColor];
    [comDataLbl4 setTextColor:[UIColor lightGrayColor]];
    [comDataLbl4 setFont:[UIFont systemFontOfSize:13]];
    [comDataLbl4 setText:@"增重比"];
    [scrollView addSubview:comDataLbl4];
    
    dynamite_completeRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(comDataLbl4.right, comDataLbl3.top, 40, 30)];
    dynamite_completeRatioLbl.backgroundColor = [UIColor clearColor];
    [dynamite_completeRatioLbl setTextColor:[UIColor blackColor]];
    [dynamite_completeRatioLbl setFont:[UIFont systemFontOfSize:13]];
    [dynamite_completeRatioLbl setText:@"0.5%"];
    [scrollView addSubview:dynamite_completeRatioLbl];

    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(0, lineView10.bottom+5, DEVICEW/2, 40);
    enterBtn.backgroundColor = [UIColor clearColor];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [enterBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [enterBtn setTitle:@"进入" forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(enterDidClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:enterBtn];
    
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteBtn.frame = CGRectMake(DEVICEW/2, lineView10.bottom+5, self.view.size.width/2, 40);
    inviteBtn.backgroundColor = [UIColor clearColor];
    inviteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [inviteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [inviteBtn addTarget:self action:@selector(inviteDicClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:inviteBtn];
    
    
    [scrollView setContentSize:CGSizeMake(DEVICEW-10, lineView10.bottom+120)];

    [self.viewCoachDetailModel viewCoachDetailWithUid:teamID];
}

- (void)viewCoachDetailFinished:(ViewCoachDetailResponse *)response
{
    
    switch ([response.data.teamType integerValue]) {
        case 1:
            [coachTypeLbl setTitle:@"减脂" forState:UIControlStateNormal];
            break;
        case 2:
            [coachTypeLbl setTitle:@"增肌" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    NSDate *startTimesp = [NSDate dateWithTimeIntervalSince1970:[response.data.startTime intValue]/1000];
    NSDate *endTimesp = [NSDate dateWithTimeIntervalSince1970:[response.data.endTime intValue]/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    [startTimeLbl setText:[NSString stringWithFormat:@"开始时间：%@",[formatter stringFromDate:startTimesp]]];
    [endTimeLbl setText:[NSString stringWithFormat:@"结束时间：%@",[formatter stringFromDate:endTimesp]]];
    [teamIdLbl setText:response.data.teamId];
    [activeRatioLbl setText:[NSString stringWithFormat:@"%@/%@",response.data.brisk_num,response.data.sum_num]];
    
    [meanfatLbl setText:[NSString stringWithFormat:@"%@%%",response.data.meanfat]];
    [loseWeightRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.loseWeight]];
    [muscleBuilderLbl setText:[NSString stringWithFormat:@"%@%%",response.data.muscleBuilder]];
    [dynamiteRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.dynamite]];
    
    [underwayRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.underway]];
    [completeRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.complete]];
    
    [meanfat_completeLbl setText:[NSString stringWithFormat:@"%@%%",response.data.meanfat_complete]];
    [loseWeight_completeRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.loseWeight_complete]];
    [muscleBuilder_completeLbl setText:[NSString stringWithFormat:@"%@%%",response.data.muscleBuilder_complete]];
    [dynamite_completeRatioLbl setText:[NSString stringWithFormat:@"%@%%",response.data.dynamite_complete]];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)enterDidClick
{
//    TeamLineViewController * teamLineVC = [[TeamLineViewController alloc] initWithTeamID:teamID];
    TimelineViwController *teamLineVC = [[TimelineViwController alloc] initWithTeamID:teamID];
    [self.navigationController pushViewController:teamLineVC animated:YES];

}

- (void)inviteDicClick
{
    
}
@end
