//
//  BodilyDataViewController.m
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BodilyDataViewController.h"
#import "BDDataSource.h"
#import "PNLineChartView.h"
#import "DBHelper.h"
#import "PNPlot.h"
#import "SharePlat.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Utilities.h"

#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>

@interface BodilyDataViewController ()<SharePlatDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) BDDataSource *dataSource;
@property (nonatomic, strong) SharePlat *sharePlat;
@property (nonatomic, strong) PNLineChartView *lineChartView;
@property (nonatomic, strong) UIButton *trendButton;//右上角变化图标
@property (nonatomic, strong) UIView *timeView;//测量时间显示
@property (nonatomic, strong) UIView *diffView;//差值view显示
@property (nonatomic, strong) UIView *valueListView;
@property (nonatomic, strong) UIView *trendView;

@end

@implementation BodilyDataViewController

- (id)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        dataType = type;
    }
    return self;
}

-(void)initModel
{
    self.dataSource = [[BDDataSource alloc]initWithController:self];
    currentPage = 0;
}

- (void)initNavbar
{
    HTUserData *userData = [HTUserData sharedInstance];
    self.title = userData.nick;
    if (self.nickName)
    {
        self.title = self.nickName;
    }
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackUp:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88.0f, 44.0f)];
    rightView.backgroundColor = [UIColor clearColor];
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [forwardButton setImage:[UIImage imageNamed:@"home_forward_icon.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(onForwardClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.trendButton = [[UIButton alloc]initWithFrame:CGRectMake(rightView.width-34.0f, 0, 44.0f, 44.0f)];
    [self.trendButton setImage:[UIImage imageNamed:@"addimg"] forState:UIControlStateNormal];
    [self.trendButton addTarget:self action:@selector(onTrendClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:forwardButton];
    [rightView addSubview:self.trendButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initView{

//    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45.0f)];
//    titleImageView.image = [UIImage imageNamed:@"home_title.png"];
//    [self.view addSubview:titleImageView];
//    titleImageView.hidden = YES;
    
    /**
     测量时间显示视图
     */
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.view.width, 189)];
    self.timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timeView];
    
    /**测量前后差比*/
    self.diffView = [[UIView alloc]initWithFrame:CGRectMake(0, self.timeView.bottom+8, self.view.width, 70)];
    self.diffView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.diffView];
    
//列表展现形式
    self.valueListView = [[UIView alloc]initWithFrame:CGRectMake(0, self.diffView.bottom + 5, self.view.width,
                                                                 SCREEN_HEIGHT_EXCEPTNAV - self.diffView.bottom - 5.0f)];
    self.valueListView.backgroundColor = [UIColor whiteColor];
    //列表展示标题
    [self createListView];
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 1)];
    lineIV.backgroundColor = UIColorFromRGB(237, 237, 237);
    [self.valueListView addSubview:lineIV];
    
    //列表listview
    self.tableView = [[HTTableView alloc] initWithFrame:CGRectMake(0, 31,SCREEN_WIDTH, self.valueListView.height - 31)];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    [self.valueListView addSubview:self.tableView];
    [self.view addSubview:self.valueListView];
    
    
    //曲线展现形式
    self.trendView = [[UIView alloc]initWithFrame:CGRectMake(0, self.diffView.bottom+5, self.view.width, self.view.height-self.diffView.bottom-5)];
    self.trendView.backgroundColor = [UIColor whiteColor];
    self.trendView.hidden = YES;
    [self.view addSubview:self.trendView];
    //曲线图色块解释
    
//    [self createTrendView];
    
    //曲线图
    self.lineChartView=[[PNLineChartView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, 268+60)];
    self.lineChartView.userInteractionEnabled=NO;
    self.lineChartView.backgroundColor=[UIColor clearColor];
    self.lineChartView.xAxisFontColor=self.lineChartView.horizontalLinesColor=[UIColor lightGrayColor]; //横，纵坐标的字体颜色
    [self.trendView addSubview:self.lineChartView];
    [self setLineChartValue:0];
    
    self.sharePlat = [SharePlat sharedInstance];
    self.sharePlat.delegate = self;
  
    [self.dataSource addDataArray:self.bodilyArray];
    [self.tableView reloadData];
    
    
    
    
    //日记
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, self.timeView.bottom+5, self.view.frame.size.width, DEVICEH-189-10-64) collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor clearColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.view addSubview:self.collection];
    
    [self.collection registerClass:[JournalCell class] forCellWithReuseIdentifier:@"MBImageCell"];
