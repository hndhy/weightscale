//
//  CollectClickModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CollectClickModelHandler.h"

@implementation CollectClickModelHandler

- (id)initWithController:(HTBaseViewController<CollectClickModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<CollectClickModelProtocol> *controller = (HTBaseViewController<CollectClickModelProtocol>*)self.controller;
  [controller collectClickFinished:data];
}

@end
