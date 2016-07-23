//
//  WiFiController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/9/14.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "WiFiController.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>

#import <dlfcn.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

#import "ZouMaDengInfoModel.h"
#import <UIImageView+WebCache.h>

@interface WiFiController ()<UIScrollViewDelegate>
{
    CFSocketRef _socket;
    BOOL _isLoop;
    NSInteger _count;
    NSThread *_initThread;
}

@property (nonatomic,strong) NSString *backString;
@property (nonatomic,assign) int status;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *dotArray;
@property (nonatomic, assign) int dotIndex;

-(void)createConnect:(NSString*)strAddress;

@end

@implementation WiFiController

- (id)init
{
    if (self = [super init])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"usermeasureing"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}

- (void)initModel
{
    self.backString = [[NSMutableString alloc] init];
    _status = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self closeSocket];
        NSString *ip = @"192.168.7.1";
        [self createConnect:ip];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)didBecomeActive
{
   if(!self.backString.length)
   {
       [self closeSocket];
       NSString *ip = @"192.168.7.1";
       [self createConnect:ip];
   }
}

- (void)didEnterBackground
{
    [self closeSocket];
}

- (void)initNavbar
{
    self.title = @"测量";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"close_nav_bar.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0f, 44.0f)];
    [rightButton setTitle:@"重新连接" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [rightButton addTarget:self action:@selector(resetBluetooth) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)resetBluetooth
{
    NSString *message = nil;
    if (self.backString.length > 30)
    {
        message = @"已有测量数据请切WiFi到首页";
    }
    else
    {
        message = @"已重新连接";
        [self closeSocket];
        NSString *ip = @"192.168.7.1";
        [self createConnect:ip];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)dismiss
{
    NSString *strong = [[NSString alloc] initWithString:self.backString];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.delegate)
        {
            NSString *value = strong.length ? strong : nil;
            int type = strong ? 1 : 0;
            [self.delegate passValue:value type:type];
        }
    }];
}

- (void)initView
{
    UILabel *blueTip = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 30, self.view.width - 36, 30)];
    blueTip.backgroundColor = [UIColor whiteColor];
    blueTip.layer.cornerRadius = 4.0;
    blueTip.layer.masksToBounds = YES;
    blueTip.textAlignment = NSTextAlignmentCenter;
    blueTip.font = [UIFont systemFontOfSize:13];
    blueTip.tag = 0xfbb;
    
    blueTip.textColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
    [self.view addSubview:blueTip];
    [self changeTip];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(18.0f, 84.0f, self.view.width - 36.0f, 217.0f)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 4.0f;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bgView.left + 32.0f, bgView.top + 17.0f, 112.0f, 167.0f)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.array.count, self.scrollView.height);
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectMake(self.scrollView.right, bgView.top, bgView.width - self.scrollView.right,
                                                               bgView.height) withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [self.view addSubview:self.titleLabel];
    int len = (int)[self.array count];
    self.dotArray = [NSMutableArray arrayWithCapacity:len];
    CGFloat left = (self.view.width - 10.0f * len - 10.0f * (len - 1)) / 2.0f;
    for (int i = 0; i < len; i++)
    {
        ZouMaDengInfoModel *model = [self.array objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.scrollView.width, 0,
                                                                               self.scrollView.width, self.scrollView.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        imageView.backgroundColor = [UIColor grayColor];
        [self.scrollView addSubview:imageView];
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(left, bgView.bottom - 24.0f, 8.0f, 8.0f)];
        if (i == 0)
        {
            self.titleLabel.text = model.title;
            dotView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        }
        else
        {
            dotView.backgroundColor = UIColorFromRGB(229.0f, 229.0f, 229.0f);
        }
        dotView.layer.cornerRadius = 4.0f;
        dotView.layer.masksToBounds = YES;
        [self.view addSubview:dotView];
        [self.dotArray addObject:dotView];
        left = dotView.right + 10.0f;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(incrementOffset) userInfo:nil repeats:YES];
}

