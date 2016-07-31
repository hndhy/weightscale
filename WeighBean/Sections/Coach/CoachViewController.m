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




//#import "OnlineBuyViewController.h"
#import "UIViewController+RESideMenu.h"
#import "ProductCell.h"
#import "VerifyOrderViewController.h"

//#import "OnlineModelHandler.h"
//#import "OnlineListModel.h"

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
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];//SCREEN_HEIGHT_EXCEPTNAVANDTAB
//    self.webView.delegate = self;
//    [self.view addSubview:self.webView];
//    HTUserData *userData = [HTUserData sharedInstance];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/vcoach.htm?os=ios&uid=%@", WEB_URL, userData.uid]];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [self.webView loadRequest:request];
//    [self showHUD];
    
    
    
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
//    NSString *push = [[NSUserDefaults standardUserDefaults] objectForKey:@"needpushnext"];
//    if (push.length)
//    {
//        HTUserData *user = [HTUserData sharedInstance];
//        NSString *tem = [NSString stringWithFormat:@"hyd://www.hyd.com?action=daka_sns&param=self_%@&flash=true",user.uid];
//        NSArray *urlComps = [tem componentsSeparatedByString:@"yd://"];
////        [self pushNext:urlComps];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"needpushnext"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
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
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
    if (!cell)
    {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
    }
    __weak typeof(self) weakSelf = self;
    [cell setSelectBlock:^(NSInteger index,OLProductModel *obj,NSIndexPath *path) {
        [weakSelf selectIndex:index product:obj indexPath:path];
    }];
    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
    return cell;
}

- (void)selectIndex:(NSInteger )index product:(OLProductModel *)obj indexPath:(NSIndexPath *)path
{
    if (index == 3)
    {
        VerifyOrderViewController *ver = [[VerifyOrderViewController alloc] init];
        ver.weburl = obj.taobaourl;
        //        ver.weburl = @"http://item.taobao.com/item.htm?id=41029553793";
        //        ver.clienturl = @"taobao://item.taobao.com/item.htm?id=41029553793";
        [self.navigationController pushViewController:ver animated:YES];
    }
    else
    {
        self.selectPath = path;
        NSString *msg = [NSString stringWithFormat:@"你确定要拨打%@电话%@吗?",(index == 1 ? @"售前":@"售后"),(index == 1 ?obj.preTel : obj.afterTel)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = index == 1 ? 0xfab : 0xfbc;
        [alert show];
    }
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
            OLProductModel *obj = _dataArray [_selectPath.row];
            NSString *tell = [NSString stringWithFormat:@"tel:%@",(alertView.tag == 0xfab ?obj.preTel : obj.afterTel)];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
        }
    }
    _selectPath = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






