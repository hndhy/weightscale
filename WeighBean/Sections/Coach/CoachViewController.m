//
//  CoachViewController.m
//  WeighBean
//
//  Created by heng on 15/8/16.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CoachViewController.h"
#import "LibMacro.h"
#import <RESideMenu.h>
#import "HTTabBarController.h"
#import "ClockInViewController.h"
#import "PlanViewController.h"
#import "CoursesViewController.h"
#import "HTNavigationController.h"
#import "HideSetViewController.h"
//#import "QuestionViewController.h"
#import "QHistoryViewController.h"
#import "UIViewController+RESideMenu.h"
#import "CoachListCell.h"
#import "VerifyOrderViewController.h"
#import <UIImageView+WebCache.h>
#import "CoachModelHandler.h"
#import "CoachListModel.h"
@interface CoachViewController ()<UITableViewDelegate,UITableViewDataSource,CoachModelProtocol,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)CoachModelHandler *handle;
@property (nonatomic,strong)CoachListModel *listModel;
@property (nonatomic,strong)NSIndexPath *selectPath;

@end

@implementation CoachViewController

- (void)initNavbar
{
    self.title = @"V身战队";
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [forwardButton setTitle:@"新建" forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(onSetingClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initModel
{
    self.handle = [[CoachModelHandler alloc] initWithController:self];
    self.listModel = [[CoachListModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    [self.listModel getCoachListPage:1];
}

- (void)initView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAV) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)onSetingClick
{
    HideSetViewController *hide = [[HideSetViewController alloc] init];
    [self.navigationController pushViewController:hide animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identier = @"identier";
    CoachListCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
    if (!cell)
    {
        cell = [[CoachListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
    }
    __weak typeof(self) weakSelf = self;
    [cell setSelectBlock:^(NSInteger index,CoachObjModel *obj,NSIndexPath *path) {
        [weakSelf selectIndex:index product:obj indexPath:path];
    }];
    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
    return cell;
}

- (void)selectIndex:(NSInteger )index product:(CoachObjModel *)obj indexPath:(NSIndexPath *)path
{
//    if (index == 3)
//    {
//        VerifyOrderViewController *ver = [[VerifyOrderViewController alloc] init];
//        ver.weburl = obj.taobaourl;
//        [self.navigationController pushViewController:ver animated:YES];
//    }
//    else
//    {
//        self.selectPath = path;
//        NSString *msg = [NSString stringWithFormat:@"你确定要拨打%@电话%@吗?",(index == 1 ? @"售前":@"售后"),(index == 1 ?obj.preTel : obj.afterTel)];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alert.tag = index == 1 ? 0xfab : 0xfbc;
//        [alert show];
//    }
}

- (void)syncFinished:(CoachListResponse *)response
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:response.results];
    [_tableView reloadData];
}

- (void)syncFailure
{
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 &&( alertView.tag == 0xfab || alertView.tag == 0xfbc))
    {
        if (_selectPath.row < _dataArray.count)
        {
            CoachObjModel *obj = _dataArray [_selectPath.row];
//            NSString *tell = [NSString stringWithFormat:@"tel:%@",(alertView.tag == 0xfab ?obj.preTel : obj.afterTel)];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
        }
    }
    _selectPath = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
