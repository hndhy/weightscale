//
//  HomeViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HomeViewController.h"
#import "JTCalendarViewController.h"
#import <RESideMenu.h>
#import "SharePlat.h"
#import "TrendListViewController.h"
#import "MeasureInfoModel.h"
#import "HTTimeItem.h"
#import "NSDate+Utilities.h"
#import "BodilyDataViewController.h"
#import "CommonHelper.h"
#import "DBHelper.h"
#import "State.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>
#import "AppDelegate.h"

#import "BMIViewController.h"
#import "LBMViewController.h"
#import "BodyAgeViewController.h"
#import "KcalViewController.h"
#import "VatViewController.h"
#import "FatViewController.h"
#import "TargetViewController.h"
#import "WeightViewController.h"
#import "WaterViewController.h"
#import "BoneMassViewController.h"

#import "SyncDataListResponse.h"
#import "SyncDataModelHander.h"
#import "HTSyncDataModel.h"

#import "UploadInfo.h"
#import "JSONKit.h"

#import "HLoadingView.h"

#import "HTMultiLabel.h"


@interface HomeViewController ()<SharePlatDelegate, SyncModelProtocol, MFMessageComposeViewControllerDelegate,JTCalendarDelegate,RESideMenuDelegate>

@property (nonatomic, strong) UILabel *weightNumLabel;
@property (nonatomic, strong) UILabel *weightStatLabel;
@property (nonatomic, strong) UILabel *fatNumLabel;
@property (nonatomic, strong) UILabel *fatStatLabel;
@property (nonatomic, strong) UILabel *nFatNumLabel;
@property (nonatomic, strong) UILabel *nFatStatLabel;
@property (nonatomic, strong) UILabel *wetNumLabel;
@property (nonatomic, strong) UILabel *wetStatLabel;
@property (nonatomic, strong) UILabel *muscleNumLabel;
@property (nonatomic, strong) UILabel *muscleStatLabel;
@property (nonatomic, strong) UILabel *metaNumLabel;
@property (nonatomic, strong) UILabel *metaStatLabel;
@property (nonatomic, strong) UILabel *mbiNumLabel;
@property (nonatomic, strong) UILabel *mbiStatLabel;
@property (nonatomic, strong) UILabel *ageNumLabel;
@property (nonatomic, strong) UILabel *ageStatLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *boneMassNumLabel;
@property (nonatomic, strong) UILabel *boneMassStatLabel;

@property (nonatomic, strong) SharePlat *sharePlat;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) UILabel *testLabel;

@property (nonatomic, strong)SyncDataModelHander *syncHandler;
@property (nonatomic, strong)HTSyncDataModel *syncModel;

@property (nonatomic, strong) UIImageView *testImageView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) int timeIndex;
@property (nonatomic, strong) NSMutableArray *infoMArray;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeViewController

-(void)initModel
{
  self.syncHandler = [[SyncDataModelHander alloc]initWithController:self];
  self.syncModel = [[HTSyncDataModel alloc]initWithHandler:self.syncHandler];
  self.infoMArray = [NSMutableArray arrayWithCapacity:8];
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
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nav_bar.png"]];
    iconImageView.centerY = titleView.centerY;
//    iconImageView.hidden = YES;
  [titleView addSubview:iconImageView];
  self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(iconImageView.right, 0, titleView.width - iconImageView.right, 44.0f)
                                        withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  [titleView addSubview:self.titleLabel];
  UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88.0f, 44.0f)];
  rightView.backgroundColor = [UIColor clearColor];
  UIButton *calendaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
  [calendaButton setImage:[UIImage imageNamed:@"carlender_nav_bar.png"] forState:UIControlStateNormal];
  [calendaButton addTarget:self action:@selector(oncalendaClick:) forControlEvents:UIControlEventTouchUpInside];
  [rightView addSubview:calendaButton];
  UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(rightView.width-54.0f, 0, 44.0f, 44.0f)];
  [forwardButton setImage:[UIImage imageNamed:@"home_forward_icon.png"] forState:UIControlStateNormal];
  [forwardButton addTarget:self action:@selector(onForwardClick:) forControlEvents:UIControlEventTouchUpInside];
  [rightView addSubview:forwardButton];
  UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
  self.navigationItem.rightBarButtonItem = rightItem;
}

