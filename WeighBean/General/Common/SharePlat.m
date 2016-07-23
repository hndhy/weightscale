//
//  SharePlat.m
//  WeighBean
//
//  Created by liumadu on 15/8/9.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "SharePlat.h"

#import <ShareSDK/ShareSDK.h>
#import "UIView+Ext.h"
#import "UILabel+Ext.h"
#import "UtilsMacro.h"

static const NSTimeInterval kAnimationDuration = 0.33;
static const int kViewTag = 1024;
static const int kShareViewTag = 1025;

@interface SharePlat ()

@property (nonatomic, strong) UIImage *screenImage;

@end

@implementation SharePlat

+ (instancetype)sharedInstance
{
  static SharePlat *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SharePlat alloc] init];
  });
  _sharedInstance.showTrend = NO;
  return _sharedInstance;
}

- (void)showShareActionSheet
{
  UIView *view = [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] subviews] lastObject];
  UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  self.screenImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  [self showShareView];
}

//显示弹出框
- (void)showShareView
{
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  UIView *view = [[UIView alloc] initWithFrame:window.frame];
  [view addTapCallBack:self sel:@selector(hideShareView)];
  view.tag = kViewTag;
  view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
  [window addSubview:view];
  UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, view.height, view.width, 0)];
  shareView.tag = kShareViewTag;
  shareView.backgroundColor = [UIColor whiteColor];
  [view addSubview:shareView];
  UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(29.0f, 0, shareView.width - 29.0f, 29.0f)
                                             withSize:12.0f withColor:UIColorFromRGB(108.0f, 108.0f, 108.0f)];
  titleLabel.text = @"分享当前测试结果";
  [shareView addSubview:titleLabel];
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(27.0f, titleLabel.bottom, shareView.width - 54.0f, 0.5f)];
  lineView.backgroundColor = UIColorFromRGB(239.0f, 239.0f, 239.0f);
  [shareView addSubview:lineView];
  CGFloat margin = (lineView.width - 3 * 52.0f) / 2.0f;
  UIView *smsView = [self createShareItem:lineView.left top:lineView.bottom icon:@"sms_icon.png" title:@"信息"];
  [smsView addTapCallBack:self sel:@selector(onSmsClick:)];
  [shareView addSubview:smsView];
  UIView *wechatView = [self createShareItem:smsView.right + margin top:lineView.bottom icon:@"wechat_icon.png" title:@"微信"];
  [wechatView addTapCallBack:self sel:@selector(onWechatClick:)];
  [shareView addSubview:wechatView];
  UIView *friendView = [self createShareItem:wechatView.right + margin top:lineView.bottom icon:@"friend_icon.png" title:@"朋友圈"];
  [friendView addTapCallBack:self sel:@selector(sendTimelineClick:)];
  [shareView addSubview:friendView];
  CGFloat top = friendView.bottom;
  if (self.showTrend) {
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, top, shareView.width, 0.5f)];
    lineView.backgroundColor = UIColorFromRGB(239.0f, 239.0f, 239.0f);
    [shareView addSubview:lineView];
    UILabel *trendLabel = [UILabel createLabelWithFrame:CGRectMake(0, lineView.bottom, lineView.width, 45.0f)
                                               withSize:16.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
    trendLabel.textAlignment = NSTextAlignmentCenter;
    trendLabel.text = @"分享阶段趋势";
    [trendLabel addTapCallBack:self sel:@selector(onTrendClick:)];
    [shareView addSubview:trendLabel];
    top = trendLabel.bottom;
  }
  lineView = [[UIView alloc] initWithFrame:CGRectMake(0, top, shareView.width, 5.0f)];
  lineView.backgroundColor = UIColorFromRGB(239.0f, 239.0f, 239.0f);
  [shareView addSubview:lineView];
  UILabel *cancelLabel = [UILabel createLabelWithFrame:CGRectMake(0, lineView.bottom, lineView.width, 45.0f)
                                             withSize:16.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  cancelLabel.textAlignment = NSTextAlignmentCenter;
  cancelLabel.text = @"取消";
  [shareView addSubview:cancelLabel];
  shareView.height = cancelLabel.bottom;
  [UIView animateWithDuration:kAnimationDuration * 0.8
                        delay:kAnimationDuration * 0.2
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone
                   animations:^{
                     shareView.top = view.height - shareView.height;
                   }
                   completion:NULL];
}

