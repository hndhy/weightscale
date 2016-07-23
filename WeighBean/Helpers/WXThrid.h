//
//  WXThrid.h
//  UBoxOnline
//
//  Created by ubox  on 14-3-5.
//  Copyright (c) 2014年 liheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"

@protocol WXThridDelegate <NSObject>


@end

typedef void(^GetCodeBlock)(BOOL isComplete);
typedef void(^GetAccessTokenBlock)(BOOL isComplete);
typedef void(^GetUserInfoBlock)(BOOL isComplete);

typedef void(^GetPayAccessTokenBlock)(BOOL isComplete,NSString *token);
typedef void(^GetPrepayIDBlock)(BOOL isComplete,NSString *prepayid);
typedef void(^WXPayBlock)(NSInteger errorCode,NSString *errorStr);

@interface WXThrid : NSObject<WXApiDelegate>
{

}
@property (nonatomic,copy) NSDictionary *accessTokenDic;
@property (nonatomic,copy) NSDictionary *userInfoDic;
@property (nonatomic,copy) GetCodeBlock getCodeBlock;
@property (nonatomic,copy) GetAccessTokenBlock getAccessTokenBlock;
@property (nonatomic,copy) GetUserInfoBlock getUserInfoBlock;
@property (nonatomic,copy) GetPayAccessTokenBlock getPayAccessTokenBlock;
@property (nonatomic,copy) GetPrepayIDBlock getPrepayIDBlock;
@property (nonatomic,copy) WXPayBlock wXPayBlock;
@property (nonatomic,assign) BOOL isUserCancelWXPay;

+ (WXThrid *)defualtWXThrid;

+ (BOOL)isInstallationWithAlert:(BOOL)isAlert;

+ (BOOL)handleWXThridURL:(NSURL *)url;

+ (void)thridToGrantAuthorization;

- (void)getPayAccessToken;

- (void)getPrepayIDWithParamDic:(NSDictionary *)paramDic accessToken:(NSString *)token;

+ (void)payWithParamDic:(NSDictionary *)paramDic prepayID:(NSString *)prepayid;

+ (NSString *)SHA1:(NSString *)input;

+ (NSString *)sortSignString:(NSDictionary *)paramDic validForValue:(BOOL)isValid;

+ (BOOL)openWeXinClient;

- (void)showPayingAlert;
@end
/*
@interface WXPayAskServerView : UIView

+ (WXPayAskServerView *)askServerView;

@end
*/