- (BOOL)needRefreshView
{
  return YES;
}

- (void)refreshView
{
  HTUserData *userData = [HTUserData sharedInstance];
  self.titleLabel.text = userData.nick;
}

- (void)initView
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45.0f)];
    titleImageView.image = [UIImage imageNamed:@"home_title.png"];
  //  [self.view addSubview:titleImageView];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-0.5f, 0, self.view.width + 1.0f, 44.0f)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.borderColor = UIColorFromRGB(210.0f, 210.0f, 210.0f).CGColor;
    titleView.layer.borderWidth = 0.5f;
    [self.view addSubview:titleView];
    
    self.itemArray = [NSMutableArray arrayWithCapacity:5];
    self.dateArray = [NSMutableArray arrayWithCapacity:5];
//    CGFloat timeWidth = self.view.width / 5.0f;
//    for (int i = 0; i < 5; i++)
//    {
//        HTTimeItem *item = [[HTTimeItem alloc] initWithFrame:CGRectMake(i * timeWidth, titleView.top, timeWidth, 50.0f)];
//        item.tag = i;
//        if (2 == i)
//        {
//            [item setHight];
//        }
//        [item addTapCallBack:self sel:@selector(onTimeItemClick:)];
//        [self.view addSubview:item];
//        [self.itemArray addObject:item];
//    }
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleView.top, 150, 50)];
    [self.dateLabel setFont:[UIFont systemFontOfSize:13]];
    [self.dateLabel setTextColor:[UIColor blackColor]];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.dateLabel];
    
