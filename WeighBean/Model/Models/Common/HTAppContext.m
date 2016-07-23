//
//  HTAppContext.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAppContext.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import <UICKeyChainStore.h>

static NSString *const HTUserDataGuideRun = @"guiderun%@";
static NSString *const HTAppContextUid = @"uid";
static NSString *const HTAppContextNick = @"nick";
static NSString *const HTAppContextAvatar = @"avatar";
static NSString *const HTAppContextCityName = @"city_name";
static NSString *const HTAppContextCityLetter = @"city_letter";
static NSString *const HTAppContextAds = @"ads";
static NSString *const HTAppContextHome = @"home";
static NSString *const HTAppContextDevice = @"hyd_user_device";

static NSString *const HTAppContextWiFi = @"hyd_wifi_isopen";
static NSString *const HTAppContextMessageCount = @"messageCount";

@implementation HTAppContext

- (id)init
{
  self = [super init];
  if (self) {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.uid = [prefs stringForKey:HTAppContextUid];
    self.nick = [prefs stringForKey:HTAppContextNick];
    self.avatar = [prefs stringForKey:HTAppContextAvatar];
    NSString *guiderRunKey = [NSString stringWithFormat:HTUserDataGuideRun, APP_VERSION];
    self.guideRun = [prefs boolForKey:guiderRunKey];
    self.ads = [UICKeyChainStore stringForKey:HTAppContextAds];
    self.home = [UICKeyChainStore stringForKey:HTAppContextHome];
    NSString *tmpDevice = [UICKeyChainStore stringForKey:HTAppContextDevice];
    if (ISEMPTY(tmpDevice)) {
      self.device = @"";
    } else {
      self.device = tmpDevice;
    }
    NSString *isOpen = [prefs objectForKey:HTAppContextWiFi];
      if (isOpen&&isOpen.length)
      {
          self.isOpenWiFi = [isOpen boolValue];
      }
    NSString *messageCount = [prefs objectForKey:HTAppContextMessageCount];
      self.messageCount = messageCount;
  }
  return self;
}

+ (instancetype)sharedContext
{
  static HTAppContext *_sharedContext = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedContext = [[HTAppContext alloc] init];
  });
  return _sharedContext;
}

- (void)save
{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  if (!ISEMPTY(self.uid)) {
    [prefs setObject:self.uid forKey:HTAppContextUid];
  }
  if (!ISEMPTY(self.nick)) {
    [prefs setObject:self.nick forKey:HTAppContextNick];
  }
  if (!ISEMPTY(self.avatar)) {
    [prefs setObject:self.avatar forKey:HTAppContextAvatar];
  }
  NSString* guiderRunKey = [NSString stringWithFormat:HTUserDataGuideRun, APP_VERSION];
  [prefs setBool:self.guideRun forKey:guiderRunKey];
    
    if (!ISEMPTY(self.messageCount)) {
        [prefs setObject:self.messageCount forKey:HTAppContextMessageCount];
    }
    
  [prefs synchronize];
}

- (void)saveAdsInfo
{
  if (!ISEMPTY(self.ads)) {
    [UICKeyChainStore setString:self.ads forKey:HTAppContextAds];
  }
}

- (void)saveDevice
{
  if (!ISEMPTY(self.device)) {
    [UICKeyChainStore setString:self.device forKey:HTAppContextDevice];
  }
}

- (void)saveHomeInfo
{
  if (!ISEMPTY(self.home)) {
    [UICKeyChainStore setString:self.home forKey:HTAppContextHome];
  }
}

- (void)saveIsOpen
{
    NSString *isOpenStr = [[NSString alloc] initWithFormat:@"%d",self.isOpenWiFi];
    [[NSUserDefaults standardUserDefaults] setObject:isOpenStr forKey:HTAppContextWiFi];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)openString
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:HTAppContextWiFi];
}

- (void)clear
{
  // 删除用户UID记录
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  [prefs removeObjectForKey:HTAppContextUid];
  self.uid = nil;
  [prefs removeObjectForKey:HTAppContextNick];
  self.nick = nil;
  [prefs removeObjectForKey:HTAppContextAvatar];
  self.avatar = nil;
    [prefs removeObjectForKey:HTAppContextMessageCount];
    self.messageCount = nil;
}

+ (BOOL)isLogin
{
  HTAppContext *appContext = [HTAppContext sharedContext];
  return !ISEMPTY(appContext.uid);
}

@end
