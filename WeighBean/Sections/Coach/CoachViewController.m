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
#import "VerifyOrderViewController.h"
#import <UIImageView+WebCache.h>
#import "CoachModelHandler.h"
#import "CoachListModel.h"
#import "CoachChooseViewController.h"
#import "CoachNewBuildViewController.h"

#import "DissolveCoachModelHandler.h"
#import "DissolveCoachModel.h"


@interface CoachViewController ()<UITableViewDelegate,UITableViewDataSource,CoachModelProtocol,DissolveCoachModelProtocol,UIAlertViewDelegate,SWTableViewCellDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)CoachModelHandler *handle;
@property (nonatomic,strong)CoachListModel *listModel;
@property (nonatomic,strong)NSIndexPath *selectPath;

@property (nonatomic,strong)DissolveCoachModelHandler *dissolveCoachHandle;
@property (nonatomic,strong)DissolveCoachModel *dissolveCoachModel;

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
    [forwardButton addTarget:self action:@selector(createNew) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initModel
{
    self.handle = [[CoachModelHandler alloc] initWithController:self];
    self.listModel = [[CoachListModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    [self.listModel getCoachListPage:1];
    
    
    self.dissolveCoachHandle = [[DissolveCoachModelHandler alloc] initWithController:self];
    self.dissolveCoachModel = [[DissolveCoachModel alloc] initWithHandler:self.dissolveCoachHandle];
    
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

#pragma mark action

- (void)createNew
{
    CoachChooseViewController * vc = [[CoachChooseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)onSetingClick
{
    HideSetViewController *hide = [[HideSetViewController alloc] init];
    [self.navigationController pushViewController:hide animated:YES];
}

#pragma mark tableview delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identier = @"identier";
    CoachListCell *cell = (CoachListCell*)[tableView dequeueReusableCellWithIdentifier:identier];
    if (cell == nil)
    {
        cell = [[CoachListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
        cell.delegate = self;

    }
//    __weak typeof(self) weakSelf = self;
//    [cell setSelectBlock:^(NSInteger index,CoachObjModel *obj,NSIndexPath *path) {
//        [weakSelf selectIndex:index product:obj indexPath:path];
//    }];
    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor blueColor]
                                                title:@"编辑"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor blueColor]
                                                title:@"查看"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor blueColor]
                                                title:@"重启"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor blueColor]
                                                title:@"解散"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor blueColor]
                                                title:@"目标"];
    
    return rightUtilityButtons;
}

#pragma mark -SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *cellIndexPath = [_tableView indexPathForCell:cell];
    HTAppContext *appContext = [HTAppContext sharedContext];

    CoachObjModel *obj = _dataArray[cellIndexPath.row];

    switch (index) {
        case 0:
            NSLog(@"button 0 was pressed");
            [self editTeam:cellIndexPath];
            break;
        case 1:
            NSLog(@"button 1 was pressed");
            break;
        case 2:
            NSLog(@"button 2 was pressed");
            break;
        case 3:
            NSLog(@"button 3 was pressed");
            [self.dissolveCoachModel dissolveCoachWithUid:appContext.uid teamID:obj.tid];
            [_dataArray removeObjectAtIndex:cellIndexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        default:
            break;
    }
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    
}
//- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
//{
//    
//}
//- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
//{
//    
//}

- (void)editTeam:(NSIndexPath *)indexpath
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    CoachObjModel *obj = _dataArray[indexpath.row];

    CoachNewBuildViewController *vc = [[CoachNewBuildViewController alloc] initWithUserID:appContext.uid teamID:obj.tid teamName:obj.teamName];
    [self.navigationController pushViewController:vc animated:YES];
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
    [_dataArray addObjectsFromArray:response.data];
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