//    UIView *timeLine = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.top + 46.0f, 48.0f, 4.0f)];
//    timeLine.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
//    timeLine.centerX = titleView.centerX;
//    [self.view addSubview:timeLine];
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.top + 51.0f, self.view.width, 0.5f)];
//    lineView.backgroundColor = UIColorFromRGB(210.0f, 210.0f, 210.0f);
//    [self.view addSubview:lineView];
    
    
    self.timeLabel = [UILabel createLabelWithFrame:CGRectMake(200, titleView.top, 100, 50)
                                        withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
//    self.timeLabel.centerX = lineView.centerX;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel.left - 33.0f, self.timeLabel.top, 33.0f, 33.0f)];
    [self.leftButton setImage:[UIImage imageNamed:@"arrow_left_icon.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(onLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.hidden = YES;
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel.right, self.timeLabel.top, 33.0f, 33.0f)];
    [self.rightButton setImage:[UIImage imageNamed:@"arrow_right_icon.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(onRightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.hidden = YES;
    [self.view addSubview:self.rightButton];
    
//    self.testLabel = [UILabel createLabelWithFrame:CGRectMake(0, lineView.bottom, self.view.width, 33.0f)
//                                        withSize:12.0f withColor:[UIColor blackColor]];
//    self.testLabel.numberOfLines = 4;
  //  [self.view addSubview:self.testLabel];
    
//    UIImageView *shake = [[UIImageView alloc] initWithFrame:CGRectMake(10,  titleView.top + 55.0f, 68, 26)];
//    shake.image = [UIImage imageNamed:@"shake2.0"];
//    [self.view addSubview:shake];
    
//    UIImageView *refresh = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 40,  titleView.top + 55.0f, 25, 25)];
//    refresh.image = [UIImage imageNamed:@"refresh_nav_bar_w"];
//    refresh.userInteractionEnabled = YES;
//    [refresh addTapCallBack:self sel:@selector(refreshHome)];
//    [self.view addSubview:refresh];
    
    // 指标第一个View
    CGFloat contentHeight = SCREEN_HEIGHT_EXCEPTNAV - titleView.bottom -49;
    CGFloat margin = contentHeight * 0.025f;
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(9.0f, titleView.bottom + margin, self.view.width - 18.0f, contentHeight * 0.30f)];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.layer.cornerRadius = 4.0f;
    firstView.layer.masksToBounds = YES;
    [self.view addSubview:firstView];
    
    
    // 指示第二个view
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(firstView.left, firstView.bottom + margin, firstView.width, firstView.height)];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.layer.cornerRadius = 4.0f;
    secondView.layer.masksToBounds = YES;
    [self.view addSubview:secondView];
    
    
    // 指标第三个view
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(secondView.left, secondView.bottom + margin, secondView.width, secondView.height)];//contentHeight * 0.22f
    thirdView.backgroundColor = [UIColor whiteColor];
    thirdView.layer.cornerRadius = 4.0f;
    thirdView.layer.masksToBounds = YES;
        [self.view addSubview:thirdView];
    
    
    
    HTMultiLabel *weightLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [weightLabel setInfoForNumber:0 titleLabel:@"体重" tagLabel:@"公斤" stateLabel:@"不判断"];
    [weightLabel addTapCallBack:self sel:@selector(onWeightClick:)];
    [firstView addSubview:weightLabel];
    
    HTMultiLabel *fatLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [fatLabel setInfoForNumber:0 titleLabel:@"体脂率" tagLabel:@"％" stateLabel:@"正常"];
    [fatLabel addTapCallBack:self sel:@selector(onFatClick:)];
    [firstView addSubview:fatLabel];
    
    HTMultiLabel *nFatLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [nFatLabel setInfoForNumber:0 titleLabel:@"内脂" tagLabel:@"级" stateLabel:@"警戒"];
    [nFatLabel addTapCallBack:self sel:@selector(onVatClick:)];
    [firstView addSubview:nFatLabel];
    
    
    HTMultiLabel *boneLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [boneLabel setInfoForNumber:0 titleLabel:@"骨骼肌率" tagLabel:@"％" stateLabel:@"警报"];
    [boneLabel addTapCallBack:self sel:@selector(onBoneMssClick:)];
    [secondView addSubview:boneLabel];
    
    HTMultiLabel *muscleLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [muscleLabel setInfoForNumber:0 titleLabel:@"肌肉量" tagLabel:@"公斤" stateLabel:@"正常"];
    [muscleLabel addTapCallBack:self sel:@selector(onLBMClick:)];
    [secondView addSubview:muscleLabel];
    
    HTMultiLabel *metaLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [metaLabel setInfoForNumber:0 titleLabel:@"基础代谢" tagLabel:@"kcal" stateLabel:@"正常"];
    [metaLabel addTapCallBack:self sel:@selector(onKcalClick:)];
    [secondView addSubview:metaLabel];
    
    
    HTMultiLabel *mbiLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [mbiLabel setInfoForNumber:0 titleLabel:@"BMI" tagLabel:@"" stateLabel:@"正常"];
    [mbiLabel addTapCallBack:self sel:@selector(onMBIClick:)];
    [thirdView addSubview:mbiLabel];
    
    HTMultiLabel *wetLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [wetLabel setInfoForNumber:0 titleLabel:@"体水分" tagLabel:@"％" stateLabel:@"警报"];
    [wetLabel addTapCallBack:self sel:@selector(onWaterClick:)];
    [thirdView addSubview:wetLabel];
    
    HTMultiLabel *ageLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [ageLabel setInfoForNumber:0 titleLabel:@"身体年龄" tagLabel:@"％" stateLabel:@"危险"];
    [ageLabel addTapCallBack:self sel:@selector(onBodyAgeClick:)];
    [thirdView addSubview:ageLabel];
    
    

    /*
    // 首页感叹号View
    UIImageView *targetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(thirdView.right - 30.0f,
                                                                               thirdView.top + 10.0f, 36.0f, 36.0f)];
    targetImageView.image = [UIImage imageNamed:@"target_icon.png"];
    [targetImageView addTapCallBack:self sel:@selector(onTargetClick:)];
    [self.view addSubview:targetImageView];
    */
    self.sharePlat = [SharePlat sharedInstance];
    self.sharePlat.delegate = self;
    
 
    if (self.infoModel)
    {
        BodyData *bodyData = [[BodyData alloc]init];
        bodyData.W = [NSString stringWithFormat:@"%.1f", self.infoModel.weight];
        bodyData.uid = [NSString stringWithFormat:@"%@",@""];
        bodyData.BMI = [NSString stringWithFormat:@"%.1f", self.infoModel.bmi];
        bodyData.FAT = [NSString stringWithFormat:@"%.1f", self.infoModel.fat];
        bodyData.BMC = [NSString stringWithFormat:@"%.1f", self.infoModel.bmc];
        bodyData.LBM = [NSString stringWithFormat:@"%.1f", self.infoModel.lbm];
        bodyData.TBW = [NSString stringWithFormat:@"%.1f", self.infoModel.tbw];
        bodyData.VAT = [NSString stringWithFormat:@"%.1f", self.infoModel.vat];
        bodyData.Kcal = [NSString stringWithFormat:@"%d", self.infoModel.kcal];
        bodyData.BODY_AGE = [NSString stringWithFormat:@"%d", self.infoModel.bodyAge];
        bodyData.smr = [NSString stringWithFormat:@"%.1f",self.infoModel.smr];
        bodyData.issync = @"0";
        HTUserData *userInfo = [HTUserData sharedInstance];
        bodyData.uid = userInfo.uid;
        bodyData.measuretime = [NSString stringWithFormat:@"%.0lf", [[NSDate date] timeIntervalSince1970] * 1000];
        [DBHelper saveBodyData:bodyData];
        APP_DELEGATE.updated = NO;
        self.infoModel = nil;
    }
    if (!APP_DELEGATE.updated)
    {
        HLoadingView *loading = [HLoadingView defaultView];
        [loading setTitle:@"数据同步"];
        [HLoadingView show];
        [self refreshData:NO];
    }
    else
    {
        [self setDateInfo:[NSDate date]];
    }
    self.sideMenuViewController.delegate = self;
}

