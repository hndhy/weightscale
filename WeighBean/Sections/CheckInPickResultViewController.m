//
//  CheckInPickResultViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInPickResultViewController.h"
#import "CheckInChooseTagViewController.h"

@implementation CheckInPickResultViewController


- (id)initWithImg:(UIImage *)img
{
    self = [super init];
    if (self) {
        resultImg = img;
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
    
    
    UILabel *addTagLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, DEVICEW-160, 40)];
    addTagLbl.backgroundColor = [UIColor whiteColor];
    addTagLbl.textColor = [UIColor grayColor];
    addTagLbl.font = UIFontOfSize(14);
    addTagLbl.text = @"添加标签";
    addTagLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:addTagLbl];

    
    UIButton *addTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTipBtn.frame = CGRectMake(0, self.view.frame.size.height-40 , self.view.frame.size.width, 40);
    addTipBtn.backgroundColor = [UIColor clearColor];
    addTipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addTipBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [addTipBtn setTitle:@"添加标签" forState:UIControlStateNormal];
    [addTipBtn addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTipBtn];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 22, 19, 15)];
    btnBack.backgroundColor = [UIColor whiteColor];
    btnBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnBack setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
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

- (void)addTag
{
    CheckInChooseTagViewController *vc = [[CheckInChooseTagViewController alloc] initWithImage:resultImg];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
