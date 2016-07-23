//
//  JTCalendarViewController.h
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "JTCalendar.h"

@protocol JTCalendarDelegate <NSObject>

-(void)onDayClick:(NSDate*)date;

@end


@interface JTCalendarViewController : HTBaseViewController<JTCalendarDataSource>

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;

@property (strong, nonatomic) id<JTCalendarDelegate> delegate;
@end
