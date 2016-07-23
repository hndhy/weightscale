//
//  WXThrid.m
//  UBoxOnline
//
//  Created by ubox  on 14-3-5.
//  Copyright (c) 2014年 liheng. All rights reserved.
//

#import "WXThrid.h"
#import <CommonCrypto/CommonCrypto.h>
#import <AFNetworking/AFNetworking.h>
#import "JSONKit.h"

#define SHA1KEYLENGTH  20

// 从服务取数据上线要删除

#define K_WEIXIN_PARTNER_KEY @"ab377f73406ee64613ffb64403a06c62"
#define K_WEIXIN_PARTNER_ID @"1216845601"

#define K_WEIXIN_APP_ID @""
#define K_WEIXIN_APP_SECRET @""
#define K_WEIXIN_APP_KEY @""

@implementation WXThrid

static WXThrid *delualtWXThrid = nil;

- (void)dealloc
{
    self.getAccessTokenBlock = nil;
    self.getCodeBlock = nil;
    self.getPayAccessTokenBlock = nil;
    self.getPrepayIDBlock = nil;
    self.getUserInfoBlock = nil;
    self.wXPayBlock = nil;
    self.userInfoDic = nil;
    self.accessTokenDic = nil;
}

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

- (void)showPayingAlert
{
//    WXPayingView *alert = [WXPayingView showAlertViewWithTitle:@"温馨提示" message:@"您尚未在微信中完成支付，如果取消支付，请不要在微信中输入支付密码" delegate:nil cancelButton:@"取消支付" defaultButton:@"继续支付"];
//    [alert showWithCompleteBlock:^(NSInteger btnIndex) {
//        if (btnIndex == 1)
//        {
//            [WXThrid openWeXinClient];
//        }
//        else if (btnIndex == 0)
//        {
//            self.isUserCancelWXPay = YES;
//        }
//    }];
}

+ (BOOL)openWeXinClient
{
    return [WXApi openWXApp];
}

+ (WXThrid *)defualtWXThrid
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        delualtWXThrid = [[WXThrid alloc] init];
    });
    return delualtWXThrid;
}

// 从微信唤起友宝处理回调- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
+ (BOOL)handleWXThridURL:(NSURL *)url
{
   return [WXApi handleOpenURL:url delegate:[WXThrid defualtWXThrid]];
}

+ (BOOL)isInstallationWithAlert:(BOOL)isAlert
{
    if (isAlert&&![WXApi isWXAppInstalled])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您没有安装微信，请下载后使用"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    return [WXApi isWXAppInstalled];
}

// 来自微信回调
- (void)onResp:(BaseResp *)resp
{
    // 支付
    if ([resp isKindOfClass:[PayResp class]])
    {
//        [WXPayingView cancelWXPayingView];
        PayResp *payResp = (PayResp *)resp;
        NSLog(@"微信SDK %d %@  %d  returnKey = %@",payResp.errCode,payResp.errStr,payResp.type,payResp.returnKey);
        if (self.wXPayBlock && !self.isUserCancelWXPay) {
            self.wXPayBlock(payResp.errCode,payResp.errStr);
        }
    }
    // 授权
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        
        NSLog(@"微信SDK %@ errorCode = %d",authResp.code,authResp.errCode);
        
        if (authResp.code.length && authResp.errCode == WXSuccess)
        {
            if (self.getCodeBlock) {
                self.getCodeBlock(YES);
            }
            [self getAccessTokenWithCode:authResp.code];
        }
        else
        {
            if (self.getCodeBlock) {
                self.getCodeBlock(NO);
            }
        }
    }
}

// 唤起微信授权页面
+ (void)thridToGrantAuthorization
{
//    [UStaticData saveObject:@"1" forKey:KTagToWXViewController];
    SendAuthReq * req = [[SendAuthReq alloc] init];
    req.openID = K_WEIXIN_APP_ID;
    req.scope = @"snsapi_userinfo";
    req.state = @"weixin_login";
    [WXApi sendReq:req];
}