//    LKDBHelper *lkdbHelper = [DBHelper getUsingLKDBHelper];
//    HTAppContext *appContext = [HTAppContext sharedContext];
    
//    BodyData *startBD = [lkdbHelper searchSingle:[BodyData class] where:[NSString stringWithFormat:@"uid='%@'",appContext.uid] orderBy:@"measuretime"];
//    BodyData *endBD = [lkdbHelper searchSingle:[BodyData class] where:[NSString stringWithFormat:@"uid='%@'",appContext.uid] orderBy:@"measuretime DESC"];
    
    BodyData *startBD = _bodilyArray.lastObject;
    BodyData *endBD = _bodilyArray[0];
    //获取开始和结束时间
    long long startTime = [startBD.measuretime longLongValue];
    long long endTime = [endBD.measuretime longLongValue];
    long long difTime = endTime - startTime;
    int days = (int)(difTime/1000/60/60/24);
    
    startTimesp = [NSDate dateWithTimeIntervalSince1970:startTime/1000];
    endTimesp = [NSDate dateWithTimeIntervalSince1970:endTime/1000];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    float x = (endBD.FAT.floatValue*endBD.W.floatValue - startBD.FAT.floatValue*startBD.W.floatValue)/100;
    float y = (endBD.LBM.floatValue/endBD.W.floatValue - startBD.LBM.floatValue/startBD.W.floatValue)*100;
    
    NSMutableString *com = [[NSMutableString alloc] init];
    if (x >= 0)
    {
        [com appendFormat:@"共增脂%0.1f公斤，",x];
    }
    else
    {
        [com appendFormat:@"共减脂%0.1f公斤，",x*(-1)];
    }
    [com appendFormat:@"肌肉率变化%0.1f%@",y,@"%"];
    
    [self setTimeValue:days startTime:[formatter stringFromDate:startTimesp] endTime:[formatter stringFromDate:endTimesp]loose:[NSString stringWithFormat:@"%.1f",x] gain:[NSString stringWithFormat:@"%.1f",y]];
    
//    [self setDiffViewValue:@"-4.65" item2:@"-0.56" item3:@"-0.98" item4:@"-1.23"];
    NSArray *chas = [self getChaArray];
    [self setDiffViewValue:chas[0] item2:chas[1] item3:chas[2] item4:chas[3] item5:chas[4]];
    
    for (BodyData *obj in self.bodilyArray) {
        NSLog(@"obj.W = %@",obj.LBM);
    }
    
    
    
    if ([dataType isEqualToString:@"list"]) {
        self.valueListView.hidden = NO;
        self.trendView.hidden = YES;
        self.collection.hidden = YES;
    } else if ([dataType isEqualToString:@"circle"])
    {
        self.valueListView.hidden = YES;
        self.trendView.hidden = NO;
        self.collection.hidden = YES;
    } else
    {
        self.valueListView.hidden = self.trendView.hidden = self.diffView.hidden = YES;
        self.collection.hidden = NO;
    }
    
    self.handle = [[JournalModelHandler alloc] initWithController:self];
    self.listModel = [[JournalModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    [self.listModel getJournalWithStarttime:[formatter stringFromDate:startTimesp] endTime:[formatter stringFromDate:endTimesp] pageCount:@"9" starPage:currentPage];
}

- (NSArray *)getChaArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (self.bodilyArray.count > 1)
    {
        BodyData *frist = self.bodilyArray[0];
        BodyData *last = self.bodilyArray.lastObject;
        float WCha = [frist.W floatValue] - [last.W floatValue];
        float FATCha = [frist.FAT floatValue] - [last.FAT floatValue];
        float VATCha = [frist.VAT floatValue] - [last.VAT floatValue];
        float LBMCha = [frist.LBM floatValue] - [last.LBM floatValue];
        float AGECha = [frist.BODY_AGE floatValue] - [last.BODY_AGE floatValue];
        NSString *WCString = [NSString stringWithFormat:@"%.1f",WCha];
        NSString *FATCString = [NSString stringWithFormat:@"%.1f",FATCha];
        NSString *VATCString = [NSString stringWithFormat:@"%.1f",VATCha];
        NSString *LBMCString = [NSString stringWithFormat:@"%.1f",LBMCha];
        NSString *AGECString = [NSString stringWithFormat:@"%.1f",AGECha];
        [array addObject:WCString];
        [array addObject:FATCString];
        [array addObject:VATCString];
        [array addObject:LBMCString];
        [array addObject:AGECString];
    }
    else
    {
        [array setArray:@[@"0.0",@"0.0",@"0.0",@"0.0",@"0"]];
    }
    return array;
}

