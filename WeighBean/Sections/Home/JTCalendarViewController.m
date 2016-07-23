//
//  JTCalendarViewController.m
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "JTCalendarViewController.h"
#import "DBHelper.h"

@interface JTCalendarViewController ()

@end

static NSString *kJTCalendarDayClicked = @"kJTCalendarDayClicked";

@implementation JTCalendarViewController

-(void)initModel
{
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    self.view.frame=CGRectMake(0, 0, self.view.width, self.view.height);
    self.view.backgroundColor=[UIColor clearColor];
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.6];
    view.userInteractionEnabled = YES;
    [view addTapCallBack:self sel:@selector(onViewClick)];
    
    
    UIButton *preButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 60, 44.0f, 44.0f)];
    [preButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [preButton addTarget:self action:@selector(onPreClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 44 - 30, 60, 44.0f, 44.0f)];
    [nextButton setImage:[UIImage imageNamed:@"next_nav_bar.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(onNextClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.calendarMenuView = [[JTCalendarMenuView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 44)];
    self.calendarMenuView.backgroundColor = UIColorFromRGB(49, 175, 227);
    self.calendarMenuView.userInteractionEnabled = YES;
    
    [view addSubview:self.calendarMenuView];
    self.calendarContentView = [[JTCalendarContentView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 260)];
    self.calendarContentView.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.calendarContentView];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    [self.calendarMenuView addSubview:preButton];
    [self.calendarMenuView addSubview:nextButton];
    [self.view addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDayClicked:) name:kJTCalendarDayClicked object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
    [DBHelper initCalendaData];
}

- (void)didDayClicked:(NSNotification *)notification
{
    NSDate *dateSelected = [notification object];
    
//    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
//    NSDateComponents *comp1 = [myCal components:units fromDate:dateSelected];
//    NSInteger month = [comp1 month];
//    NSInteger year = [comp1 year];
//    NSInteger today = [comp1 day];
//    NSInteger tomorrow = today +1;
//    NSString *endTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)tomorrow];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    
//    NSDate* endDate = [formatter dateFromString:endTimeStr];
  
    if ([self.delegate respondsToSelector:@selector(onDayClick:)]) {
        [self.delegate onDayClick:dateSelected];
    }
    //关闭日历
    [self onViewClick];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{

}

-(void)onPreClick:(id)sender
{
    [self.calendar loadPreviousMonth];
}


-(void)onNextClick:(id)sender
{
    [self.calendar loadNextMonth];
}

-(void)onViewClick
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

@end
