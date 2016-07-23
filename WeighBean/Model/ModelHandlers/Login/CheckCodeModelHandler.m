//
//  CheckCodeModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CheckCodeModelHandler.h"

@implementation CheckCodeModelHandler

- (id)initWithController:(HTBaseViewController<CheckCodeModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<CheckCodeModelProtocol> *controller = (HTBaseViewController<CheckCodeModelProtocol>*)self.controller;
  [controller checkCodeFinished:data];
}

@end