-(void)onBackUp:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onForwardClick:(id)sender
{
    [self.sharePlat showShareActionSheet];
}

-(void)onTrendClick:(id)sender
{
    
    maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    maskview.backgroundColor = [UIColor clearColor];
    [[self.navigationController topViewController].view addSubview:maskview];
    
    UIButton *maskBtn = [[UIButton alloc] initWithFrame:maskview.bounds];
    maskBtn.backgroundColor = [UIColor clearColor];
    [maskBtn addTarget:self action:@selector(hidePop) forControlEvents:UIControlEventTouchUpInside];
    [maskview addSubview:maskBtn];
    
    
    popView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICEW-115, 0, 100, 110)];
    [popView setImage:[UIImage imageNamed:@"popup"]];
    popView.userInteractionEnabled = YES;
    [[self.navigationController topViewController].view addSubview:popView];
    
    
    UIButton *listBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, popView.frame.size.width, 25)];
    [listBtn setTitle:@"列表" forState:UIControlStateNormal];
    listBtn.titleLabel.font = UIFontOfSize(11);
    listBtn.imageEdgeInsets = UIEdgeInsetsMake(listBtn.titleLabel.intrinsicContentSize.height-13, 0, 0, listBtn.titleLabel.intrinsicContentSize.width);
    [listBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [listBtn setImage:[UIImage imageNamed:@"listimg"] forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(listDidClick) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:listBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, listBtn.bottom, popView.frame.size.width-20, 0.2)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [popView addSubview:line1];
    
    
    
    UIButton *circleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, listBtn.bottom+10, popView.frame.size.width, 25)];
    [circleBtn setTitle:@"曲线" forState:UIControlStateNormal];
    circleBtn.titleLabel.font = UIFontOfSize(11);
    circleBtn.imageEdgeInsets = UIEdgeInsetsMake(circleBtn.titleLabel.intrinsicContentSize.height-13, 0, 0, circleBtn.titleLabel.intrinsicContentSize.width);
    [circleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [circleBtn setImage:[UIImage imageNamed:@"quxian"] forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(circleDidClick) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:circleBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, circleBtn.bottom, popView.frame.size.width-20, 0.2)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [popView addSubview:line2];
    
    
    
    UIButton *journayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, circleBtn.bottom+10, popView.frame.size.width, 25)];
    [journayBtn setTitle:@"日记" forState:UIControlStateNormal];
    journayBtn.titleLabel.font = UIFontOfSize(11);
    journayBtn.imageEdgeInsets = UIEdgeInsetsMake(journayBtn.titleLabel.intrinsicContentSize.height-13, 0, 0, journayBtn.titleLabel.intrinsicContentSize.width);
    [journayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [journayBtn setImage:[UIImage imageNamed:@"riji"] forState:UIControlStateNormal];
    [journayBtn addTarget:self action:@selector(journalDidClick) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:journayBtn];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(10, journayBtn.bottom, popView.frame.size.width-20, 0.2)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [popView addSubview:line3];
    
    isListShowed = YES;
    
    
    
//    if (self.valueListView.isHidden)
//    {
//        self.valueListView.hidden = NO;
//        self.trendView.hidden = YES;
//        for (int i = 0; i < 4; i ++)
//        {
//            UIButton *bt = [self.diffView viewWithTag:1000 + i];
//            bt.hidden = YES;
//        }
//    }
//    else
//    {
//        self.valueListView.hidden = YES;
//        self.trendView.hidden = NO;
//        for (int i = 0; i < 4; i ++)
//        {
//            UIButton *bt = [self.diffView viewWithTag:1000 + i];
//            bt.hidden = NO;
//        }
//    }
}

