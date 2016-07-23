//
//  AppMacro.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#ifndef WeighBean_AppMacro_h
#define WeighBean_AppMacro_h

//屏幕宽度
#define  SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define  SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
//去除状体栏的屏幕高度
#define  SCREEN_HEIGHT_EXCEPTSTATUS (SCREEN_HEIGHT - 20.0f)
//去除状体栏和顶部导航栏之后的屏幕高度
#define  SCREEN_HEIGHT_EXCEPTNAV (SCREEN_HEIGHT - 64.0f)
//去除状体栏,顶部导航栏和底部工具栏之后的屏幕高度
#define  SCREEN_HEIGHT_EXCEPTNAVANDTAB (SCREEN_HEIGHT - 114.0f)

//IOS7以上状态栏高度
#define   TOP_DICTANCE ((SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))?20:0)

//获取app版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_DELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define CachesPath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

#endif
