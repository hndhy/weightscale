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
    self.title = @"添加标签";
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
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height-150)];
    if (resultImg) {
        imageView.image = resultImg;
    }
    [self.view addSubview:imageView];

    
    UIButton *addTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTipBtn.frame = CGRectMake(0, self.view.frame.size.height-120 , self.view.frame.size.width, 50);
    addTipBtn.backgroundColor = [UIColor clearColor];
    addTipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addTipBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addTipBtn setTitle:@"添加标签" forState:UIControlStateNormal];
    [addTipBtn addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTipBtn];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)addTag
{
    CheckInChooseTagViewController *vc = [[CheckInChooseTagViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];

}


@end