- (void)listDidClick
{
    self.valueListView.hidden = NO;
    self.trendView.hidden = YES;
    self.collection.hidden = YES;
    self.diffView.hidden = NO;

    for (int i = 0; i < 4; i ++)
    {
        UIButton *bt = [self.diffView viewWithTag:1000 + i];
        bt.hidden = YES;
    }
    [self hidePop];
}

- (void)circleDidClick
{
    self.valueListView.hidden = YES;
    self.trendView.hidden = NO;
    self.collection.hidden = YES;
    self.diffView.hidden = NO;

    for (int i = 0; i < 4; i ++)
    {
        UIButton *bt = [self.diffView viewWithTag:1000 + i];
        bt.hidden = NO;
    }
    [self hidePop];
}


- (void)journalDidClick
{
    self.valueListView.hidden = YES;
    self.trendView.hidden = YES;
    self.diffView.hidden = YES;
    self.collection.hidden = NO;
    for (int i = 0; i < 4; i ++)
    {
        UIButton *bt = [self.diffView viewWithTag:1000 + i];
        bt.hidden = NO;
    }
    [self hidePop];
}



- (void)hidePop
{
    maskview.hidden = YES;
    popView.hidden = YES;
    [maskview removeFromSuperview];
    [popView removeFromSuperview];
    isListShowed = NO;
}

