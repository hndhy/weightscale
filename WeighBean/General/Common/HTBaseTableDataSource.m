//
//  HTBaseDataSource.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseTableDataSource.h"

@implementation HTBaseTableDataSource

- (id)initWithController:(HTBaseViewController *)controller
{
  self = [super init];
  if (self) {
    self.controller = controller;
    self.pageSize = 10;
    self.latestPageSize = self.pageSize;
  }
  [self initModel];
  return self;
}

- (void)initModel
{
  
}

- (void)addDataArray:(NSArray *)array
{
  if (nil == self.dataArray) {
    self.dataArray = [NSMutableArray arrayWithArray:array];
  } else {
    [self.dataArray addObjectsFromArray:array];
  }
  self.latestPageSize = [array count];
  [self processDataArray];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
  if (nil == self.dataArray) {
    self.dataArray =  [NSMutableArray arrayWithObject:anObject];
  } else {
    [self.dataArray insertObject:anObject atIndex:index];
  }
  self.latestPageSize = [self.dataArray count];
  [self processDataArray];
}

- (void)processDataArray
{
  
}

- (void)clearData
{
  if (self.dataArray) {
    [self.dataArray removeAllObjects];
  }
  self.latestPageSize = self.pageSize;
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
  if (self.dataArray) {
    [self.dataArray removeObjectAtIndex:index];
  }
  self.latestPageSize = [self.dataArray count];
}

- (BOOL)isHasMoreData
{
  if (self.latestPageSize == self.pageSize) {
    return YES;
  }
  return NO;
}

- (int)count
{
  return (int)self.dataArray.count;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.dataArray) {
    return [self.dataArray count];
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

@end