// 获取token及相关信息
- (void)getAccessTokenWithCode:(NSString *)code
{
    NSString *appSecret = K_WEIXIN_APP_SECRET;
    NSString *domain = @"https://api.weixin.qq.com";
    NSString *interface = @"/sns/oauth2/access_token?";
    NSString *params = [NSString stringWithFormat:@"appid=%@&secret=%@&code=%@&grant_type=%@",K_WEIXIN_APP_ID,appSecret,code,@"authorization_code"];

    NSURL *baseUrl = [NSURL URLWithString:domain];
    NSString *path = [NSString stringWithFormat:@"%@%@",interface,params];
    AFHTTPRequestOperationManager *man = [[AFHTTPRequestOperationManager manager] initWithBaseURL:baseUrl];
    [man POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [operation.responseData objectFromJSONData];
        NSLog(@"access_token及相关信息请求结果\n success : %@",dic);
        NSString *accessToken = [dic objectForKey:@"access_token"];
        NSString *openId = [dic objectForKey:@"openid"];
        if ([accessToken isKindOfClass:[NSString class]] && accessToken.length
            &&[openId isKindOfClass:[NSString class]] && openId.length)
        {
            if (dic)
            {
                self.accessTokenDic = dic;
            }
            if (self.getAccessTokenBlock) {
                self.getAccessTokenBlock(YES);
            }
            [self getUserInfoWithAccessToken:accessToken openId:openId];
        }
        else
        {
            if (self.getAccessTokenBlock) {
                self.getAccessTokenBlock(NO);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.getAccessTokenBlock) {
            self.getAccessTokenBlock(NO);
        }
        NSLog(@"access_token及相关信息请求结果\nfail : %@",error);
    }];
    
    NSLog(@"access_token及相关信息请求\nURL = %@%@ \nGET参数%@",domain,interface,params);
}

// 获取用户信息
- (void)getUserInfoWithAccessToken:(NSString *)token openId:(NSString *)openid
{
    NSString *domain = @"https://api.weixin.qq.com";
    NSString *interface = @"/sns/userinfo?";
    NSString *params = [NSString stringWithFormat:@"access_token=%@&openid=%@",token,openid];
    
    NSURL *baseUrl = [NSURL URLWithString:domain];
    NSString *path = [NSString stringWithFormat:@"%@%@",interface,params];
    AFHTTPRequestOperationManager *man = [[AFHTTPRequestOperationManager manager] initWithBaseURL:baseUrl];
    [man POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [operation.responseData objectFromJSONData];
        if (dic)
        {
            self.userInfoDic = dic;
            if (self.getUserInfoBlock) {
                self.getUserInfoBlock(YES);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.getUserInfoBlock) {
            self.getUserInfoBlock(NO);
        }
        NSLog(@"access_token及相关信息请求结果\nfail : %@",error);
    }];
    
    NSLog(@"微信用户信息请求\nURL = %@%@ \nGET参数%@",domain,interface,params);
}

- (void)getPayAccessToken
{
    NSString *appSecret = K_WEIXIN_APP_SECRET;
    NSString *domain = @"https://api.weixin.qq.com";
    NSString *interface = @"/cgi-bin/token?";
    NSString *params = [NSString stringWithFormat:@"grant_type=%@&appid=%@&secret=%@",@"client_credential",K_WEIXIN_APP_ID,appSecret];
    
    NSURL *baseUrl = [NSURL URLWithString:domain];
    NSString *path = [NSString stringWithFormat:@"%@%@",interface,params];
    AFHTTPRequestOperationManager *man = [[AFHTTPRequestOperationManager manager] initWithBaseURL:baseUrl];
    [man POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [operation.responseData objectFromJSONData];
        NSString *accessToken = [dic objectForKey:@"access_token"];
        if ([accessToken isKindOfClass:[NSString class]] && accessToken.length)
        {
            if (self.getPayAccessTokenBlock) {
                self.getPayAccessTokenBlock(YES,accessToken);
            }
            [self buildRequestPrepayidWithAccessToken:accessToken];
        }
        else
        {
            if (self.getPayAccessTokenBlock) {
                self.getPayAccessTokenBlock(NO,@"token nil");
            }
        }
        //NSLog(@"支付token请求结果\n success : %@",request.parsedDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.getPayAccessTokenBlock) {
            self.getPayAccessTokenBlock(NO,@"request fail");
        }
        //NSLog(@"支付token请求结果\n fail : %@",request.parsedDict);
    }];
    //NSLog(@"支付token请求\nURL = %@%@ \nGET参数%@",domain,interface,params);
}

