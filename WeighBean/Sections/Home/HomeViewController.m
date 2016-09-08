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

#import "CheckInImgPickerViewController.h"

#import "CheckInPickResultViewController.h"
#import "WiFiController.h"

#import "HTNavigationController.h"


#import "TimelineViwController.h"
#import "PicturePicker.h"


@interface HomeViewController ()<SharePlatDelegate, SyncModelProtocol, MFMessageComposeViewControllerDelegate,JTCalendarDelegate,RESideMenuDelegate,UIImagePickerControllerDelegate,PicturePickerProtocol>

{
    HTMultiLabel *weightLabel;
    HTMultiLabel *fatLabel;
    HTMultiLabel *nFatLabel;
    HTMultiLabel *boneLabel;
    HTMultiLabel *muscleLabel;
    HTMultiLabel *metaLabel;
    HTMultiLabel *mbiLabel;
    HTMultiLabel *wetLabel;
    HTMultiLabel *ageLabel;
}

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
@property (nonatomic, strong) UIButton *dateLabel;

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
@property (nonatomic, strong) PicturePicker *picturePicker;

@end

@implementation HomeViewController

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
                                           withSize:16.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
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

-(void)initModel
{
  self.syncHandler = [[SyncDataModelHander alloc]initWithController:self];
  self.syncModel = [[HTSyncDataModel alloc]initWithHandler:self.syncHandler];
  self.infoMArray = [NSMutableArray arrayWithCapacity:8];
}