- (UIView *)createShareItem:(CGFloat)left top:(CGFloat)top icon:(NSString *)icon title:(NSString *)title
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(left, top, 52.0f, 92.0f)];
  UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13.0f, 52.0f, 52.0f)];
  iconImageView.image = [UIImage imageNamed:icon];
  [view addSubview:iconImageView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(0, iconImageView.bottom + 6.0f, view.width, 15.0f)
                                        withSize:12.0f withColor:UIColorFromRGB(11.0f, 11.0f, 11.0f)];
  label.textAlignment = NSTextAlignmentCenter;
  label.text = title;
  [view addSubview:label];
  return view;
}

- (void)hideShareView
{
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  UIView *view = [window viewWithTag:kViewTag];
  UIView *shareView = [view viewWithTag:kShareViewTag];
  [UIView animateWithDuration:kAnimationDuration * 0.8
                        delay:kAnimationDuration * 0.2
                      options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone
                   animations:^{
                     shareView.top = view.bottom;
                   }
                   completion:^(BOOL finished) {
                     [self removeView];
                   }];
}

- (void)removeView
{
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  UIView *view = [window viewWithTag:kViewTag];
  [view removeFromSuperview];
}

- (void)onTrendClick:(id)sender
{
  [self hideShareView];
  if (self.delegate) {
    [self.delegate gotoTrend];
  }
}

- (void)onSmsClick:(id)sender
{
  [self hideShareView];
  if (self.delegate) {
    [self.delegate sendSMS:self.screenImage];
  }
}

- (void)onWechatClick:(id)sender
{
  [self hideShareView];
  id<ISSContent> content = [ShareSDK content:nil
                              defaultContent:nil
                                       image:[ShareSDK jpegImageWithImage:self.screenImage quality:1]
                                       title:nil
                                         url:nil
                                 description:nil
                                   mediaType:SSPublishContentMediaTypeImage];
  id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                       allowCallback:YES
                                                       authViewStyle:SSAuthViewStyleFullScreenPopup
                                                        viewDelegate:nil
                                             authManagerViewDelegate:nil];
  [ShareSDK shareContent:content
                    type:ShareTypeWeixiSession
             authOptions:authOptions
           statusBarTips:YES
                  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                    if (state == SSPublishContentStateSuccess)
                      {
                      NSLog(@"success");
                      }
                    else if (state == SSPublishContentStateFail)
                      {
                      if ([error errorCode] == -22003)
                        {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                            message:[error errorDescription]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"知道了"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                        }
                      }
                  }];
}

- (void)sendTimelineClick:(id)sender
{
  [self hideShareView];
  //发送内容给微信
  id<ISSContent> content = [ShareSDK content:nil
                              defaultContent:nil
                                       image:[ShareSDK jpegImageWithImage:self.screenImage quality:1]
                                       title:nil
                                         url:nil
                                 description:nil
                                   mediaType:SSPublishContentMediaTypeImage];
  
  id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                       allowCallback:YES
                                                       authViewStyle:SSAuthViewStyleFullScreenPopup
                                                        viewDelegate:nil
                                             authManagerViewDelegate:nil];
  [ShareSDK shareContent:content
                    type:ShareTypeWeixiTimeline
             authOptions:authOptions
           statusBarTips:YES
                  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                    
                    if (state == SSPublishContentStateSuccess)
                      {
                      NSLog(@"success");
                      }
                    else if (state == SSPublishContentStateFail)
                      {
                      if ([error errorCode] == -22003)
                        {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                            message:[error errorDescription]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"知道了"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                        }
                      }
                  }];
}

@end
