//
//  BodyData.h
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"


@interface BodyData : NSObject

/**
 http://123.57.20.86:8000/jsonDemo.jsp
 
 db.execSQL("CREATE TABLE IF NOT EXISTS measure(id integer primary key autoincrement,W varchar,BMI varchar,FAT varchar,TBW varchar,LBM varchar,BMC varchar,VAT varchar,Kcal varchar,BODY_AGE varchar,measuretime integer, uid varchar,issync varchar)");
 db.execSQL("CREATE TABLE IF NOT EXISTS user(uid varchar primary key,sex varchar,age integer,height integer,birthday varchar,coach varchar,device varchar,nick varchar,phone varchar,pwd varchar,userlogo varchar,iscoach integer)");
 
 */
@property(nonatomic, strong)  NSString* W;//体重
@property(nonatomic, strong)  NSString* BMI;//
@property(nonatomic, strong)  NSString* FAT;//体脂
@property(nonatomic, strong)  NSString* TBW;//水分
@property(nonatomic, strong)  NSString* LBM;//肌肉
@property(nonatomic, strong)  NSString* BMC;//骨量
@property(nonatomic, strong)  NSString* VAT;//内脂
@property(nonatomic, strong)  NSString* Kcal;//基础代谢
@property(nonatomic, strong)  NSString* BODY_AGE;
@property(nonatomic, strong)  NSString* uid;//用户id
@property(nonatomic, strong)  NSString* issync;//是否同步到服务器 1为已经同步 、0为未同步
@property(nonatomic, strong)  NSString* measuretime;
//@property(nonatomic, strong)  NSString* boneMass;// 骨骼肌率
@property(nonatomic, strong)  NSString* smr;// 骨骼肌率
@end


@interface NSObject(PrintSQL)
+(NSString*)getCreateTableSQL;
@end