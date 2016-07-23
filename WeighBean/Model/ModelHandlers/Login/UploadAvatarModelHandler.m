//
//  UploadAvatarModelHandler.m
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UploadAvatarModelHandler.h"

@implementation UploadAvatarModelHandler

- (id)initWithController:(HTBaseViewController<UploadAvatarModelProtocol> *)controller
{
  return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
  [super dataDidLoad:sender data:data];
  HTBaseViewController<UploadAvatarModelProtocol> *controller = (HTBaseViewController<UploadAvatarModelProtocol>*)self.controller;
  [controller uploadAvatarFinished:(UploadAvatarResponse *)data];
}

@end
