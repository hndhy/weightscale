//
//  AccountData.m
//  WeighBean
//
//  Created by heng on 15/8/22.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "AccountData.h"

@implementation AccountData

//表名
+(NSString *)getTableName
{
    return @"LKAccountDataTable";
}
+(BOOL)isContainParent
{
    return YES;
}

//在类 初始化的时候
+(void)initialize
{
    //remove unwant property
    //比如 getTableMapping 返回nil 的时候   会取全部属性  这时候 就可以 用这个方法  移除掉 不要的属性
    [self removePropertyWithColumnName:@"error"];
    
    //enable the column binding property name
    //    [self setTableColumnName:@"MyAge" bindingPropertyName:@"age"];
    //    [self setTableColumnName:@"MyDate" bindingPropertyName:@"date"];
}

+(void)dbDidAlterTable:(LKDBHelper *)helper tableName:(NSString *)tableName addColumns:(NSArray *)columns
{
    for (int i=0; i<columns.count; i++)
    {
        LKDBProperty* p = [columns objectAtIndex:i];
        if([p.propertyName isEqualToString:@"error"])
        {
            [helper executeDB:^(FMDatabase *db) {
                NSString* sql = [NSString stringWithFormat:@"update %@ set error = name",tableName];
                [db executeUpdate:sql];
            }];
        }
    }
    //    LKErrorLog(@"your know %@",columns);
}

// 将要插入数据库
+(BOOL)dbWillInsert:(NSObject *)entity
{
    //    LKErrorLog(@"will insert : %@",NSStringFromClass(self));
    return YES;
}
//已经插入数据库
+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result
{
    //    LKErrorLog(@"did insert : %@",NSStringFromClass(self));
}

@end

@implementation NSObject(PrintSQL)

+(NSString *)getCreateTableSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
        {
            if(property.length>0)
            {
                [table_pars appendFormat:@"(%ld)",(long)property.length];
            }
        }
        if(property.isNotNull)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
        }
        if(property.isUnique)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
        }
        if(property.checkValue)
        {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
        }
        if(property.defaultValue)
        {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
        }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
        }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}

@end