- (void)getPrepayIDWithParamDic:(NSDictionary *)paramDic accessToken:(NSString *)token
{
    NSString *domain = @"https://api.weixin.qq.com";
    NSString *interface = @"/pay/genprepay?";
    NSString *getParam = [NSString stringWithFormat:@"access_token=%@",token];
    NSURL * WXUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",domain,interface,getParam]];
    
    if ([NSJSONSerialization isValidJSONObject:paramDic])
    {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:paramDic options:NSJSONWritingPrettyPrinted error:&error];

        NSURL *baseUrl = [NSURL URLWithString:domain];

        AFHTTPRequestOperationManager *man = [[AFHTTPRequestOperationManager manager] initWithBaseURL:baseUrl];
    
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:WXUrl];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:data];
        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [req setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
        
        AFHTTPRequestOperation *operat = [man HTTPRequestOperationWithRequest:req success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [operation.responseData objectFromJSONData];
            NSLog(@"prepayId请求结果\n success : %@",dic);
            NSString *prepayid = [dic objectForKey:@"prepayid"];
            if ([prepayid isKindOfClass:[NSString class]] && prepayid.length)
            {
                if (self.getPrepayIDBlock) {
                    self.getPrepayIDBlock(YES,prepayid);
                }
                // 本地测试代码
                [self bulidRequestPayWithprepayID:prepayid];
            }
            else
            {
                if (self.getPrepayIDBlock) {
                    self.getPrepayIDBlock(NO,@"prepayid nil");
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (self.getPrepayIDBlock) {
                self.getPrepayIDBlock(NO,@"request fail");
            }
            NSLog(@"prepayId请求结果\n fail : %@",error);
        }];
        [man.operationQueue addOperation:operat];
        [operat start];
        
        //NSLog(@"prepayId 请求\n 的URL = %@%@",domain,interface);
        //NSLog(@"prepayId 请求\n GET参数 = %@",getParam);
        //NSLog(@"prepayId 请求\n POST参数 = %@",[paramDic JSONString]);
    }
}

+ (void)payWithParamDic:(NSDictionary *)paramDic prepayID:(NSString *)prepayid
{
    [[WXThrid defualtWXThrid] performSelector:@selector(showPayingAlert) withObject:nil afterDelay:0.5];
    [WXThrid defualtWXThrid].isUserCancelWXPay = NO;
    PayReq *payRequst = [[PayReq alloc] init] ;
    payRequst.partnerId = [paramDic objectForKey:@"partnerid"];
    payRequst.prepayId = prepayid;
    payRequst.package = @"Sign=WXPay";
    payRequst.nonceStr = [paramDic objectForKey:@"noncestr"];
    payRequst.timeStamp = (UInt32)[[paramDic objectForKey:@"timestamp"] integerValue];
    payRequst.sign = [paramDic objectForKey:@"sign"];
    [WXApi sendReq:payRequst];
}

/*跑整个流程所需要从服务拿到签名、参数方法*/

- (void)buildRequestPrepayidWithAccessToken:(NSString *)token
{
    NSString *noncestr = [self buildNoncestr];
    NSString *packageStr = [self getPackageStringWithCommodity];
    //NSLog(@"packageStr = %@",packageStr);
   
    NSString *temStamp = [WXThrid timeStamp];
    NSString *appKey = K_WEIXIN_APP_KEY;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:K_WEIXIN_APP_ID forKey:@"appid"];
    [params setObject:appKey forKey:@"appkey"];
    [params setObject:noncestr forKey:@"noncestr"];
    [params setObject:packageStr forKey:@"package"];
    [params setObject:temStamp forKey:@"timestamp"];
    [params setObject:@"crestxu_1393484011" forKey:@"traceid"];
    
    NSString *sign = [WXThrid SHA1:[WXThrid sortSignString:params validForValue:NO]];
    [params setValue:sign forKey:@"app_signature"];
    [params setValue:@"sha1" forKey:@"sign_method"];
    
    [self getPrepayIDWithParamDic:params accessToken:token];
}