//初始化时间数据
-(void)setTimeValue:(int)dayTime startTime:(NSString*)startTime endTime:(NSString*)endTime loose:(NSString *)loose gain:(NSString *)gain
{
//    //头像
//    UIImageView *photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
//    photoIV.layer.cornerRadius = 30.0f;
//    photoIV.layer.masksToBounds = YES;
//    HTUserData *userData = [HTUserData sharedInstance];
//    NSString *avatar = _avatar.length ? _avatar : userData.avatar;
//    [photoIV sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"body_photo_bg.png"]];
//    [self.timeView addSubview:photoIV];
    //测量历时
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
    dayLabel.textColor = UIColorFromRGB(20, 149, 218);
    NSString *days = [NSString stringWithFormat:@"测量历时 %d 天", dayTime];
    NSMutableAttributedString *daysText = [[NSMutableAttributedString alloc] initWithString:days];
    [daysText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    [daysText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(0, 4)];
    [daysText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(days.length-1,1)];
    [daysText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(days.length-1, 1)];
    
    dayLabel.attributedText = daysText;
    dayLabel.font = [UIFont systemFontOfSize:15.0f];
    [dayLabel sizeToFit];
    [self.timeView addSubview:dayLabel];
    
    //开始时间
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(dayLabel.left, dayLabel.bottom+20, 44, 18)];
    startLabel.text = @"开始时间";
    startLabel.font = UIFontOfSize(9);
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.textColor = BLUECOLOR;
    startLabel.backgroundColor = UIColorFromRGB(235, 248, 253);
    startLabel.layer.cornerRadius = 1;
    startLabel.clipsToBounds = YES;
    [self.timeView addSubview:startLabel];
    
    UILabel *startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(startLabel.right+6, startLabel.top, DEVICEW/2, 18)];
    startTimeLabel.text = startTime;
    startTimeLabel.font = UIFontOfSize(9);
    startTimeLabel.textColor = [UIColor lightGrayColor];
    [self.timeView addSubview:startTimeLabel];
    
    
    //结束时间
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEVICEW/2+6, startLabel.top, 44, 18)];
    endLabel.text = @"结束时间";
    endLabel.font = UIFontOfSize(10);
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.textColor = APP_RED;
    endLabel.backgroundColor = UIColorFromRGB(251, 219, 222);
    endLabel.layer.cornerRadius = 1;
    endLabel.clipsToBounds = YES;
    [self.timeView addSubview:endLabel];
    
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(endLabel.right+6, endLabel.top, DEVICEW/2, 18)];
    endTimeLabel.text = endTime;
    endTimeLabel.font = UIFontOfSize(9);
    endTimeLabel.textColor = [UIColor lightGrayColor];
    [self.timeView addSubview:endTimeLabel];
    

    
    UILabel *comLabel = [[UILabel alloc]initWithFrame:CGRectMake(dayLabel.left, startTimeLabel.bottom+10, 120, 30)];
    comLabel.text = @"测评结果";
    comLabel.font = UIFontOfSize(14);
    [comLabel sizeToFit];
    [self.timeView addSubview:comLabel];
    
    UILabel *zhifangLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, comLabel.bottom+10, DEVICEW/2, 30)];
    zhifangLabel.text = @"脂肪变化率";
    zhifangLabel.font = UIFontOfSize(12);
    zhifangLabel.textColor = [UIColor lightGrayColor];
    [zhifangLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeView addSubview:zhifangLabel];
    
    UILabel *zhifangNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, zhifangLabel.bottom+10, DEVICEW/2, 30)];
    zhifangNumLabel.text = loose;
    zhifangNumLabel.font = UIFontOfSize(20);
    zhifangNumLabel.font = [UIFont boldSystemFontOfSize:22];
    zhifangNumLabel.textColor = APP_RED;
    [zhifangNumLabel sizeToFit];
    zhifangNumLabel.center = CGPointMake(zhifangLabel.center.x, zhifangLabel.center.y+40);
    [zhifangNumLabel setTextAlignment:NSTextAlignmentCenter];
    [self.timeView addSubview:zhifangNumLabel];
    
    UILabel *zhifangUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zhifangNumLabel.right+3, zhifangNumLabel.top+8, 25, 18)];
    zhifangUnitLabel.text = @"公斤";
    zhifangUnitLabel.font = UIFontOfSize(10);
    zhifangUnitLabel.textColor = [UIColor lightGrayColor];
    [zhifangUnitLabel setTextAlignment:NSTextAlignmentLeft];
    [self.timeView addSubview:zhifangUnitLabel];

    
    
    
    UILabel *jirouLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEVICEW/2, zhifangLabel.top, DEVICEW/2, 30)];
    jirouLabel.text = @"肌肉变化率";
    jirouLabel.font = UIFontOfSize(12);
    jirouLabel.textColor = [UIColor lightGrayColor];
    [jirouLabel setTextAlignment:NSTextAlignmentCenter];
    jirouLabel.textAlignment = NSTextAlignmentCenter;
    [self.timeView addSubview:jirouLabel];
    
    UILabel *jirouNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEVICEW/2, jirouLabel.bottom+10, DEVICEW/2, 30)];
    jirouNumLabel.text = gain;
    jirouNumLabel.font = [UIFont boldSystemFontOfSize:22];
    jirouNumLabel.textColor = APP_GREEN;
    [jirouNumLabel sizeToFit];
    jirouNumLabel.center = CGPointMake(jirouLabel.center.x, jirouLabel.center.y+40);
    [jirouNumLabel setTextAlignment:NSTextAlignmentCenter];
    jirouNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.timeView addSubview:jirouNumLabel];
    
    UILabel *jirouUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(jirouNumLabel.right+3, jirouNumLabel.top+8, 25, 18)];
    jirouUnitLabel.text = @"%";
    jirouUnitLabel.font = UIFontOfSize(10);
    jirouUnitLabel.textColor = [UIColor lightGrayColor];
    [jirouUnitLabel setTextAlignment:NSTextAlignmentLeft];
    [self.timeView addSubview:jirouUnitLabel];

    
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, dayLabel.bottom+10, DEVICEW-40, 0.5f)];
    lineView1.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.timeView addSubview:lineView1];

    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, startTimeLabel.bottom+5, DEVICEW-40, 0.5f)];
    lineView2.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.timeView addSubview:lineView2];

    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(20, self.timeView.bottom-1, DEVICEW-40, 0.5f)];
    lineView3.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.timeView addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(DEVICEW/2, lineView1.bottom, 0.5, lineView2.top-lineView1.bottom)];
    lineView4.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.timeView addSubview:lineView4];

}