- (void)refreshData:(BOOL)isLoading
{
    if (isLoading)
    {
        [self showHUDWithLabel:@"正在刷新数据..."];
    }
    HTUserData *userData = [HTUserData sharedInstance];
    [DBHelper getBodyData:[NSString stringWithFormat:@"issync=0 and uid='%@'",userData.uid] orderBy:nil offset:0 count:100 black:^(NSMutableArray *result) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:8];
            for (BodyData *bodyData in result) {
                
                NSMutableString *mStr = [NSMutableString stringWithCapacity:100];
                [mStr appendFormat:@"{\"w\":%@,", bodyData.W];
                [mStr appendFormat:@"\"bmi\":%@,", bodyData.BMI];
                [mStr appendFormat:@"\"fat\":%@,", bodyData.FAT];
                [mStr appendFormat:@"\"tbw\":%@,", bodyData.TBW];
                [mStr appendFormat:@"\"lbm\":%@,", bodyData.LBM];
                [mStr appendFormat:@"\"bmc\":%@,", bodyData.BMC];
                [mStr appendFormat:@"\"vat\":%@,", bodyData.VAT];
                [mStr appendFormat:@"\"kcal\":%@,", bodyData.Kcal];
                [mStr appendFormat:@"\"bodyAge\":%@,", bodyData.BODY_AGE];
                [mStr appendFormat:@"\"smr\":%@,", bodyData.smr];
                [mStr appendFormat:@"\"measureTime\":%@}", bodyData.measuretime];
                [mArray addObject:mStr];
            }
            NSString *jsonStr = nil;
            if (mArray.count > 0) {
                jsonStr = [NSString stringWithFormat:@"[%@]", [mArray componentsJoinedByString:@","]];
            } else {
                jsonStr = @"[]";
            }
            NSLog(@"mArray====>%@", jsonStr);
            [self.syncModel syncData:@"0" withData:jsonStr];
        });
    }];
}

- (void)onTimeItemClick:(UITapGestureRecognizer *)sender
{
  int tag = (int)sender.view.tag;
  NSDate *date = [self.dateArray objectAtIndex:tag];
  [self setDateInfo:date];
}

