//
//  HTBaseDataSource.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTBaseViewController.h"

@interface HTBaseTableDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) HTBaseViewController *controller;
@property (atomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int pageSize;        // 每页结果数量
@property (nonatomic, assign) NSUInteger latestPageSize;  // 最新页结果数量
@property (nonatomic, assign) BOOL isRefresh;

- (id)initWithController:(HTBaseViewController *)controller;
- (void)initModel;
- (int)count;
- (BOOL)isHasMoreData;
- (void)addDataArray:(NSArray *)array;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)processDataArray;
- (void)clearData;
- (void)removeObjectAtIndex:(NSUInteger)index;

@end
