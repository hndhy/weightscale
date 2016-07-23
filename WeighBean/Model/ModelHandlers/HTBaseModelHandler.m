//
//  HTBaseModelHandler.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@implementation HTBaseModelHandler

- (id)initWithController:(HTBaseViewController*)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

#pragma mark - HTDataSourceDelegate
- (void)dataDidLoad:(id)sender data:(BaseResponse *)data
{
  [self.controller hideHUD];
}

- (void)netError:(id)sender error:(NSError *)error
{
  [self.controller hideHUD];
  [self.controller alert:@"网络出错"
      message:@"网络请求失败，请检查网络或稍后再试。"
     delegate:nil
  cancelTitle:@"确定"
  otherTitles:nil];
//  [self handleError:sender error:error];
}

- (void)parseError:(id)sender error:(NSError *)error
{
  [self.controller hideHUD];
  [self.controller alert:@"数据出错"
      message:@"解析返回数据失败，请稍后再试。"
     delegate:nil
  cancelTitle:@"确定"
  otherTitles:nil];
//  [self handleError:sender error:error];
}

- (void)resultError:(id)sender data:(BaseResponse *)data
{
  [self.controller hideHUD];
  [self handleError:sender error:[NSError errorWithDomain:data.msg code:data.status userInfo:nil]];
}

- (void)handleError:(id)sender error:(NSError *)error
{
  [self.controller handleModelError:sender error:error];
}

@end
