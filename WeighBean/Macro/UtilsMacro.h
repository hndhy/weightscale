//
//  UtilsMacro.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#ifndef WeighBean_UtilsMacro_h
#define WeighBean_UtilsMacro_h

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIFontOfSize(s) [UIFont systemFontOfSize:s]
#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%d", intValue]
#define NSStringFromFloat(floatValue) [NSString stringWithFormat:@"%f", floatValue]
#define IsKindOfClass(_x, _class) ([_x isKindOfClass:[_class class]])
#define RespondsToSelector(_c, _m) ([_c respondsToSelector:_m])
#define ISEMPTY(_v) (_v == nil || _v.length == 0)
#define ISNull(_x)   ([_x isKindOfClass:[NSNull class]] || _x == nil)
#define HAVECONTROLLER(value) if(value == nil || value.controller == nil){return;}
#define ARRAY_VALUE(value) (value != nil && [value count] > 0)

#define APP_BLUE [UIColor colorWithRed:153.0f/255.0 green:209.0f/255.0 blue:234.0f/255.0 alpha:1]
#define APP_ORANGE [UIColor colorWithRed:249.0f/255.0 green:150.0f/255.0 blue:21.0f/255.0 alpha:1]
#define APP_RED [UIColor colorWithRed:223.0f/255.0 green:48.0f/255.0 blue:48.0f/255.0 alpha:1]
#define APP_GREEN [UIColor colorWithRed:71.0f/255.0 green:249.0f/255.0 blue:130.0f/255.0 alpha:1]
#define BLUECOLOR [UIColor colorWithRed:29/255.0 green:168/255.0 blue:225/255.0 alpha:1]

#define DEVICEW ([[UIScreen mainScreen] bounds].size.width)
#define DEVICEH ([[UIScreen mainScreen] bounds].size.height)


#endif