//初始化差值数据
-(void)setDiffViewValue:(NSString*)item1 item2:(NSString*)item2 item3:(NSString*)item3 item4:(NSString*)item4 item5:(NSString*)item5
{
    NSArray *itemValues = @[@"体重",@"体脂率",@"内脂",@"肌肉量"];
    NSArray *itemImgs = @[@"body_icon_t1",@"body_icon_t33",@"body_icon_t4",@"body_icon_t2"];
    CGFloat space = 10; CGFloat wid = (SCREEN_WIDTH - 5*space)/4;
    for (int i = 0; i < itemValues.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(space + (wid + space)*i, 10, wid, 60);
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = UIColorFromRGB(20, 149, 218).CGColor;
        btn.layer.borderWidth = i==0 ? 1:0;
        btn.layer.masksToBounds = YES;
        btn.tag = 1000+i;
        btn.hidden = YES;
        [btn addTarget:self action:@selector(selectAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.diffView addSubview:btn];
    }
    
    UILabel *itemLab11 = [self createTrendLable:itemValues[0] withIcon:itemImgs[0]];
    [self.diffView addSubview:itemLab11];
    
    UILabel *itemLab12 = [self createTrendLable:itemValues[1] withIcon:itemImgs[1]];
    [self.diffView addSubview:itemLab12];
    
    UILabel *itemLab13 = [self createTrendLable:itemValues[2] withIcon:itemImgs[2]];
    [self.diffView addSubview:itemLab13];
    
    UILabel *itemLab14 = [self createTrendLable:itemValues[3] withIcon:itemImgs[3]];
    [self.diffView addSubview:itemLab14];
    
    CGFloat minY = self.diffView.height - 40;
    
    UILabel *itemLab1 = [self createDiffLable:[NSString stringWithFormat:@"%@公斤",item1] withIcon:@"body_icon1"];
    itemLab1.frame = CGRectMake(10, minY, SCREEN_WIDTH/4.0-5.0f, 40);
    [self.diffView addSubview:itemLab1];
    itemLab11.frame = CGRectMake(15, 10, SCREEN_WIDTH/4.0-5.0f, 23);
    
    UILabel *itemLab2 = [self createDiffLable:[NSString stringWithFormat:@"%@%%",item2] withIcon:@"body_icon2"];
    itemLab2.frame = CGRectMake(itemLab1.right, minY, SCREEN_WIDTH/4.0-5.0f, 40);
    [self.diffView addSubview:itemLab2];
    itemLab12.frame = CGRectMake(itemLab1.right + 5, 10, SCREEN_WIDTH/4.0-5.0f, 23);
    
    UILabel *itemLab3 = [self createDiffLable:[NSString stringWithFormat:@"%@级",item3] withIcon:@"body_icon3"];
    itemLab3.frame = CGRectMake(itemLab2.right, minY, SCREEN_WIDTH/4.0-5.0f, 40);
    [self.diffView addSubview:itemLab3];
    itemLab13.frame = CGRectMake(itemLab2.right + 5, 10, SCREEN_WIDTH/4.0-5.0f, 23);
    
    
    UILabel *itemLab4 = [self createDiffLable:[NSString stringWithFormat:@"%@公斤",item4] withIcon:@"body_icon4"];
    itemLab4.frame = CGRectMake(itemLab3.right, minY, SCREEN_WIDTH/4.0-5.0f, 40);
    [self.diffView addSubview:itemLab4];
    itemLab14.frame = CGRectMake(itemLab3.right + 5, 10, SCREEN_WIDTH/4.0-5.0f, 23);
    
    
//    UILabel *valueLab = [[UILabel alloc]initWithFrame:CGRectMake(itemLab4.right, 10, self.view.width/5.0f, 40)];
//    valueLab.font = [UIFont systemFontOfSize:12.0f];
//    valueLab.text = item5;
//    valueLab.textColor = UIColorFromRGB(20, 149, 218);
//    valueLab.textAlignment = NSTextAlignmentCenter;
//    [self.diffView addSubview:valueLab];
}

//创建差值比例视图
-(UILabel*)createDiffLable:(NSString*)diffValue withIcon:(NSString*)imgName
{
    UILabel *valueLab = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0, self.view.width/5.0f-5.0f, 40)];
    valueLab.font = [UIFont systemFontOfSize:12.0f];
    valueLab.text = diffValue;
    valueLab.textColor = UIColorFromRGB(20, 149, 218);
    valueLab.textAlignment = NSTextAlignmentCenter;
//    UIImageView *iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(valueLab.width-17, 0, 17, 17)];
//    [iconIV setImage:[UIImage imageNamed:imgName]];
//    [valueLab addSubview:iconIV];
    return valueLab;
}

//列表展示标题

