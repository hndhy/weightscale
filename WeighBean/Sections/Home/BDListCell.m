//
//  BDListCell.m
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BDListCell.h"

@interface BDListCell ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation BDListCell

- (void)initSubViews
{
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width-120, 0, 120, 30)];
    [self addSubview:self.timeLab];
    
    self.viewArray = [[NSMutableArray alloc]initWithCapacity:5];
    //列表展示标题
    [self createListView];
}

- (void)bindBodyDataInfo:(BodyData*)model
{

    long long timeLine = [model.measuretime longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeLine/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.timeLab.text = [formatter stringFromDate:confromTimesp];
    self.timeLab.font = [UIFont systemFontOfSize:10.0f];
    
    NSString *item1 = [NSString stringWithFormat:@"%.1f公斤",model.W.floatValue];
    NSString *item2 = [NSString stringWithFormat:@"%.1f%%",model.FAT.floatValue];
    NSString *item3 = [NSString stringWithFormat:@"%.1f级",model.VAT.floatValue];
//    NSString *item4 = [NSString stringWithFormat:@"%.1f公斤",model.BMC.floatValue];
    NSString *item4 = [NSString stringWithFormat:@"%.1f公斤",model.LBM.floatValue];
    NSString *item5 = [NSString stringWithFormat:@"%@岁",model.BODY_AGE];
    
    NSArray *itemValues = @[item1,item2,item3,item4,item5];
    for (int i=0; i<itemValues.count; i++) {
        UILabel *itemLab = [self.viewArray objectAtIndex:i];
        itemLab.text = itemValues[i];
    }
}

-(void)createListView
{
    for (int i=0; i<5; i++) {
        UILabel *itemLab = [[UILabel alloc]init];
        itemLab.frame = CGRectMake(60*i, 15, self.width/5.0, 30);
        itemLab.font = [UIFont systemFontOfSize:13.0f];
        itemLab.textColor = [UIColor blackColor];
        itemLab.textAlignment = NSTextAlignmentCenter;
        itemLab.backgroundColor = [UIColor clearColor];
        [self addSubview:itemLab];
        [self.viewArray addObject:itemLab];
    }
}


@end