- (void)incrementOffset
{
    self.dotIndex++;
    int len = (int)[self.dotArray count];
    if (self.dotIndex >= len)
    {
        self.dotIndex = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.dotIndex * self.scrollView.width, 0) animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self closeSocket];
}

- (void)changeTip
{
    switch (_status)
    {
        case 0:
            [self showWiFiTip:@"请连接秤的WiFi"];
            break;
        case 1:
            [self showWiFiTip:@"请您上秤测量"];
            break;
        case 2:
            [self showWiFiTip:@"测量完毕请您切换WiFi到首页"];
            break;
        default:
            break;
    }
}

- (void)showWiFiTip:(NSString *)tip
{
    if (tip.length)
    {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *string = [NSString stringWithFormat:@"...%@...",tip];
            UILabel *label = (UILabel *)[weakSelf.view viewWithTag:0xfbb];
            label.text = string;
        });
    }
}

#pragma mark - 连接秤的Socket

// 读取接收的数据
-(void)readStream
{
    Byte buffer[80];
    if (_socket == nil)
    {
        return;
    }
    recv(CFSocketGetNative(_socket), buffer, sizeof(buffer), 0);
    {
        NSString *string = @"";
        for (int i=0; i< 80; i++)
        {
            NSString *str1 = [self intToHex:buffer[i] param2:2];
            string = [string stringByAppendingString:str1];
        }
        NSLog(@"string = %@",string);
        self.backString = [[NSString alloc] initWithFormat:@"%@",string];
//        [self analytical:string];
        [self closeSocket];
        
        /*
        NSString *strongString = [[NSString alloc] initWithString:string];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            if (self.delegate)
            {
                [self.delegate passValue:strongString type:1];
            }
        }];
         */
    }
}

- (void)threadAction
{
    while (_isLoop)
    {
        [self readStream];
    }
}

-(void)startReadThread
{
    _initThread = [[NSThread alloc]initWithTarget:self selector:@selector(threadAction) object:self];
    [_initThread start];
}

// 发送数据
- (void)pushUserInfo
{
//    NSString *userString = [self userInfoString];
    HTUserData *user = [HTUserData sharedInstance];
    NSString *userString = [user requestCode];
    
    NSData *userData = [userString dataUsingEncoding:NSASCIIStringEncoding];
    Byte *userDataByte = (Byte *)[userData bytes];
    
    int count_b = (int)userData.length;
    
    Byte userByte[count_b/2];
    Byte bytes[2];
    for (int i = 0; i<count_b; i += 2)
    {
        bytes[0] = userDataByte[i];
        bytes[1] = userDataByte[i+1];
        NSData *data = [[NSData alloc] initWithBytes:bytes length:2];
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        int dataToul = (int)strtoul([dataString UTF8String],0,16);
        userByte[(i/2)] = (Byte)dataToul;
    }

    NSLog(@"userString = %@",userString);

    send(CFSocketGetNative(_socket), userByte, 12, 0);
    
    _status = 1;
}

// socket回调函数，同客户端
static void TCPClientConnectCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info)
{
    WiFiController *client = (__bridge WiFiController *)info;
    if (data != NULL)
    {
        client.status = 0;
//        NSLog(@"连接失败");
        NSString *ip = @"192.168.7.1";
        [client createConnect:ip];
        [client changeTip];
        return;
    }
    else
    {
//        NSLog(@"连接成功");
        [client pushUserInfo];
        [client startReadThread];
        client.status = 1;
        [client changeTip];
    }
}