//- (void)pushNext:(NSArray *)urlComps
//{
//    NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"?"];
//    NSString *funcStr = [arrFucnameAndParameter objectAtIndex:1];
//    NSArray *parms=  [funcStr componentsSeparatedByString:@"&"];
//    NSMutableDictionary *itemDic=[[NSMutableDictionary alloc]init];
//    for (NSString *str  in parms) {
//        NSArray *item=[str componentsSeparatedByString:@"="];
//        [itemDic setObject:item[1] forKey:item[0]];
//    }
//    
//    NSString *action = [itemDic objectForKey:@"action"];
//    NSString *uid = [itemDic objectForKey:@"param"];
//    
//    
//    HTTabBarController *tabBarController = [[HTTabBarController alloc] init];
//    
//    QHistoryViewController *coursesController = [[QHistoryViewController alloc] init];
//    coursesController.isOpenSide = YES;
//    coursesController.nav = self.navigationController;
//    HTNavigationController *coursesNav = [[HTNavigationController alloc] initWithRootViewController:coursesController];
//    [tabBarController addViewController:coursesNav];
//    
//    ClockInViewController *clockInController = [[ClockInViewController alloc] init];
//    HTNavigationController *clockInNav = [[HTNavigationController alloc] initWithRootViewController:clockInController];
//    clockInController.actionName = action;
//    clockInController.clockUid = uid;
//    [tabBarController addViewController:clockInNav];
//    
//    HideSetViewController *planController = [[HideSetViewController alloc] init];
//    HTNavigationController *planNav = [[HTNavigationController alloc] initWithRootViewController:planController];
//    [tabBarController addViewController:planNav];
//    
//    __weak HTTabBarController *weakTabbar = tabBarController;
//    void (^block)(void) = ^{
//        weakTabbar.title = @"V教练战队";
//        UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 44.0f)];
//        [refreButton setImage:[UIImage imageNamed:@"refresh_nav_bar.png"] forState:UIControlStateNormal];
//        [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
//        [refreButton addTarget:clockInController action:@selector(refreshWeb) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
//        [weakTabbar.navigationItem setRightBarButtonItems:@[refreItem]];
//    };
//    tabBarController.setTopBlock=block;
//    void (^otherBlock)(void) = ^{
//        weakTabbar.title = @"问卷历史";
//        UIButton *refreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//        [refreButton setImage:[UIImage imageNamed:@"add_nav_bar.png"] forState:UIControlStateNormal];
//        //            [refreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
//        [refreButton addTarget:coursesController action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *refreItem = [[UIBarButtonItem alloc] initWithCustomView:refreButton];
//        UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
//        space.width = 40;
//        space.style = UIBarButtonSystemItemFixedSpace;
//        
//        [weakTabbar.navigationItem setRightBarButtonItems:@[space,refreItem]];
//    };
//    tabBarController.setOtherTopBlock=otherBlock;
//    
//    [tabBarController showControllerWithTag:1];
//    
//    [tabBarController setIsCanBackBlock:^BOOL{
//        return [coursesController isCanBack];
//    }];
//    
//    [self.navigationController pushViewController:tabBarController animated:YES];
//}






















//- (void)initNavbar
//{
//    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 145.0f, 44.0f)];
//    self.navigationItem.titleView = titleView;
//    
//    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, titleView.width, 44.0f)
//                                               withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"在线购买";
//    [titleView addSubview:titleLabel];
//}

//- (void)initView
//{
//    if (!_tableView)
//    {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT_EXCEPTNAV) style:UITableViewStylePlain];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    [self.view addSubview:_tableView];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//{
//    return _dataArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 250;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    static NSString *identier = @"identier";
//    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
//    if (!cell)
//    {
//        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
//    }
//    __weak typeof(self) weakSelf = self;
//    [cell setSelectBlock:^(NSInteger index,OLProductModel *obj,NSIndexPath *path) {
//        [weakSelf selectIndex:index product:obj indexPath:path];
//    }];
//    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
//    return cell;
//}
//
//- (void)selectIndex:(NSInteger )index product:(OLProductModel *)obj indexPath:(NSIndexPath *)path
//{
//    if (index == 3)
//    {
//        VerifyOrderViewController *ver = [[VerifyOrderViewController alloc] init];
//        ver.weburl = obj.taobaourl;
//        //        ver.weburl = @"http://item.taobao.com/item.htm?id=41029553793";
//        //        ver.clienturl = @"taobao://item.taobao.com/item.htm?id=41029553793";
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
//}
//
//- (void)syncFinished:(OnlineListResponse *)response
//{
//    [_dataArray removeAllObjects];
//    [_dataArray addObjectsFromArray:response.results];
//    [_tableView reloadData];
//}
//
//- (void)syncFailure
//{
//    
//}
//
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1 &&( alertView.tag == 0xfab || alertView.tag == 0xfbc))
//    {
//        if (_selectPath.row < _dataArray.count)
//        {
//            OLProductModel *obj = _dataArray [_selectPath.row];
//            NSString *tell = [NSString stringWithFormat:@"tel:%@",(alertView.tag == 0xfab ?obj.preTel : obj.afterTel)];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
//        }
//    }
//    _selectPath = nil;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
