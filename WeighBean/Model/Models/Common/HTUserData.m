//
//  HTUserData.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTUserData.h"

#import "CommonHelper.h"

NSString *const HTUserDataUserId = @"hyd_user_id";
NSString *const HTUserDataAvatarUrl = @"hyd_avatar_url";
NSString *const HTUserDataNickname = @"hyd_user_nickname";
NSString *const HTUserDataPhone = @"hyd_user_phone";
NSString *const HTUserDataAge = @"hyd_user_age";
NSString *const HTUserDataBirthday = @"hyd_user_birthday";
NSString *const HTUserDataCoachTel = @"hyd_coach_tel";
NSString *const HTUserDataHeight = @"hyd_user_height";
NSString *const HTUserDataIsCoach = @"hyd_is_coach";
NSString *const HTUserDataSex = @"hyd_user_sex";
NSString *const HTUserIsFresh = @"hyd_user_isFresh";
@implementation HTUserData

- (id)init
{
  self = [super init];
  if (self) {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.uid = [prefs stringForKey:HTUserDataUserId];
    self.avatar = [prefs stringForKey:HTUserDataAvatarUrl];
    self.nick = [prefs stringForKey:HTUserDataNickname];
    self.tel = [prefs stringForKey:HTUserDataPhone];
    self.age = (int)[prefs integerForKey:HTUserDataAge];
    self.birthday = [prefs stringForKey:HTUserDataBirthday];
    self.coachTel = [prefs stringForKey:HTUserDataCoachTel];
    self.height = (int)[prefs integerForKey:HTUserDataHeight];
    self.isCoach = [prefs boolForKey:HTUserDataIsCoach];
    self.sex = (int)[prefs integerForKey:HTUserDataSex];
      self.isFresh = (int)[prefs integerForKey:HTUserIsFresh];
  }
  return self;
}

+ (instancetype)sharedInstance
{
  static HTUserData *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[HTUserData alloc] init];
  });
  return _sharedInstance;
}

- (void)save
{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  [prefs setObject:self.uid forKey:HTUserDataUserId];
  [prefs setObject:self.avatar forKey:HTUserDataAvatarUrl];
  [prefs setObject:self.nick forKey:HTUserDataNickname];
  [prefs setInteger:self.age forKey:HTUserDataAge];
  [prefs setObject:self.birthday forKey:HTUserDataBirthday];
  [prefs setObject:self.coachTel forKey:HTUserDataCoachTel];
  [prefs setInteger:self.height forKey:HTUserDataHeight];
  [prefs setBool:self.isCoach forKey:HTUserDataIsCoach];
  [prefs setInteger:self.sex forKey:HTUserDataSex];
    [prefs setInteger:self.isFresh forKey:HTUserIsFresh];
  [prefs synchronize];
}

- (NSString *)requestCode
{
  NSMutableString *mStr = [[NSMutableString alloc] init];
  [mStr appendString:@"EB9002320401"];
  int tmpAge = self.age;
  if (0 == self.sex) {
    tmpAge = self.age + 128;
  }
  NSString *ageStr = [CommonHelper DecToHex2:tmpAge];
  [mStr appendString:ageStr];
  NSString *tmpHeight = [CommonHelper DecToHex4:self.height * 10];
  NSString *tmpHeight1 = [tmpHeight substringToIndex:2];
  NSString *tmpHeight2 = [tmpHeight substringFromIndex:2];
  [mStr appendString:tmpHeight2];
  [mStr appendString:tmpHeight1];
  int sum = 1 + tmpAge + [CommonHelper HexToDec:tmpHeight1] + [CommonHelper HexToDec:tmpHeight2];
  NSString *sumStr = [CommonHelper DecToHex4:sum];
  NSString *sumStr1 = [sumStr substringToIndex:2];
  NSString *sumStr2 = [sumStr substringFromIndex:2];
  [mStr appendFormat:@"%@%@", sumStr2, sumStr1];
  [mStr appendString:@"03"];
  return mStr;
}

@end

@implementation Userinfo

@end