- (void)setDateInfoItem:(NSDate *)date
{
  [self.dateArray removeAllObjects];
    
//  NSDate *tmpDate = [date dateBySubtractingDays:2];
//  [self.dateArray addObject:tmpDate];
//  HTTimeItem *tmpTmp = [self.itemArray objectAtIndex:0];
//  [tmpTmp setMonth:(int)tmpDate.month day:(int)tmpDate.day];
//  //
//  tmpDate = [date dateBySubtractingDays:1];
//  [self.dateArray addObject:tmpDate];
//  tmpTmp = [self.itemArray objectAtIndex:1];
//  [tmpTmp setMonth:(int)tmpDate.month day:(int)tmpDate.day];
//  //
//  tmpDate = [date copy];
//  [self.dateArray addObject:tmpDate];
//  tmpTmp = [self.itemArray objectAtIndex:2];
//  [tmpTmp setMonth:(int)tmpDate.month day:(int)tmpDate.day];
    
    [self.dateLabel setText:[date stringWithFormat:@"yyyy年MM月dd日"]];
  //
//  tmpDate = [date dateByAddingDays:1];
//  [self.dateArray addObject:tmpDate];
//  tmpTmp = [self.itemArray objectAtIndex:3];
//  [tmpTmp setMonth:(int)tmpDate.month day:(int)tmpDate.day];
//  //
//  tmpDate = [date dateByAddingDays:2];
//  [self.dateArray addObject:tmpDate];
//  tmpTmp = [self.itemArray objectAtIndex:4];
//  [tmpTmp setMonth:(int)tmpDate.month day:(int)tmpDate.day];
}

- (void)setDateInfo:(NSDate *)date
{
  [self setDateInfoItem:date];
  //////////////////////////
  [DBHelper getDatasbyOneDay:date black:^(NSMutableArray *result) {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self.infoMArray removeAllObjects];
      NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:8];
      for (BodyData *bodyData in result) {
        MeasureInfoModel *mInfoModel = [[MeasureInfoModel alloc] init];
        mInfoModel.weight = [bodyData.W floatValue];
        mInfoModel.bmc = [bodyData.BMC floatValue];
        mInfoModel.bmi = [bodyData.BMI floatValue];
        mInfoModel.fat = [bodyData.FAT floatValue];
        mInfoModel.kcal = [bodyData.Kcal intValue];
        mInfoModel.vat = [bodyData.VAT floatValue];
        mInfoModel.tbw = [bodyData.TBW floatValue];
        mInfoModel.lbm = [bodyData.LBM floatValue];
        mInfoModel.bodyAge = [bodyData.BODY_AGE intValue];
        mInfoModel.smr = [bodyData.smr floatValue];
        mInfoModel.measuretime = bodyData.measuretime;
        [tmpArray addObject:mInfoModel];
      }
      int len = (int)[tmpArray count];
      if (len > 0) {
        NSArray *resultArray = nil;
        if (len > 1) {
          resultArray = [tmpArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            MeasureInfoModel *model1 = (MeasureInfoModel *)obj1;
            MeasureInfoModel *model2 = (MeasureInfoModel *)obj2;
            NSNumber *num1 = [NSNumber numberWithDouble:[model1.measuretime doubleValue]];
            NSNumber *num2 = [NSNumber numberWithDouble:[model2.measuretime doubleValue]];
            NSComparisonResult result = [num1 compare:num2];
            return result == NSOrderedDescending;
          }];
        } else {
          resultArray = [NSArray arrayWithArray:tmpArray];
        }
        [self.infoMArray addObjectsFromArray:resultArray];
        len = (int)[self.infoMArray count];
        self.timeIndex = len - 1;
        if (len > 1) {
          self.leftButton.hidden = NO;
          self.rightButton.hidden = YES;
        } else {
          self.leftButton.hidden = YES;
          self.rightButton.hidden = YES;
        }
        MeasureInfoModel *model = [self.infoMArray lastObject];
        [self refreshInfo:model];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.measuretime doubleValue] / 1000.0f];
        if (date) {
          self.timeLabel.text = [date stringWithFormat:@"HH:mm"];
        }
      } else {
        [self refreshInfo:[[MeasureInfoModel alloc] init]];
        self.timeLabel.text = @"";
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
      }
    });
  }];
}

