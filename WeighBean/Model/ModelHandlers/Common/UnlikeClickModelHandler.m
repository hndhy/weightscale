//
//  UnlickClickModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UnlikeClickModelHandler.h"

@implementation UnlikeClickModelHandler

- (id)initWithController:(HTBaseViewController<UnlikeClickModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<UnlikeClickModelProtocol> *controller = (HTBaseViewController<UnlikeClickModelProtocol>*)self.controller;
  [controller unlikeClickFinished:data];
}

@end
