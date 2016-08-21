//
//  TrendListViewController.h
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableViewController.h"
#import "BodyData.h"

@interface TrendListViewController : HTTableViewController<UIAlertViewDelegate>
{
    UIImageView *popView;
    UIView *maskview;
    BOOL isListShowed;
}

@property (nonatomic,copy) NSString *otherUid;
@property (nonatomic,copy) NSString *nickName;

-(BOOL)isInArray:(BodyData*)model;
-(void)addBodyData:(BodyData*)model;
-(void)removeBodyData:(BodyData*)model;

@end
