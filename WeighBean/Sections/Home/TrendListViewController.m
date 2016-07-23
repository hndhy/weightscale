//
//  TrendListViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "TrendListViewController.h"
#import "BodilyDataViewController.h"
#import "TrendListDataSource.h"
#import "DBHelper.h"
#import "HtDelDatasModel.h"
#import "DelDatasModelHandler.h"

#import "TrendResponse.h"
#import "TrendModelHandler.h"
#import "TrendObjModel.h"

@interface TrendListViewController ()<DelDatasModelProtocol,TrendModelProtocol>

@property(nonatomic,strong) NSMutableArray *selectedArray;
@property(nonatomic,strong) UIButton *editButton;
@property(nonatomic,strong) TrendListDataSource *dataSource;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *delDataLab;
@property(nonatomic,strong) HtDelDatasModel *delModel;
@property(nonatomic,strong) DelDatasModelHandler *delHandler;

@property(nonatomic,assign) int offset;
@property(nonatomic,assign) int pageCount;

@property(nonatomic,strong) TrendObjModel *objModel;
@property(nonatomic,strong) TrendModelHandler *objHandler;

@property (nonatomic,copy) NSString *stamp;
@property (nonatomic,strong) NSString *avatar;

@property (nonatomic,assign) BOOL isFrist;

@end

@implementation TrendListViewController

-(void)initModel
{
    self.offset = 0;
    self.pageCount = 10;
    self.selectedArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.dataSource = [[TrendListDataSource alloc]initWithController:self];
    
    if (_otherUid)
    {
        self.objHandler = [[TrendModelHandler alloc]initWithController:self];
        self.objModel = [[TrendObjModel alloc]initWithHandler:self.objHandler];
    }
    else
    {
        self.delHandler = [[DelDatasModelHandler alloc]initWithController:self];
        self.delModel = [[HtDelDatasModel alloc]initWithHandler:self.delHandler];
    }
}

-(void)addBodyData:(BodyData*)model
{
    [self.selectedArray addObject:model];
    self.delDataLab.text = [NSString stringWithFormat:@"删除（%ld）",(unsigned long)self.selectedArray.count];

    for (int i = _selectedArray.count - 1; i >= 0; i--)
    {
        for (int j = i - 1; j >= 0; j--)
        {
            BodyData *bodyI = _selectedArray[i];
            BodyData *bodyJ = _selectedArray[j];
            NSTimeInterval timei = bodyI.measuretime.doubleValue;
            NSTimeInterval timej = bodyJ.measuretime.doubleValue;
            if (timei > timej)
            {
                BodyData *tem = bodyJ;
                [_selectedArray replaceObjectAtIndex:j withObject:bodyI];
                [_selectedArray replaceObjectAtIndex:i withObject:tem];
            }
        }
    }
}

-(void)removeBodyData:(BodyData*)model
{
    [self.selectedArray removeObject:model];
    self.delDataLab.text = [NSString stringWithFormat:@"删除（%ld）",(unsigned long)self.selectedArray.count];
}

-(BOOL)isInArray:(BodyData*)model
{
   return [self.selectedArray containsObject:model];
}

- (void)initNavbar
{
  self.title = @"趋势总结";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackUp:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (!_otherUid)
    {
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88.0f, 44.0f)];
        rightView.backgroundColor = [UIColor clearColor];
        
        self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editButton addTarget:self action:@selector(onEditClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *trendButton = [[UIButton alloc]initWithFrame:CGRectMake(rightView.width-34.0f, 0, 44.0f, 44.0f)];
        [trendButton setImage:[UIImage imageNamed:@"body_list"] forState:UIControlStateNormal];
        [trendButton addTarget:self action:@selector(onTrendClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:self.editButton];
        [rightView addSubview:trendButton];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIButton *trendButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [trendButton setImage:[UIImage imageNamed:@"body_list"] forState:UIControlStateNormal];
        [trendButton addTarget:self action:@selector(onTrendClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:trendButton];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] init];
        space.style =UIBarButtonSystemItemFixedSpace;
        space.width = 50;
        self.navigationItem.rightBarButtonItems = @[space,rightItem];
    }
}