//链接设备方法
-(void)createConnect:(NSString*)strAddress
{
    _isLoop = YES;
    CFSocketContext sockContext = {0, // 结构体的版本，必须为0
        (__bridge void *)(self),
        NULL, // 一个定义在上面指针中的retain的回调， 可以为NULL
        NULL,
        NULL};
    _socket = CFSocketCreate(kCFAllocatorDefault, // 为新对象分配内存，可以为nil
                             PF_INET, // 协议族，如果为0或者负数，则默认为PF_INET
                             SOCK_STREAM, // 套接字类型，如果协议族为PF_INET,则它会默认为SOCK_STREAM
                             IPPROTO_TCP, // 套接字协议，如果协议族是PF_INET且协议是0或者负数，它会默认为IPPROTO_TCP
                             kCFSocketConnectCallBack, // 触发回调函数的socket消息类型，具体见Callback Types
                             TCPClientConnectCallBack, // 上面情况下触发的回调函数
                             &sockContext // 一个持有CFSocket结构信息的对象，可以为nil
                             );
    if(_socket != NULL)
    {
        struct sockaddr_in addr4;   // IPV4
        memset(&addr4, 0, sizeof(addr4));
        addr4.sin_len = sizeof(addr4);
        addr4.sin_family = AF_INET;
        addr4.sin_port = htons(8040);
        addr4.sin_addr.s_addr = inet_addr([strAddress UTF8String]);  // 把字符串的地址转换为机器可识别的网络地址
        
        // 把sockaddr_in结构体中的地址转换为Data
        CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
        CFSocketConnectToAddress(_socket, // 连接的socket
                                 address, // CFDataRef类型的包含上面socket的远程地址的对象
                                 -1  // 连接超时时间，如果为负，则不尝试连接，而是把连接放在后台进行，如果_socket消息类型为kCFSocketConnectCallBack，将会在连接成功或失败的时候在后台触发回调函数
                                 );
        CFRunLoopRef cRunRef = CFRunLoopGetCurrent();    // 获取当前线程的循环
        // 创建一个循环，但并没有真正加如到循环中，需要调用CFRunLoopAddSource
        CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
        CFRunLoopAddSource(cRunRef, // 运行循环
                           sourceRef,  // 增加的运行循环源, 它会被retain一次
                           kCFRunLoopCommonModes  // 增加的运行循环源的模式
                           );
        CFRelease(sourceRef);
    }
}

-(void)closeSocket
{
    if (self.backString.length > 30)
    {
        _status = 2;
        [self changeTip];
    }
    else
    {
        _status = 0;
        [self changeTip];
    }
    
    _isLoop = NO;
    if (_initThread != nil)
    {
        [_initThread cancel];
        _initThread=nil;
    }
    
    if (_socket != nil)
    {
        CFSocketInvalidate(_socket);
        _socket=nil;
    }
}

#pragma mark - 数据处理

- (NSString *)userInfoString
{
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYY-MM-dd"];
    
    NSString *datastr=[nsdf2 stringFromDate:[NSDate date]];
    NSArray *ymd=[datastr componentsSeparatedByString:@"-"];
    
    SetOrder *order=[[SetOrder alloc] init];
    [order initobj];
    [order setYear:[ymd[0]  intValue]];
    [order setMonth:[ymd[1]  intValue]];
    [order setDay:[ymd[2]  intValue]];
    
    int sex = [HTUserData sharedInstance].sex;
    float height = [HTUserData sharedInstance].height;
    
    [order setSex:sex];
    [order setWeigh:60.0f];
    [order setHeight:height];
    
    return [order toString];
}

- (NSString *)intToHex:(int)paramInt1  param2:(int)paramInt2
{
    NSString *str = [ [NSString alloc] initWithFormat:@"%x",paramInt1];
    
    if (paramInt2==2)
    {
        if (str.length<2)
        {
            str=[@"0" stringByAppendingString:str];
        }
        return str;
    }
    if (str.length==3)
    {
        str=[@"0" stringByAppendingString:str];
    }
    if (str.length==2)
    {
        str=[@"00" stringByAppendingString:str];
    }
    if (str.length==1)
    {
        str=[@"000" stringByAppendingString:str];
    }
    NSString * str1 = [str substringToIndex:2];
    NSString * str2 = [str substringFromIndex:2];
    
    NSString  *str_r=[str2 stringByAppendingString:str1];
    return str_r;
}

