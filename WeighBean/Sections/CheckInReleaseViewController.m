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
    
    //    self.title = @"添加标签";
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-150)];
    if (resultImg) {
        imageView.image = resultImg;
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
