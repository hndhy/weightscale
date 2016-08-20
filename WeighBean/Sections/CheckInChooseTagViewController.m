//
//  CheckInChooseTagViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInChooseTagViewController.h"
#import "CheckInReleaseViewController.h"
#import "NSDictionary+GetValue.h"
#import "TagObjModel.h"

@implementation CheckInChooseTagViewController


- (id)initWithImage:(UIImage *)img
{
    self = [super init];
    if (self) {
        sourceImg = img;
    }
    return self;
}

- (void)initNavbar
{
    self.title = @"添加标签";
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
//    dataArray = [[NSMutableArray alloc] initWithObjects:@"hello",@"fsdfag",@"re",@"fdgfdge",@"bergerwf",@"rewd",@"eger",@"brtbrt",@"fsaf",@"htrr",@"saf",@"bfdsb",@"gerh",@"rwe",@"br",@"fsaf",@"hrg",@"fsdaf",@"rbrbr", nil];
    selectedArr = [[NSMutableArray alloc] init];
    selectedDataArr = [[NSMutableArray alloc] init];
    
        self.handle = [[TagModelHandler alloc] initWithController:self];
        self.listModel = [[TagModel alloc] initWithHandler:self.handle];
        dataArray = [[NSMutableArray alloc] init];
        [self.listModel getTagList];
}

- (void)initView
{
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    self.view.backgroundColor = [UIColor whiteColor];
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, SCREEN_HEIGHT_EXCEPTNAV) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];

    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 34, 19, 15)];
    btnBack.backgroundColor = [UIColor whiteColor];
    btnBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnBack setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 20, self.view.frame.size.width-40, 44)];
    [searchBar setTintColor:[UIColor blackColor]];
    [searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    for (UIView *view in searchBar.subviews)
    {
        for (id subview in view.subviews)
        {
            if ( [subview isKindOfClass:[UIButton class]] )
            {
                [subview setEnabled:YES];
                UIButton *cancelButton = (UIButton*)subview;
                [cancelButton setTitle:@"确认" forState:UIControlStateNormal];
                [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
                return;
            }
        }
    }
}

- (void)backDidClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = dataArray[indexPath.row];
    if ([selectedArr containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectedArr containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        [selectedArr removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        [selectedDataArr removeObject:dataArray[indexPath.row]];
    } else
    {
        [selectedArr addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
        [selectedDataArr addObject:dataArray[indexPath.row]];
    }

    [tableView reloadData];
}

#pragma mark searchbardelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    CheckInReleaseViewController *vc = [[CheckInReleaseViewController alloc] initWithImg:sourceImg selectedArr:selectedDataArr];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --TagModelProtocol
- (void)syncFinished:(TagResponse *)response
{
    [dataArray removeAllObjects];
    for (int i=0; i<[response.data count]; i++) {
        TagObjModel *obj = [response.data objectAtIndex:i];
        NSString *str = obj.tagName;
        [dataArray addObject:str];
    }
    [_tableView reloadData];
}

- (void)syncFailure
{
    
}







@end