-(void)analytical:(NSString *)backString
{
    if ([backString isEqualToString:@""])
    {
        return;
    }
    
    // 体重
    NSString *weigh1=[backString substringWithRange:NSMakeRange(14, 2)];
    NSString *weigh2=[backString substringWithRange:NSMakeRange(12, 2)];
    NSString *weight=[weigh1 stringByAppendingString:weigh2];
    int weight_int = (int)strtoul([weight UTF8String],0,16);
    float weight_f = weight_int/10.0f;
    
    NSLog(@"体重 = %.1f",weight_f);
    
    // 体脂
    NSString *fat1=[backString substringWithRange:NSMakeRange(18, 2)];
    NSString *fat2=[backString substringWithRange:NSMakeRange(16, 2)];
    NSString *fat=[fat1 stringByAppendingString:fat2];
    float fat_int=strtoul([fat UTF8String],0,16);
    float fat_f=fat_int/10.0f;
    if(0.0<fat_f&&fat_f<50.0)
    {
        NSLog(@"体脂肪率 = %.1f",fat_f);
    }
    else
    {
        NSLog(@"体脂肪率——错误");
    }
    
    // BMI
    NSString *bmi1=[backString substringWithRange:NSMakeRange(22, 2)];
    NSString *bmi2=[backString substringWithRange:NSMakeRange(20, 2)];
    NSString *bmi=[bmi1 stringByAppendingString:bmi2];
    float bmi_f=strtoul([bmi UTF8String],0,16)/10.0f;
    if (0.0<bmi_f&&bmi_f<150.0)
    {
        NSLog(@"BMI = %.1f",bmi_f);
    }
    else
    {
        NSLog(@"BMI——错误");
    }
    
    NSString *water1=[backString substringWithRange:NSMakeRange(26, 2)];
    NSString *water2=[backString substringWithRange:NSMakeRange(24, 2)];
    NSString *water=[water1 stringByAppendingString:water2];
    int water_int= (int)strtoul([water UTF8String],0,16);
    float water_f=water_int/10.0f;
    NSLog(@"体内水分 = %.1f",water_f);
    
    // 内脂
    NSString *vat=[backString substringWithRange:NSMakeRange(28, 2)];
    float vat_int=strtoul([vat UTF8String],0,16);
    if (0<=vat_int&&vat_int<=9)
    {
        NSLog(@"内脂 = %.1f",vat_int);
    }
    else
    {
        NSLog(@"内脂——错误");
    }
    
    // 肌肉量
    NSString *muscle1=[backString substringWithRange:NSMakeRange(32, 2)];
    NSString *muscle2=[backString substringWithRange:NSMakeRange(30, 2)];
    NSString *muscle=[muscle1 stringByAppendingString:muscle2];
    float muscle_int=strtoul([muscle UTF8String],0,16);
    float muscle_f=muscle_int/10.0f;
    if (muscle_f>=0&&muscle_f<=6553)
    {
        NSLog(@"肌肉量 = %.1f",muscle_f);
    }
    else
    {
        NSLog(@"肌肉量——错误");
    }
    
    // 基础代谢
    NSString *bmr1=[backString substringWithRange:NSMakeRange(36, 2)];
    NSString *bmr2=[backString substringWithRange:NSMakeRange(34, 2)];
    NSString *bmr=[bmr1 stringByAppendingString:bmr2];
    int bmr_int = (int)strtoul([bmr UTF8String],0,16);
    
    if (385<bmr_int&&bmr_int<3999)
    {
        NSLog(@"基础代谢 = %d",bmr_int);
    }
    else
    {
        NSLog(@"基础代谢——错误");
    }
    
    // 身体年龄
    NSString *body_age =[backString substringWithRange:NSMakeRange(38, 2)];
    float body_age_int=strtoul([body_age  UTF8String],0,16);
    NSLog(@"身体年龄 = %.0f",body_age_int);
    
    // 骨量
    NSString *bone=[backString substringWithRange:NSMakeRange(40, 2)];
    float bone_int=strtoul([bone UTF8String],0,16);

    if (5.0<bone_int&&bone_int<150.0)
    {
        NSLog(@"骨量 = %.1f",bone_int);
    }
    else
    {
        NSLog(@"骨量——错误");
    }
}

