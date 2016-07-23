//
//  RegisterModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "RegisterModelHandler.h"

#import "UserResponse.h"

@implementation RegisterModelHandler

- (id)initWithController:(HTBaseViewController<RegisterModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<RegisterModelProtocol> *controller = (HTBaseViewController<RegisterModelProtocol>*)self.controller;
  [controller registerFinished:(UserResponse *)data];
}

@end
