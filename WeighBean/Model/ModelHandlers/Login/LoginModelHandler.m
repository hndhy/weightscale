//
//  LoginModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "LoginModelHandler.h"

#import "UserResponse.h"

@implementation LoginModelHandler

- (id)initWithController:(HTBaseViewController<LoginModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<LoginModelProtocol> *controller = (HTBaseViewController<LoginModelProtocol>*)self.controller;
  [controller loginFinished:(UserResponse *)data];
}

@end