- (void)onLeftButton:(id)sender
{
  self.timeIndex--;
  if (self.timeIndex <= 0) {
    self.leftButton.hidden = YES;
    self.timeIndex = 0;
  }
  self.rightButton.hidden = NO;
  if (self.timeIndex >= 0 && self.timeIndex < [self.infoMArray count]) {
    MeasureInfoModel *model = [self.infoMArray objectAtIndex:self.timeIndex];
    [self refreshInfo:model];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.measuretime doubleValue]/1000.0f];
    if (date) {
      self.timeLabel.text = [date stringWithFormat:@"HH:mm"];
    }
  }
}

- (void)onRightButton:(id)sender
{
  self.timeIndex++;
  int len = (int)[self.infoMArray count];
  if (self.timeIndex >= len -1) {
    self.rightButton.hidden = YES;
    self.timeIndex = len - 1;
  }
  self.leftButton.hidden = NO;
  if (self.timeIndex < len) {
    MeasureInfoModel *model = [self.infoMArray objectAtIndex:self.timeIndex];
    [self refreshInfo:model];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.measuretime doubleValue]/1000.0f];
    if (date) {
      self.timeLabel.text = [date stringWithFormat:@"HH:mm"];
    }
  }
}

- (void)refreshInfo:(MeasureInfoModel *)infoModel
{
    HTUserData *userData = [HTUserData sharedInstance];
    self.testLabel.text = [NSString stringWithFormat:@"%@---%@", self.testStr, userData.requestCode];
    
    // 体重
    self.weightNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.weight];

    // 体脂
    self.fatNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.fat];
    if (infoModel.fat > 60)
    {
        self.fatNumLabel.text = [NSString stringWithFormat:@"61"];
    }
    State *fatState = [CommonHelper calculateFat:infoModel.fat];
    self.fatStatLabel.text = fatState.text;
    self.fatStatLabel.backgroundColor = fatState.color;
    
    // 内脂
    self.nFatNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.vat];
    State *vatState = [CommonHelper calculateVat:infoModel.vat];
    self.nFatStatLabel.text = vatState.text;
    self.nFatStatLabel.backgroundColor = [UIColor blackColor];
    self.nFatStatLabel.backgroundColor = vatState.color;
    
    // 体水分
    self.wetNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.tbw];
    State *tbwState = [CommonHelper calculateTBW:infoModel.tbw];
    self.wetStatLabel.text = tbwState.text;
    self.wetStatLabel.backgroundColor = tbwState.color;
    
    // 肌肉量
    self.muscleNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.lbm];
    State *lbmState = [CommonHelper calculateLBM:infoModel.lbm];
    self.muscleStatLabel.text = lbmState.text;
    self.muscleStatLabel.backgroundColor = lbmState.color;
    self.metaNumLabel.text = [NSString stringWithFormat:@"%d", infoModel.kcal];
    
    // BMI
    self.mbiNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.bmi];
    State *bmiStat = [CommonHelper calculateBMI:infoModel.bmi];
    self.mbiStatLabel.text = bmiStat.text;
    self.mbiStatLabel.backgroundColor = bmiStat.color;
    
//    int age = (int)[CommonHelper bodyAgeWithFat:infoModel.fat measureAge:infoModel.bodyAge];
    // 身体年龄
    self.ageNumLabel.text = [NSString stringWithFormat:@"%d",infoModel.bodyAge];
    
    // 骨骼率
    State *boneMassState = [CommonHelper calculateBoneMass:infoModel.smr];
    self.boneMassStatLabel.text = boneMassState.text;
    self.boneMassStatLabel.backgroundColor = boneMassState.color;
    self.boneMassNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.smr];
    if ([boneMassState.text isEqualToString:@"N/A"])
    {
       self.boneMassNumLabel.text = [NSString stringWithFormat:@"%0.1f", 0.0];
    }
}