- (void)bulidRequestPayWithprepayID:(NSString *)prepayid
{
    NSString *noncestr = [self buildNoncestr];
    NSString *temStamp = [WXThrid timeStamp];
    NSString *appKey = K_WEIXIN_APP_KEY;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:K_WEIXIN_APP_ID forKey:@"appid"];
    [params setObject:appKey forKey:@"appkey"];
    [params setObject:noncestr forKey:@"noncestr"];
    [params setObject:@"Sign=WXPay" forKey:@"package"];
    [params setObject:K_WEIXIN_PARTNER_ID forKey:@"partnerid"];
    [params setObject:prepayid forKey:@"prepayid"];
    [params setObject:temStamp forKey:@"timestamp"];
    
    NSString *sign = [WXThrid SHA1:[WXThrid sortSignString:params validForValue:NO]];
    [params setValue:sign forKey:@"app_signature"];
    
    [WXThrid payWithParamDic:params prepayID:prepayid];
}

- (NSString *)buildNoncestr
{
    NSMutableString *randomStr = [NSMutableString string];
    for (int i = 0; i < 8; i ++)
    {
        NSInteger randomInteger = arc4random()%10000;
        [randomStr  appendString:[NSString stringWithFormat:@"%d",randomInteger]];
    }
    return randomStr;
}

+ (NSDictionary *)commodityDic
{
    NSMutableDictionary *commodityDic = [NSMutableDictionary dictionary];
    [commodityDic setObject:@"WX" forKey:@"bank_type"];
    [commodityDic setObject:@"千足金箍棒" forKey:@"body"];
    [commodityDic setObject:@"1" forKey:@"fee_type"];
    [commodityDic setObject:@"UTF-8" forKey:@"input_charset"];
    [commodityDic setObject:@"http://monk.dev.uboxol.com/weixin_notify" forKey:@"notify_url"];
    [commodityDic setObject:@"1216845606" forKey:@"out_trade_no"];
    [commodityDic setObject:K_WEIXIN_PARTNER_ID forKey:@"partner"];
    [commodityDic setObject:@"192.168.1.1" forKey:@"spbill_create_ip"];
    [commodityDic setObject:@"1" forKey:@"total_fee"];
    
    return commodityDic;
}

// 生成package
- (NSString *)getPackageStringWithCommodity
{
    NSDictionary *commDic = [WXThrid commodityDic];
    // 生成sing
    NSMutableString * package = [NSMutableString string];
    [package setString:[WXThrid sortSignString:commDic validForValue:NO]];
    [package appendString:[NSString stringWithFormat:@"&key=%@",K_WEIXIN_PARTNER_KEY]];
    NSString * signedString = [[WXThrid md5:package] uppercaseString];
    // 生成packagecode
    NSMutableString *packageEncode = [NSMutableString string];
    [packageEncode setString:[WXThrid sortSignString:commDic validForValue:YES]];
    
    return [NSString stringWithFormat:@"%@&sign=%@",packageEncode,signedString];
}

// 参数合法化
+ (NSString *)validStringForValue:(NSString *)value
{
    NSString *str = value;
    if ([str length]) {
        NSString *enCodeParam = nil;
        
        NSMutableString *tmpParam = [[NSMutableString alloc] init];
        [tmpParam setString:str];
        for (int i = 0; i < tmpParam.length; i++) {
            if ([tmpParam rangeOfString:@" "].location != NSNotFound) {
                [tmpParam replaceCharactersInRange:[tmpParam rangeOfString:@" "] withString:@"%20"];
            }
        }
        
        if ([tmpParam rangeOfString:@":"].location != NSNotFound) { //字符串中包含:符号
            enCodeParam = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                              (CFStringRef)tmpParam,
                                                                              NULL,
                                                                              (CFStringRef)@":@",
                                                                              kCFStringEncodingUTF8));
            
            
        } else if ([tmpParam rangeOfString:@"@"].location != NSNotFound) { //字符串中包含@符号
            enCodeParam = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                              (CFStringRef)tmpParam,
                                                                              NULL,
                                                                              (CFStringRef)@"@@",
                                                                              kCFStringEncodingUTF8));
            
        } else if ([tmpParam rangeOfString:@","].location != NSNotFound) { //字符串中包含@符号
            enCodeParam = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                              (CFStringRef)tmpParam,
                                                                              NULL,
                                                                              (CFStringRef)@",@",
                                                                              kCFStringEncodingUTF8));
        }
        else {
            enCodeParam = [tmpParam stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        return enCodeParam;
    }
    else {
        return @"";
    }
}

