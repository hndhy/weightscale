//
//  FindPwdModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "FindPwdModelHandler.h"

#import "UserResponse.h"

@implementation FindPwdModelHandler

- (id)initWithController:(HTBaseViewController<FindPwdModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<FindPwdModelProtocol> *controller = (HTBaseViewController<FindPwdModelProtocol>*)self.controller;
  [controller findPwdFinished:(UserResponse *)data];
}

@end
