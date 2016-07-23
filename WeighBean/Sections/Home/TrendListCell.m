//
//  TrendListCell.m
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "TrendListCell.h"
#import "State.h"
#import "CommonHelper.h"

@interface TrendListCell ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) NSMutableArray *labArray;

@end

@implementation TrendListCell

- (void)initSubViews
{
    self.itemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 55)];
    self.itemView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.itemView];
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width-140, 5, 140, 12)];
    [self addSubview:self.timeLab];
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.timeLab.bottom+5, self.width-15, 1)];
    lineIV.backgroundColor = UIColorFromRGB(237, 237, 237);
    [self.itemView addSubview:lineIV];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(10, lineIV.bottom, 30, 30);
    [self.selectBtn setImage:[UIImage imageNamed:@"trend_sel_nomal"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"trend_sel_selected"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(onOperateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.itemView addSubview:self.selectBtn];

    self.labArray = [[NSMutableArray alloc]initWithCapacity:3];
    UIColor *itemColor = UIColorFromRGB(20, 146, 215);
    UILabel *itemLab = [self createItemLab:@"体重：" withValue:@"" withBg:itemColor left:35];
    itemLab.frame = CGRectMake(40, self.timeLab.bottom+2, self.width/3.0-20, 40);
    [self.itemView addSubview:itemLab];
    
    UIColor *itemColor2 = UIColorFromRGB(20, 146, 215);
    UILabel *itemLab2 = [self createItemLab:@"体脂率：" withValue:@"" withBg:itemColor2 left:35];
    itemLab2.frame = CGRectMake(itemLab.right, self.timeLab.bottom+2, self.width/3.0-20, 40);
    [self.itemView addSubview:itemLab2];
    
    UIColor *itemColor3 = UIColorFromRGB(215, 136, 20);
    UILabel *itemLab3 = [self createItemLab:@"肌肉量：" withValue:@"" withBg:itemColor3 left:50];
    itemLab3.frame = CGRectMake(itemLab2.right+15, self.timeLab.bottom+2, self.width/3.0-20, 40);
    [self.itemView addSubview:itemLab3];
    
}

- (void)bindBodyDataInfo:(BodyData*)model
{
    self.model = model;
    long long timeLine = [model.measuretime longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeLine/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.timeLab.text = [formatter stringFromDate:confromTimesp];
    self.timeLab.font = [UIFont systemFontOfSize:12.0f];
    self.timeLab.textColor = UIColorFromRGB(180, 180, 180);
    
    NSString *item1 = [NSString stringWithFormat:@" %.1f ",model.W.floatValue];
    NSString *item2 = [NSString stringWithFormat:@" %.1f ",model.FAT.floatValue];
    NSString *item3 = [NSString stringWithFormat:@" %.1f ",model.LBM.floatValue];
    
//    State *weightState = [CommonHelper calculateBMI:item1.floatValue];
    State *fatState = [CommonHelper calculateFat:item2.floatValue];
    State *lbmState = [CommonHelper calculateLBM:item3.floatValue];
    UILabel *item1Lab = [self.labArray objectAtIndex:0];
    item1Lab.text = item1;
    [item1Lab sizeToFit];
    item1Lab.textColor = [UIColor whiteColor];
    item1Lab.backgroundColor = UIColorFromRGB(180, 180, 180);
    item1Lab.frame = CGRectMake(35, 40/2.0-item1Lab.height/2.0,item1Lab.width ,item1Lab.height);
    
    UILabel *item2Lab = [self.labArray objectAtIndex:1];
    item2Lab.text = item2;
    [item2Lab sizeToFit];
    item2Lab.backgroundColor = fatState.color;
    item2Lab.textColor = [UIColor whiteColor];
    item2Lab.frame = CGRectMake(50, 40/2.0-item2Lab.height/2.0,item2Lab.width ,item2Lab.height);
    
    UILabel *item3Lab = [self.labArray objectAtIndex:2];
    item3Lab.text = item3;
    [item3Lab sizeToFit];
    item3Lab.backgroundColor = lbmState.color;
    item3Lab.textColor = [UIColor whiteColor];
    item3Lab.frame = CGRectMake(50, 40/2.0-item3Lab.height/2.0,item3Lab.width ,item3Lab.height);
    
    
    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-5, self.width, 5)];
    bottomIV.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomIV];
}

-(UILabel*)createItemLab:(NSString*)itemName withValue:(NSString*)itemValue withBg:(UIColor*)bgColor left:(int)left
{
    UILabel *itemLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.timeLab.bottom+2, self.width/3.0, 40)];
    itemLab.text = itemName;
    itemLab.font = [UIFont systemFontOfSize:13.0f];
    UILabel *itemValueLab = [[UILabel alloc]initWithFrame:CGRectMake(left, 2, 40, 15)];
    itemValueLab.text = [NSString stringWithFormat:@" %@ ",itemValue];
    itemValueLab.font = [UIFont systemFontOfSize:12.0f];
    [itemValueLab sizeToFit];
    itemValueLab.frame = CGRectMake(left, 40/2.0-itemValueLab.height/2.0,itemValueLab.width ,itemValueLab.height);
    itemValueLab.backgroundColor = bgColor;
    [itemLab addSubview:itemValueLab];
    [self.labArray addObject:itemValueLab];
    return itemLab;
}

- (void)onOperateClick:(UIButton *)button
{
    if (self.delegate) {
        [self.delegate onSelOrDesSelItem:self.model button:button];
    }
}

@end