- (void)initView
{
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15.0f, 0, self.view.width - 15.0f, 36.0f)
                                             withSize:13.0f withColor:UIColorFromRGB(120.0f, 120.0f, 120.0f)];
    titleLabel.text = @"选择要比较的数据（两条或更多）";
    [self.view addSubview:titleLabel];
    
    self.tableView = [[HTTableView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, self.view.width,
                                                                 SCREEN_HEIGHT_EXCEPTNAV - titleLabel.bottom)];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.allowsMultipleSelectionDuringEditing=YES;

    [self hookPullScrool:YES loadMore:YES];
    [self updateScrollSign];
    
    [self.view addSubview:self.tableView];
   
    if (!_otherUid)
    {
        [self getListDatas];
    }
    else
    {
        _isFrist = YES;
        [self.objModel getFristDataWithUid:_otherUid];
    }
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT_EXCEPTNAV-50, SCREEN_WIDTH, 50)];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineIV.backgroundColor = UIColorFromRGB(237, 237, 237);
    
    UILabel *delAllLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 30)];
    [delAllLab addTapCallBack:self sel:@selector(onDelAll)];
    delAllLab.text = @"全部删除";
    delAllLab.textColor = UIColorFromRGB(156, 156, 156);
    delAllLab.font = [UIFont systemFontOfSize:13.0f];
    [self.bottomView addSubview:delAllLab];
    
    self.delDataLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 30, 10, 80, 30)];
    [self.delDataLab addTapCallBack:self sel:@selector(onDelDatas)];
    self.delDataLab.text = @"删除（0）";
    self.delDataLab.textColor = UIColorFromRGB(46, 160, 184);
    self.delDataLab.font = [UIFont systemFontOfSize:13.0f];
    [self.bottomView addSubview:self.delDataLab];
    
    [self.bottomView addSubview:lineIV];
    self.bottomView.hidden = YES;
    [self.view addSubview:self.bottomView];
}

-(void)getListDatas
{
    HTUserData *userData = [HTUserData sharedInstance];
    [DBHelper getBodyData:[NSString stringWithFormat:@"uid='%@'",userData.uid] orderBy:@"measuretime" offset:self.offset count:self.pageCount black:^(NSMutableArray *result) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{

            [self stopAnimating];
            if (self.offset == 0)
            {
                [self.dataSource clearData];
            }
            [self.dataSource addDataArray:result];
            [self updateScrollSign];
            [self.tableView reloadData];
        });
        
    }];
}

-(void)onBackUp:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onEditClick:(id)sender
{
    if ([self.editButton.titleLabel.text isEqualToString:@"编辑"])
    {
        [self.editButton setTitle:@"取消" forState:UIControlStateNormal];
        self.bottomView.hidden = NO;
    }
    else
    {
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.bottomView.hidden = YES;
    }
}

-(void)onTrendClick:(id)sender
{
    long count = self.selectedArray.count;
    NSLog(@"count:==%ld",count);
    if (count < 2)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"至少选中两条数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    BodilyDataViewController *bodyVC = [[BodilyDataViewController alloc]init];
    bodyVC.bodilyArray = self.selectedArray;
    bodyVC.nickName = self.nickName;
    bodyVC.avatar = self.avatar;
    [self.navigationController pushViewController:bodyVC animated:YES];
}

