//
//  UpdateInfoModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/23.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UpdateInfoModelHandler.h"

#import "UserResponse.h"

@implementation UpdateInfoModelHandler

- (id)initWithController:(HTBaseViewController<UpdateInfoModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<UpdateInfoModelProtocol> *controller = (HTBaseViewController<UpdateInfoModelProtocol>*)self.controller;
  [controller updateInfoFinished:(UserResponse *)data];
}

@end
