//
//  CheckTelAndNickModelHandler.m
//  WeighBean
//
//  Created by liumadu on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "CheckTelAndNickModelHandler.h"

@implementation CheckTelAndNickModelHandler

- (id)initWithController:(HTBaseViewController<CheckInfoModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<CheckInfoModelProtocol> *controller = (HTBaseViewController<CheckInfoModelProtocol>*)self.controller;
  [controller checkInfoFinished:data];
}

@end
