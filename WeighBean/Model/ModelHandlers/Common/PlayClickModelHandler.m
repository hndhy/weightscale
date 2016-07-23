//
//  PlayClickModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/7/1.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "PlayClickModelHandler.h"

@implementation PlayClickModelHandler

- (id)initWithController:(HTBaseViewController<PlayClickModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<PlayClickModelProtocol> *controller = (HTBaseViewController<PlayClickModelProtocol>*)self.controller;
  [controller playClickFinished:data];
}

@end