-(void)createListView
{
    NSArray *itemValues = @[@"体重",@"体脂率",@"内脂",@"肌肉量",@"身体年龄"];
    for (int i=0; i<5; i++) {
        UILabel *itemLab = [[UILabel alloc]init];
        itemLab.frame = CGRectMake(60*i, 0, SCREEN_WIDTH/5.0, 30);
        itemLab.text = itemValues[i];
        itemLab.font = [UIFont systemFontOfSize:14.0f];
        itemLab.textColor = [UIColor blackColor];
        itemLab.textAlignment = NSTextAlignmentCenter;
        itemLab.backgroundColor = [UIColor clearColor];
        [self.valueListView addSubview:itemLab];
    }
}

//曲线图色块解释View
-(void)createTrendView
{
    UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 240, 0, 280, 23)];
    NSArray *itemValues = @[@"体重",@"体脂率",@"内脂",@"肌肉量"];
    NSArray *itemImgs = @[@"body_icon_t1",@"body_icon_t2",@"body_icon_t33",@"body_icon_t4"];
    
    for (int i=0; i<4; i++)
    {
        UILabel *itemLab = [self createTrendLable:itemValues[i] withIcon:itemImgs[i]];
        itemLab.frame = CGRectMake(10+60*i, 0, 40, 23);
        itemLab.backgroundColor = [UIColor clearColor];
        itemLab.tag = i;
        [itemLab addTapCallBack:self sel:@selector(selectAct:)];
        [itemView addSubview:itemLab];
    }
    
    [self.trendView addSubview:itemView];
}

- (void)selectAct:(UIButton *)btn
{
    [self.lineChartView clearPlot];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *bt = [self.diffView viewWithTag:1000 + i];
        if (bt == btn) {
            bt.layer.borderWidth = 1;
        }
        else
        {
            bt.layer.borderWidth = 0;
        }
    }
    NSInteger index = btn.tag - 1000;
    if (index < 4)
    {
        [self setLineChartValue:index];
    }
}

//曲线图色块解释lable
-(UILabel*)createTrendLable:(NSString*)diffValue withIcon:(NSString*)imgName
{
//    UILabel *valueLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 23)];
//    valueLab.font = [UIFont systemFontOfSize:10.0f];
//    valueLab.text = diffValue;
//    valueLab.textColor = [UIColor blackColor];
//    valueLab.textAlignment = NSTextAlignmentRight;
//    UIImageView *iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 7, 7)];
//    iconIV.backgroundColor = [UIColor orangeColor];
//    [iconIV setImage:[UIImage imageNamed:imgName]];
//    [valueLab addSubview:iconIV];
//    return valueLab;
    
    UILabel *valueLab = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0, self.view.width/5.0f-5.0f, 23)];
    valueLab.font = [UIFont systemFontOfSize:10.0f];
    valueLab.text = diffValue;
    valueLab.textColor = [UIColor blackColor];
    valueLab.textAlignment = NSTextAlignmentCenter;
    UIImageView *iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(valueLab.width/5, 8, 7, 7)];
    [iconIV setImage:[UIImage imageNamed:imgName]];
    [valueLab addSubview:iconIV];
    return valueLab;
}

//文字样式

-(NSMutableAttributedString*)textAttribut:(NSString*)textValue
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:textValue];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(20, 149, 218) range:NSMakeRange(0,3)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(0, 3)];
    return str;
}

-(NSMutableAttributedString*)spectilTextAttribut:(NSString*)textValue
{
//    测评：共增脂XXX公斤，肌肉率变化XX%
    NSRange range1 = [textValue rangeOfString:@"公斤，肌肉率变化"];
    NSInteger length = range1.location - 6;
    NSInteger length1 = textValue.length - range1.location-range1.length-1;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:textValue];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(20, 149, 218) range:NSMakeRange(0,3)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(0, 3)];
    
    [str addAttribute:NSForegroundColorAttributeName value:APP_RED range:NSMakeRange(6,length)];
    [str addAttribute:NSForegroundColorAttributeName value:APP_RED range:NSMakeRange(range1.location + range1.length,length1)];
    return str;
}
//曲线图赋值