// 排序生成key1=value1&key2=value2
+ (NSString *)sortSignString:(NSDictionary *)paramDic validForValue:(BOOL)isValid
{
    NSArray *sortArray = [[paramDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableString *tempStr = [NSMutableString stringWithCapacity:10];
    for (int i = 0; i < sortArray.count ; i++)
    {
        NSString *key = [sortArray objectAtIndex:i];
        NSString *value = [paramDic objectForKey:key];
        [tempStr appendString:key.description];
        [tempStr appendString:@"="];
        [tempStr appendString:isValid ? [WXThrid validStringForValue:value].description : value.description];
        if (i != sortArray.count-1)
        [tempStr appendString:@"&"];
    }
    return tempStr;
}

// sha1签名
+ (NSString *)SHA1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[SHA1KEYLENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:SHA1KEYLENGTH * 2];
    
    for(int i=0; i<SHA1KEYLENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

// 获取当前的时间戳
+ (NSString*)timeStamp
{
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"%ld",(unsigned long)[now timeIntervalSince1970]];
}

// 返回String的MD5
+ (NSString *) md5:(NSString *)old
{
    const char *cStr = [old UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH] = "";
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
/*
@implementation WXPayAskServerView

+ (WXPayAskServerView *)askServerView
{
    WXPayAskServerView *wxp = [[WXPayAskServerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [APP_DELEGATE.window addSubview:wxp];
    return [wxp autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UIView *backageView = [[UIView alloc] initWithFrame:CGRectMake(25, (CGRectGetHeight(frame) - 186)/2, 270, 186)];
        backageView.backgroundColor = [UIColor whiteColor];
        backageView.layer.cornerRadius = 5;
        [self addSubview:backageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 230, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = KFontSizeTitleA_B;
        titleLabel.textColor = KFontColorA;
        titleLabel.text = @"确认支付中...";
        titleLabel.backgroundColor = [UIColor clearColor];
        [backageView addSubview:titleLabel];
        [titleLabel release];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 250, 20)];
        message.textAlignment = NSTextAlignmentCenter;
        message.font = KFontSizeTitleC;
        message.textColor = KFontColorD;
        message.text = @"绑定手机号，用友宝钱包支付更快捷";
        message.backgroundColor = [UIColor clearColor];
        [backageView addSubview:message];
        [message release];
        
        UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake(68, 114, 27, 17)];
        animationView.image = [UIImage imageNamed:@"ico_arrow_gray.png"];
        CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"position"];
        
        an.fromValue = [NSValue valueWithCGPoint:CGPointMake(68 + 13.5, 114 + 8.5)];
        an.toValue = [NSValue valueWithCGPoint:CGPointMake(175 + 13.5, 114 + 8.5)];
        an.duration = 1.0;
        an.repeatCount = NSNotFound;
        an.removedOnCompletion = NO;
        
        [animationView.layer addAnimation:an forKey:@"an"];
        [backageView addSubview:animationView];
        [animationView release];
        
        UIImageView *wxImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 45, 45)];
        wxImage.image = [UIImage imageNamed:@"ico_weixin.png"];
        [backageView addSubview:wxImage];
        [wxImage release];
        
        UIImageView *uboxImage = [[UIImageView alloc] initWithFrame:CGRectMake(175, 100, 45, 45)];
        uboxImage.image = [UIImage imageNamed:@"ico_ubox.png"];
        [backageView addSubview:uboxImage];
        [uboxImage release];
        [backageView release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}
@end
*/