//
//  TrendListDataSource.m
//  WeighBean
//
//  Created by heng on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "TrendListDataSource.h"
#import "BodilyDataViewController.h"
#import "TrendListViewController.h"
#import "TrendListCell.h"

@interface TrendListDataSource ()<SelOrDesSelCellDelegate>


@end

@implementation TrendListDataSource

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"TrendListCell";
    
    TrendListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[TrendListCell alloc] initWithReuseIdentifier:CellTableIdentifier];
    }
    BodyData *bodyData = [self.dataArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell bindBodyDataInfo:bodyData];
    TrendListViewController *trendVC = (TrendListViewController*)self.controller;
    if ([trendVC isInArray:bodyData]) {
        cell.selectBtn.selected = YES;
    }else{
        cell.selectBtn.selected = NO;

    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
    
}
//选择一项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
//取消一项
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)onSelOrDesSelItem:(BodyData *)model button:(UIButton *)button{
    TrendListViewController *trendVC = (TrendListViewController*)self.controller;
    if (button.selected) {
        button.selected = NO;
        [trendVC removeBodyData:model];
    }else{
        button.selected = YES;
        [trendVC addBodyData:model];
    }
}

@end