-(void)oncalendaClick:(id)sender
{
  JTCalendarViewController*calendaController=[[JTCalendarViewController alloc]init];
  calendaController.delegate = self;
  calendaController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  [self.view addSubview:calendaController.view];
  [self.view bringSubviewToFront:calendaController.view];
  [self addChildViewController:calendaController];
}

-(void)onDayClick:(NSDate*)date
{
  [self setDateInfo:date];
}

- (void)onForwardClick:(id)sender
{
    self.sharePlat.showTrend = YES;
    [self.sharePlat showShareActionSheet];
    self.sharePlat.delegate = self;
}

- (void)onMBIClick:(id)sender
{
//  CGFloat weight = [self.weightNumLabel.text floatValue];
//  if (weight > 0) {
//    BMIViewController *controller = [[BMIViewController alloc] init];
//    controller.weight = weight;
//    [self.navigationController pushViewController:controller animated:YES];
//  }
    float fat = [self.fatNumLabel.text floatValue];
    float bmi = [self.mbiNumLabel.text floatValue];
    if (fat > 0 && bmi > 0) {
        BMIViewController *controller = [[BMIViewController alloc] init];
        controller.fat = fat;
        controller.bmi = bmi;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)onLBMClick:(id)sender
{
  LBMViewController *controller = [[LBMViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)onBodyAgeClick:(id)sender
{
  BodyAgeViewController *controller = [[BodyAgeViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)onKcalClick:(id)sender
{
  KcalViewController *controller = [[KcalViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)onVatClick:(id)sender
{
  VatViewController *controller = [[VatViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)onFatClick:(id)sender
{
  float fat = [self.fatNumLabel.text floatValue];
  if (fat > 0) {
    FatViewController *controller = [[FatViewController alloc] init];
    controller.fat = fat;
    [self.navigationController pushViewController:controller animated:YES];
  }
}

- (void)onTargetClick:(id)sender
{
  float fat = [self.fatNumLabel.text floatValue];
  float bmi = [self.mbiNumLabel.text floatValue];
  if (fat > 0 && bmi > 0) {
    TargetViewController *controller = [[TargetViewController alloc] init];
    controller.fat = fat;
    controller.bmi = bmi;
    [self.navigationController pushViewController:controller animated:YES];
  }
}

- (void)onWeightClick:(id)sender
{
    WeightViewController *controller = [[WeightViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onWaterClick:(id)sender
{
    WaterViewController *controller = [[WaterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onBoneMssClick:(id)sender
{
    BoneMassViewController *controller = [[BoneMassViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - SharePlatDelegate
- (void)gotoTrend
{
  TrendListViewController *trendController = [[TrendListViewController alloc] init];
  [self.navigationController pushViewController:trendController animated:YES];
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

#pragma mark - syncdataDelegate
- (void)syncFinished:(SyncDataListResponse *)response
{
    HTUserData *userData = [HTUserData sharedInstance];
    APP_DELEGATE.updated = YES;
    [DBHelper dropTableDatas:[BodyData getTableName]];
    NSArray *dataArray = response.results;
    for (int i=0; i<dataArray.count; i++) {
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
        bodyData.uid = userData.uid;
        bodyData.measuretime = sbd.measureTime;
        bodyData.smr = [NSString stringWithFormat:@"%.1f",sbd.smr.floatValue];;
        [DBHelper saveBodyData:bodyData];
    }
    [self setDateInfo:[NSDate date]];
    HLoadingView *loading = [HLoadingView defaultView];
    loading.isFinish = YES;
}

- (void)syncFailure
{
    [self setDateInfo:[NSDate date]];
    HLoadingView *loading = [HLoadingView defaultView];
    loading.isFinish = YES;
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
  if (MessageComposeResultCancelled == result) {
    [controller dismissViewControllerAnimated:YES completion:nil];
  }
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shakepushmeasure" object:nil];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController;
{
    [self resignFirstResponder];
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController;
{
    [self becomeFirstResponder];
}

- (void)refreshHome
{
    [self refreshData:YES];
}

@end