-(void)setLineChartValue:(NSInteger )index
{
    NSArray *xValue = @[@"",@"",@"",@"",@""];
    NSMutableArray* plottingDataValues = [[NSMutableArray alloc]initWithCapacity:10];
    
    [self.bodilyArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            BodyData *bodyData = /*[self.bodilyArray objectAtIndex:i]*/obj;
            if (index == 0)
            {
                [plottingDataValues addObject:bodyData.W];
            }
            else if (index == 1)
            {
                [plottingDataValues addObject:bodyData.FAT==nil?@"":bodyData.FAT];
            }
            else if (index == 2)
            {
                [plottingDataValues addObject:bodyData.VAT==nil?@"":bodyData.VAT];
            }
            else if (index == 3)
            {
                [plottingDataValues addObject:bodyData.LBM==nil?@"":bodyData.LBM];
            }
    }];
    self.lineChartView.min = 0.0f;
    if (index == 0)
    {
        self.lineChartView.max = 180.0f;
    }
    else if (index == 1)
    {
        self.lineChartView.max = 61.0f;
        self.lineChartView.min = 6.0f;
    }
    else if (index == 2)
    {
        self.lineChartView.max = 10.0f;
    }
    else if (index == 3)
    {
        self.lineChartView.max = 150.0f;
    }
    
    //纵坐标间隔
    self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/5;
    
    NSMutableArray* yAxisValues = [@[] mutableCopy];
    for (int i=0; i<6; i++) {
        NSString* str = [NSString stringWithFormat:@"%.1f", self.lineChartView.min+self.lineChartView.interval*i];
        [yAxisValues addObject:str];
    }
    
    self.lineChartView.xAxisValues = xValue;
    self.lineChartView.yAxisValues = yAxisValues;
    self.lineChartView.axisLeftLineWidth = 44;  //纵坐标左边宽度
    self.lineChartView.horizontalLineInterval=(268-46)/5.0;  //纵坐标第1个的高度
    
    self.lineChartView.pointerInterval=(SCREEN_WIDTH-100)/plottingDataValues.count;//两点之间距离
    
    if (index == 0)
    {
        PNPlot *plot1 = [[PNPlot alloc] init];
        plot1.plottingValues = plottingDataValues;
        plot1.lineColor = UIColorFromRGB(73, 197, 241);
        plot1.lineWidth = 1.5;
        [self.lineChartView addPlot:plot1];
    }
    else if (index == 1)
    {
        PNPlot *plot2 = [[PNPlot alloc] init];
        plot2.plottingValues = plottingDataValues;
        plot2.lineColor = UIColorFromRGB(234, 104, 162);
        plot2.lineWidth = 1.5;
        [self.lineChartView addPlot:plot2];
    }
    else if (index == 2)
    {
        PNPlot *plot3 = [[PNPlot alloc] init];
        plot3.plottingValues = plottingDataValues;
        plot3.lineColor = UIColorFromRGB(226, 40, 54);
        plot3.lineWidth = 1.5;
        [self.lineChartView addPlot:plot3];
    }
    else if (index == 3)
    {
        PNPlot *plot4 = [[PNPlot alloc] init];
        plot4.plottingValues = plottingDataValues;
        plot4.lineColor = UIColorFromRGB(248, 108, 40);
        plot4.lineWidth = 1.5;
        [self.lineChartView addPlot:plot4];
    }
}

#pragma mark - SharePlatDelegate
- (void)gotoTrend
{
    
}

- (void)sendSMS:(UIImage *)image
{
  NSData *imageData = UIImagePNGRepresentation(image);
  MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
  picker.messageComposeDelegate = self;
  BOOL didAttachImage = [picker addAttachmentData:imageData typeIdentifier:@"image/png" filename:@"image.png"];
  if (didAttachImage) {
    [self presentViewController:picker animated:YES completion:nil];
  } else {
    UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"您的手机不支持发送图片功能"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
    [warningAlert show];
  }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
  if (MessageComposeResultCancelled == result) {
    [controller dismissViewControllerAnimated:YES completion:nil];
  }
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{
    if (self.collection.contentOffset.y>90) {
        [self.listModel getJournalWithStarttime:startTimesp endTime:endTimesp pageCount:@"9" starPage:currentPage+1];
        currentPage +=1;
    }
}


#pragma mark - collectionview delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *rid = @"MBImageCell";
    JournalCell *cell = (JournalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];
    if (!cell) {
        cell = [[JournalCell alloc] init];
    }
    [cell loadContent:_dataArray[indexPath.row] path:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DEVICEW-6)/3, (DEVICEW-6)/3);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (void)syncFinished:(JournalResponse *)response
{
    [_dataArray addObjectsFromArray:response.data];
    [self.collection reloadData];
}

- (void)syncFailure
{
    
}

@end
