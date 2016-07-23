//
//  WiFiController.h
//  WeighBean
//
//  Created by 曾宪东 on 15/9/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "PassValueDelegate.h"

@interface WiFiController : HTBaseViewController
{

}
@property (nonatomic, assign) id<PassValueDelegate> delegate;
@property (nonatomic, strong) NSArray *array;

@end


@interface SetOrder : NSObject
{
    int day ;
    float height ;
    int month ;
    int sex;
    int user_code ;
    float weigh ;
    int year;
}

- (void)initobj;
-(NSString *)getDataPackage;
-(NSString *)toString;
-(void)setDay:(int) paramInt;
-(void)setHeight:(float) paramFloat;
-(void)setMonth:(int) paramInt;
-(void)setSex:(int) paramInt;
-(void)setWeigh:(float) paramFloat;
-(void)setYear:(int) paramInt;

@end