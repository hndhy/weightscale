//
//  MyInfoModelModelHandler.m
//  WeighBean
//
//  Created by liumadu on 15/8/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "MyInfoModelHandler.h"

@implementation MyInfoModelHandler

- (id)initWithController:(HTBaseViewController<MyInfoModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<MyInfoModelProtocol> *controller = (HTBaseViewController<MyInfoModelProtocol>*)self.controller;
  [controller myInfoFinished:(UserResponse *)data];
}

@end
