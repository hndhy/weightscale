//
//  OnlineBuyViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/13.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "OnlineBuyViewController.h"
#import "UIViewController+RESideMenu.h"
#import "ProductCell.h"
#import "VerifyOrderViewController.h"

#import "OnlineModelHandler.h"
#import "OnlineListModel.h"

#import <UIImageView+WebCache.h>

@interface OnlineBuyViewController ()<UITableViewDelegate,UITableViewDataSource,OnlineModelProtocol,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)OnlineModelHandler *handle;
@property (nonatomic,strong)OnlineListModel *listModel;
@property (nonatomic,strong)NSIndexPath *selectPath;

@end

@implementation OnlineBuyViewController

- (void)initModel
{
    self.handle = [[OnlineModelHandler alloc] initWithController:self];
    self.listModel = [[OnlineListModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    [self.listModel getOnlineListPage:1];
}

- (void)initNavbar
{
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 145.0f, 44.0f)];
    self.navigationItem.titleView = titleView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, titleView.width, 44.0f)
                                               withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"在线购买";
    [titleView addSubview:titleLabel];
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

- (void)syncFinished:(OnlineListResponse *)response
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
