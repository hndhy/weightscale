//
//  CheckInChooseTagViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInChooseTagViewController.h"


@implementation CheckInChooseTagViewController

- (void)initNavbar
{
    self.title = @"添加标签";
    //    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    //    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    //    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    //    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = backButtonItem;

}

- (void)initModel
{
    dataArray = [[NSMutableArray alloc] initWithObjects:@"hello",@"fsdfag",@"re",@"fdgfdge",@"bergerwf",@"rewd",@"eger",@"brtbrt",@"fsaf",@"htrr",@"saf",@"bfdsb",@"gerh",@"rwe",@"br",@"fsaf",@"hrg",@"fsdaf",@"rbrbr", nil];
    
    //    self.handle = [[CoachModelHandler alloc] initWithController:self];
    //    self.listModel = [[CoachListModel alloc] initWithHandler:self.handle];
    //    _dataArray = [[NSMutableArray alloc] init];
    //    [self.listModel getCoachListPage:1];
}

- (void)initView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, SCREEN_HEIGHT_EXCEPTNAV) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [searchBar setTintColor:[UIColor blackColor]];
    [searchBar setSearchBarStyle:UISearchBarStyleDefault];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
}

#pragma mark tableview delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identier = @"identier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
    }

    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