//将传入的NSString类型转换成NSData并返回
- (NSData*)dataWithHexstring:(NSString *)hexstring
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for(idx = 0; idx + 2 <= hexstring.length; idx += 2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [hexstring substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"usermeasureing"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

@end


@implementation SetOrder
{
    
}
- (void)initobj
{
    day = 0;
    height = 0.0f;
    month = 0;
    sex = 0;
    user_code = 1;
    weigh = 0.0f;
    year = 0;
}

-(int)getAge
{
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYY"];
    NSString *year1=[nsdf2 stringFromDate:[NSDate date]];
    int curYear = (int)[year1 integerValue] ;
    int age = curYear - year;
    return age;
}

-(NSString *)getDataPackage
{
    NSString *sb=@"";
    
    int gender_age = [HTUserData sharedInstance].age;
    if(sex == 0)
    {//female
        gender_age += 128;
    }
    sb = [sb stringByAppendingString:[self IntToHex:user_code param2:2]];
    sb = [sb stringByAppendingString:[self IntToHex:gender_age param2:2]];
    sb = [sb stringByAppendingString:[self IntToHex:(int)(10.0F * height) param2:4]];
    return sb ;
}

-(NSString *)toString
{
    NSString *str1 = [self  getDataPackage];
    NSString *str2 = [ self IntToHex:(int)str1.length/2 param2:2]; // Tool.IntToHex(str1.length() / 2, 2);
    
    NSString * ss= @"EB9002";// + @"32" + str2 + str1 + [self  getSum:str1] + "03"
    ss = [ss stringByAppendingString:@"32"];
    ss = [ss stringByAppendingString:str2];
    ss = [ss stringByAppendingString:str1];
    ss = [ss stringByAppendingString:[self  getSum:str1]];
    ss = [ss stringByAppendingString:@"03"];
    ss = [ss uppercaseString];
    
    //      [-21, -112, 2, 50, 4, 1, 36, -112, 6, -69, 0, 3]
    //    EB9002320401249006BB0003
    return ss;
}

-(NSString *)getSum:(NSString *) paramString
{
    int i = (int)paramString.length;
    if ((i == 0) && (i % 2 != 0))
    {
        return @"FFFF";
    }
    int j = 0;
    for (int k = 0;; k++)
    {
        if (k >= i / 2 )
        {
            return  [ self IntToHex:j param2:4];
        }
        NSRange rangde=NSMakeRange(k * 2, 2 );
        NSString *num=[paramString substringWithRange:rangde ];
        j += [self HexToInt:num ];
    }
}

-(NSString *)IntToHex:(int) paramInt1  param2:(int) paramInt2
{
    NSString *str = [ [NSString alloc] initWithFormat:@"%x",paramInt1];
    
    if (paramInt2==2)
    {
        if (str.length<2)
        {
            str=[@"0" stringByAppendingString:str];
        }
        return str;
    }
    if (str.length==3)
    {
        str=[@"0" stringByAppendingString:str];
    }
    if (str.length==2)
    {
        str=[@"00" stringByAppendingString:str];
    }
    if (str.length==1)
    {
        str=[@"000" stringByAppendingString:str];
    }
    NSString * str1 = [str substringToIndex:2];
    NSString * str2 = [str substringFromIndex:2];
    
    NSString  *str_r=[str2 stringByAppendingString:str1];
    return str_r;
    
}

-(int)HexToInt:(NSString *)num
{
    int i = (int)strtoul([num UTF8String],0,16);
    return i;
}

-(void) setDay:(int) paramInt
{
    day=paramInt;
}

-(void) setHeight:(float) paramFloat
{
    height=paramFloat;
}

-(void) setMonth:(int) paramInt
{
    month = paramInt;
}

-(void) setSex:(int) paramInt
{
    sex = paramInt;
}

-(void) setWeigh:(float) paramFloat
{
    weigh = paramFloat;
}

-(void) setYear:(int) paramInt;
{
    year = paramInt;
}

@end