- (void)initView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICEW, 43.0f)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    self.itemArray = [NSMutableArray arrayWithCapacity:5];
    self.dateArray = [NSMutableArray arrayWithCapacity:5];
    
    //年月日 uibutton 作 uilabel
    self.dateLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, titleView.top+5, 150, 40)];
    [self.dateLabel setImage:[UIImage imageNamed:@"time_icon.png"] forState:UIControlStateNormal];
    [self.dateLabel setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [self.dateLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    [self.dateLabel setTitle:@"" forState:UIControlStateNormal];
    [self.dateLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dateLabel.titleLabel.font = UIFontOfSize(14);
    self.dateLabel.enabled = NO;
    [titleView addSubview:self.dateLabel];

    
    self.timeLabel = [UILabel createLabelWithFrame:CGRectMake(190, titleView.top, 90, 50)
                                          withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:self.timeLabel];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel.left - 33.0f, self.timeLabel.top, 33.0f, 50)];
    [self.leftButton setImage:[UIImage imageNamed:@"arrow_left_icon.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(onLeftButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.leftButton.hidden = YES;
    [titleView addSubview:self.leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.timeLabel.right, self.timeLabel.top, 33.0f, 50)];
    [self.rightButton setImage:[UIImage imageNamed:@"arrow_right_icon.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(onRightButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.rightButton.hidden = YES;
    [titleView addSubview:self.rightButton];
    
    // 指标第一个View
    CGFloat contentHeight = SCREEN_HEIGHT_EXCEPTNAV-50-63;
    CGFloat margin = contentHeight * 0.025f;
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.bottom + 6, DEVICEW,contentHeight * 0.33f)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    // 指示第二个view
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.bottom, DEVICEW, firstView.height)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    // 指标第三个view
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, secondView.bottom, DEVICEW, secondView.height)];
    thirdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdView];
    
    
    State *normalState = [[State alloc] init];
    normalState.text = @"正常";
    normalState.color = BLUECOLOR;
    
    //数据视图
    weightLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [weightLabel setInfoForNumber:@"0" titleLabel:@"体重" tagLabel:@"公斤" stateLabel:normalState];
    [weightLabel addTapCallBack:self sel:@selector(onWeightClick:)];
    [firstView addSubview:weightLabel];
    
    fatLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [fatLabel setInfoForNumber:@"0" titleLabel:@"体脂率" tagLabel:@"％" stateLabel:normalState];
    [fatLabel addTapCallBack:self sel:@selector(onFatClick:)];
    [firstView addSubview:fatLabel];
    
    nFatLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [nFatLabel setInfoForNumber:@"0" titleLabel:@"内脂" tagLabel:@"级" stateLabel:normalState];
    [nFatLabel addTapCallBack:self sel:@selector(onVatClick:)];
    [firstView addSubview:nFatLabel];
    
    boneLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [boneLabel setInfoForNumber:@"0" titleLabel:@"骨骼肌率" tagLabel:@"％" stateLabel:normalState];
    [boneLabel addTapCallBack:self sel:@selector(onBoneMssClick:)];
    [secondView addSubview:boneLabel];
    
    muscleLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [muscleLabel setInfoForNumber:@"0" titleLabel:@"肌肉量" tagLabel:@"公斤" stateLabel:normalState];
    [muscleLabel addTapCallBack:self sel:@selector(onLBMClick:)];
    [secondView addSubview:muscleLabel];
    
    metaLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [metaLabel setInfoForNumber:@"0" titleLabel:@"基础代谢" tagLabel:@"kcal" stateLabel:normalState];
    [metaLabel addTapCallBack:self sel:@selector(onKcalClick:)];
    [secondView addSubview:metaLabel];
    
    mbiLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.left, 0, firstView.width/3.0f, firstView.height)];
    [mbiLabel setInfoForNumber:@"0" titleLabel:@"BMI" tagLabel:@"" stateLabel:normalState];
    [mbiLabel addTapCallBack:self sel:@selector(onMBIClick:)];
    [thirdView addSubview:mbiLabel];
    
    wetLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [wetLabel setInfoForNumber:@"0" titleLabel:@"体水分" tagLabel:@"％" stateLabel:normalState];
    [wetLabel addTapCallBack:self sel:@selector(onWaterClick:)];
    [thirdView addSubview:wetLabel];
    
    ageLabel = [[HTMultiLabel alloc] initWithFrame:CGRectMake(firstView.width*2/3.0f, 0, firstView.width/3.0f, firstView.height)];
    [ageLabel setInfoForNumber:@"0" titleLabel:@"身体年龄" tagLabel:@"％" stateLabel:normalState];
    [ageLabel addTapCallBack:self sel:@selector(onBodyAgeClick:)];
    [thirdView addSubview:ageLabel];
    
    
    //三个按钮 打卡
    UIButton *checkInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkInBtn.frame = CGRectMake(0, SCREEN_HEIGHT_EXCEPTNAV-48, self.view.size.width/3, 48);
    checkInBtn.backgroundColor = [UIColor whiteColor];
    checkInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [checkInBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [checkInBtn setImage:[UIImage imageNamed:@"daka_iconv"] forState:UIControlStateNormal];
    [checkInBtn addTarget:self action:@selector(showImgPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkInBtn];
    
    UIButton *measureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    measureBtn.frame = CGRectMake(self.view.size.width/3, SCREEN_HEIGHT_EXCEPTNAV-48, self.view.size.width/3, 48);
    measureBtn.backgroundColor = [UIColor whiteColor];
    measureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [measureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [measureBtn setImage:[UIImage imageNamed:@"celiang_iconv"] forState:UIControlStateNormal];
    [measureBtn addTarget:self action:@selector(onMeasureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:measureBtn];
    
    UIButton *sportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sportBtn.frame = CGRectMake(2*self.view.size.width/3, SCREEN_HEIGHT_EXCEPTNAV-48, self.view.size.width/3, 48);
    sportBtn.backgroundColor = [UIColor whiteColor];
    sportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sportBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sportBtn setImage:[UIImage imageNamed:@"yundong_iconv"] forState:UIControlStateNormal];
    [sportBtn addTarget:self action:@selector(enterDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sportBtn];

    
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
#pragma mark 同步数据
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

- (void)setDateInfo:(NSDate *)date
{
    [self setDateInfoItem:date];

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

- (void)showImgPicker
{
    if (nil == self.picturePicker) {
        self.picturePicker = [[PicturePicker alloc] initWithController:self];
        self.picturePicker.type = PicturePickerCheckIn;
    }
    [self.picturePicker showActionSheet:nil];
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
    
//    [self.dateLabel setText:[date stringWithFormat:@"yyyy年MM月dd日"]];
    [self.dateLabel setTitle:[date stringWithFormat:@"yyyy年MM月dd日"] forState:UIControlStateNormal];
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
    
    
    
    
    State *normalState = [[State alloc] init];
    normalState.text = @"正常";
    normalState.color = BLUECOLOR;

    // 体重
    [weightLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.weight] titleLabel:@"体重" tagLabel:@"公斤" stateLabel:normalState];
    
    // 体脂
//    self.fatNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.fat];
//    if (infoModel.fat > 60)
//    {
//        self.fatNumLabel.text = [NSString stringWithFormat:@"61"];
//    }
    [fatLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.fat] titleLabel:@"体脂率" tagLabel:@"％" stateLabel:[CommonHelper calculateFat:infoModel.fat]];
   
    // 内脂
    [nFatLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.vat] titleLabel:@"内脂" tagLabel:@"级" stateLabel:[CommonHelper calculateVat:infoModel.vat]];
   
    //骨骼肌率
//    self.boneMassNumLabel.text = [NSString stringWithFormat:@"%0.1f", infoModel.smr];
//    if ([boneMassState.text isEqualToString:@"N/A"])
//    {
//        self.boneMassNumLabel.text = [NSString stringWithFormat:@"%0.1f", 0.0];
//    }
    [boneLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.smr] titleLabel:@"骨骼肌率" tagLabel:@"％" stateLabel:[CommonHelper calculateBoneMass:infoModel.smr]];
   
    // 肌肉量
    [muscleLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.lbm] titleLabel:@"肌肉量" tagLabel:@"公斤" stateLabel:[CommonHelper calculateLBM:infoModel.lbm]];
  
    //meta
    [metaLabel setInfoForNumber:[NSString stringWithFormat:@"%d", infoModel.kcal] titleLabel:@"基础代谢" tagLabel:@"kcal" stateLabel:normalState];
   
    // BMI
    [mbiLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.bmi] titleLabel:@"BMI" tagLabel:@"" stateLabel:[CommonHelper calculateBMI:infoModel.bmi]];
  
    // 体水分
    [wetLabel setInfoForNumber:[NSString stringWithFormat:@"%0.1f", infoModel.tbw] titleLabel:@"体水分" tagLabel:@"％" stateLabel:[CommonHelper calculateTBW:infoModel.tbw]];
   
    //身体年龄
    [ageLabel setInfoForNumber:[NSString stringWithFormat:@"%d",infoModel.bodyAge] titleLabel:@"身体年龄" tagLabel:@"％" stateLabel:normalState];
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

- (void)onMeasureClick:(id)sender
{
    HTAppContext *appContext = [HTAppContext sharedContext];
    
    if (ISEMPTY(appContext.device)&& !appContext.isOpenWiFi)
    {
        [self showToast:@"请在个人资料里补填设备号"];
        return;
    }
    NSString *message = !appContext.isOpenWiFi ? @"请您确保手机蓝牙和体脂仪都是开启状态" : @"请您确保手机连接的是秤的WiFi";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (1 == buttonIndex)
//    {
//        HTAppContext *appContext = [HTAppContext sharedContext];
//        if (appContext.isOpenWiFi)
//        {
//            WiFiController *measureController = [[WiFiController alloc] init];
//            measureController.array = self.mArray;
//            measureController.delegate = self;
//            HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
//            [self presentViewController:navController animated:YES completion:nil];
//        }
//        else
//        {
//            MeasureViewController *measureController = [[MeasureViewController alloc] init];
//            measureController.array = self.mArray;
//            measureController.delegate = self;
//            HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:measureController];
//            [self presentViewController:navController animated:YES completion:nil];
//        }
//    }
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
//        bodyData.BMC = sbd.bmc;
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

- (void)enterDidClick
{
//    TimelineViwController *vc = [[TimelineViwController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
