//
//  DBHelper.h
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
#import "BodyData.h"

@interface DBHelper : NSObject

//创建数据库
+(LKDBHelper *)getUsingLKDBHelper;
//删除表数据
+(void)dropTableDatas:(NSString*)tableName;
//插入一条数据
+(void)saveBodyData:(BodyData*)bodyData;
//删除一条数据
+(void)delBodyData:(BodyData*)bodyDate;
//查询某一天数据
+(void)getDatasbyOneDay:(NSDate*)date black:(void(^)(NSMutableArray * result))success;

//查询所有数据
+(void)getBodyData:(NSString*)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count black:(void(^)(NSMutableArray * result))success;

+(void)initCalendaData;

@end