//删除部分数据
-(void)onDelDatas
{
    UIAlertView* alertview =[[UIAlertView alloc] initWithTitle:@"删除数据" message:[NSString stringWithFormat:@"确定删除%ld条数据?", (unsigned long)self.selectedArray.count] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
    
}
//删除所有数据
-(void)onDelAll
{
    self.selectedArray = self.dataSource.dataArray;
    [self.tableView reloadData];
    
    UIAlertView* alertview =[[UIAlertView alloc] initWithTitle:@"删除数据" message:[NSString stringWithFormat:@"确定删除%ld条数据?", (unsigned long)self.selectedArray.count] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {//确定删除
        NSMutableString *ms = [[NSMutableString alloc]initWithString:@""];
        for(int i=0;i<self.selectedArray.count;i++)
        {
            BodyData *bodyData = [self.selectedArray objectAtIndex:i];
            [ms appendString:bodyData.measuretime];
            [ms appendString:@","];
            [DBHelper delBodyData:bodyData];
        }
        [ms deleteCharactersInRange:NSMakeRange(ms.length-1, 1)];
        NSLog(@"measuretime:%@",ms);
        [self.delModel delDatas:ms];
        [self.dataSource.dataArray removeObjectsInArray:self.selectedArray];
        [self.tableView reloadData];
        [self.selectedArray removeAllObjects];
        self.delDataLab.text = [NSString stringWithFormat:@"删除（%ld）",(unsigned long)self.selectedArray.count];
    }
}

- (void)pullRefreshData
{
    if (!_otherUid)
    {
        self.offset = 0;
        [self getListDatas];
    }
    else
    {
        _isFrist = YES;
        [self.objModel getFristDataWithUid:_otherUid];
    }
}

- (BOOL)hasMoreData
{
    return [self.dataSource isHasMoreData];
}
- (void)loadMoreData
{
    if (!_otherUid)
    {
        self.offset += self.pageCount;
        [self getListDatas];
    }
    else
    {
        [self.objModel getMoreWithUid:_otherUid lastId:_stamp];
    }
}

- (void)stopAnimating
{
    if (nil != self.tableView.pullToRefreshView)
    {
        [self.tableView.pullToRefreshView stopAnimating];
    }
    if (nil != self.tableView.infiniteScrollingView)
    {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
}

- (void)delFinished:(BaseResponse *)response
{
    
}

- (void)syncFinished:(TrendResponse *)response
{
    self.stamp = response.stamp;
    self.avatar = response.userinfo.avatar.length ? response.userinfo.avatar : @"http://www";
    NSMutableArray *mdata = [[NSMutableArray alloc] init];
    NSArray *dataArray = response.results;
    for (int i=0; i<dataArray.count; i++)
    {
        SyncBodyData *sbd = [dataArray objectAtIndex:i];
        BodyData *bodyData = [[BodyData alloc]init];
        bodyData.W = [NSString stringWithFormat:@"%.1f",sbd.w.floatValue];
        bodyData.uid = [NSString stringWithFormat:@"%@",@""];
        bodyData.BMI = [NSString stringWithFormat:@"%.1f",sbd.bmi.floatValue];
        bodyData.FAT = [NSString stringWithFormat:@"%.1f",sbd.fat.floatValue];
        bodyData.BMC = sbd.bmc;
        bodyData.LBM = [NSString stringWithFormat:@"%.1f",sbd.lbm.floatValue];
        bodyData.TBW = [NSString stringWithFormat:@"%.1f",sbd.tbw.floatValue];
        bodyData.VAT = sbd.vat;
        bodyData.Kcal = sbd.kcal;
        bodyData.BODY_AGE = sbd.bodyAge;
        bodyData.issync = @"1";
        bodyData.uid = sbd.id;
        bodyData.measuretime = sbd.measureTime;
        bodyData.smr = [NSString stringWithFormat:@"%.1f",sbd.smr.floatValue];
        [mdata addObject:bodyData];
    }
    [self stopAnimating];
    if (_isFrist)
    {
        [self.dataSource clearData];
        _isFrist = NO;
    }
    [self.dataSource addDataArray:mdata];
    [self updateScrollSign];
    [self.tableView reloadData];
}

- (void)syncFailure
{
    
}

@end
