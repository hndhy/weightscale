//
//  CheckInReleaseViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInReleaseViewController.h"
#import "UIView+Tag.h"
#import "TimelineViwController.h"

@implementation CheckInReleaseViewController
- (id)initWithImg:(UIImage *)img selectedArr:(NSMutableArray *)arr
{
    self = [super init];
    if (self) {
        resultImg = img;
        sourceArr = arr;
    }
    return self;
}

- (void)initNavbar
{
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (DEVICEH-DEVICEW)/2, DEVICEW, DEVICEW)];
    if (resultImg) {
        imageView.image = resultImg;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    [self.view addSubview:imageView];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 22, 19, 15)];
    btnBack.backgroundColor = [UIColor whiteColor];
    btnBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnBack setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];

    
    UILabel *addTagLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, DEVICEW-160, 40)];
    addTagLbl.backgroundColor = [UIColor whiteColor];
    addTagLbl.textColor = [UIColor grayColor];
    addTagLbl.font = UIFontOfSize(14);
    addTagLbl.text = @"去发布";
    addTagLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:addTagLbl];
    
    
    UIButton *addTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTipBtn.frame = CGRectMake(0, self.view.frame.size.height-40 , self.view.frame.size.width, 40);
    addTipBtn.backgroundColor = [UIColor clearColor];
    addTipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addTipBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [addTipBtn setTitle:@"发布" forState:UIControlStateNormal];
    [addTipBtn addTarget:self action:@selector(releasePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTipBtn];
    
    NSArray *percentArray = @[[NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)],[NSValue valueWithCGPoint:CGPointMake(0.2, 0.8)],[NSValue valueWithCGPoint:CGPointMake(0.8, 0.7)]];
    NSArray *textArray = @[@"测试",@"测试默默",@"人群中寻找"];
    [imageView aj_showTagsWithPercentArray:percentArray textArray:sourceArr];
    imageView.userInteractionEnabled = YES;
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 46, DEVICEW, 1)];
    lineView1.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.view addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICEH-50, DEVICEW, 1)];
    lineView2.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.view addSubview:lineView2];


    
}

- (void)backDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)releasePhoto
{
    TimelineViwController *vc = [[TimelineViwController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
