//
//  UncollectClickModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UncollectClickModelHandler.h"

@implementation UncollectClickModelHandler

- (id)initWithController:(HTBaseViewController<UncollectClickModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<UncollectClickModelProtocol> *controller = (HTBaseViewController<UncollectClickModelProtocol>*)self.controller;
  [controller uncollectClickFinished:data];
}

@end
