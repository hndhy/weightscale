//
//  DBHelper.m
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "DBHelper.h"
#import "BodyData.h"
#import "AccountData.h"
#import "HTUserData.h"
#import "NSDate+Utilities.h"

@implementation DBHelper

//重载选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"WeighBean/WeighBean.db"];
                db = [[LKDBHelper alloc]initWithDBPath:dbPath];
    });
    return db;
}

+(void)dropTableDatas:(NSString*)tableName
{
    LKDBHelper* globalHelper = [self getUsingLKDBHelper];
    [globalHelper deleteWithTableName:tableName where:nil];
}

+(void)saveBodyData:(BodyData*)bodyData;
{
    LKDBHelper* globalHelper = [self getUsingLKDBHelper];
    [globalHelper insertToDB:bodyData];
}

//"select * from measure where measuretime>=? and measuretime<? and uid=? order by measuretime asc"

+(void)getDatasbyOneDay:(NSDate*)date black:(void(^)(NSMutableArray * result))success{
    
//    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
//    NSDateComponents *comp1 = [myCal components:units fromDate:date];
//    NSInteger month = [comp1 month];
//    NSInteger year = [comp1 year];
//    NSInteger today = [comp1 day];
//    NSInteger tomorrow = today +1;
  NSInteger month = date.month;
  NSInteger year = date.year;
  NSInteger today = date.day;
  NSDate *tomorrow = [date dateByAddingDays:1];
  NSInteger tMonth = tomorrow.month;
  NSInteger tYear = tomorrow.year;
  NSInteger tToday = tomorrow.day;
  
  
    NSString *startTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)today];
    NSString *endTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)tYear,(long)tMonth,(long)tToday];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate* startDate = [formatter dateFromString:startTimeStr];
    NSDate* endDate = [formatter dateFromString:endTimeStr];
    
    NSString *startTimeSp = [NSString stringWithFormat:@"%ld", (long)[startDate timeIntervalSince1970]];
    NSString *endTimeSp = [NSString stringWithFormat:@"%ld", (long)[endDate timeIntervalSince1970]];
    
    
    LKDBHelper* globalHelper = [self getUsingLKDBHelper];
    
    [globalHelper search:[BodyData class] where:[NSString stringWithFormat:@"measuretime>=%@ and measuretime<%@",startTimeSp,endTimeSp] orderBy:@"measuretime DESC" offset:0 count:20 callback:^(NSMutableArray *array) {
        
        success(array);
        
        for (NSObject* obj in array) {
            BodyData *bd = (BodyData*)obj;
            NSLog(@"arrayByDay－－%@",bd.measuretime);
        }
    }];

}

+(void)getBodyData:(NSString*)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count black:(void(^)(NSMutableArray * result))success
{
     LKDBHelper* globalHelper = [self getUsingLKDBHelper];
    
    //异步 asynchronous
    [globalHelper search:[BodyData class] where:where orderBy:[NSString stringWithFormat:@"%@ DESC",orderBy] offset:offset count:count callback:^(NSMutableArray *array) {
    
        success(array);
//        for (NSObject* obj in array) {
//            BodyData *bd = (BodyData*)obj;
//            NSLog(@"asynchronous－－%@",bd.measuretime);
//        }
    }];
}

+(void)delBodyData:(BodyData*)bodyDate
{
    LKDBHelper* globalHelper = [self getUsingLKDBHelper];
    BOOL ishas = [globalHelper isExistsModel:bodyDate];
    if(ishas)
    {
        [globalHelper deleteToDB:bodyDate];
    }
}

+(void)initCalendaData
{
    HTUserData *userData = [HTUserData sharedInstance];
    [DBHelper getBodyData:[NSString stringWithFormat:@"uid='%@'",userData.uid] orderBy:@"measuretime" offset:0 count:1000 black:^(NSMutableArray *result) {
        for (id obj in result) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                BodyData *db = (BodyData*)obj;
                long long timeLine = [db.measuretime longLongValue];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeLine/1000];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSLog(@"myDate = %@",confromTimesp);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kJTCalendarDaySelected" object:confromTimesp];
            });
            
        }
    }];
}
@end
