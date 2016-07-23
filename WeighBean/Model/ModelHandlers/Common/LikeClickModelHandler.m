//
//  LikeClickModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "LikeClickModelHandler.h"

@implementation LikeClickModelHandler

- (id)initWithController:(HTBaseViewController<LikeClickModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<LikeClickModelProtocol> *controller = (HTBaseViewController<LikeClickModelProtocol>*)self.controller;
  [controller likeClickFinished:data];
}

@end
