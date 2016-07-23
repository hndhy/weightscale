//
//  MeasureViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "MeasureViewController.h"

#import <UIImageView+WebCache.h>

#import "BLEInfo.h"
#import "BluetoothMacro.h"

#import "ZouMaDengInfoModel.h"

@interface MeasureViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate, UIScrollViewDelegate>

- (NSString*)hexadecimalString:(NSData*)data;
- (NSData*)dataWithHexstring:(NSString*)hexstring;

@property (strong, nonatomic) NSMutableString* values;
@property (strong, nonatomic) NSMutableString* valuesTest;
@property (nonatomic) NSUInteger intTest;
@property (strong, nonatomic) CBCentralManager* myCentralManager;
@property (strong, nonatomic) NSMutableArray* myPeripherals;
@property (strong, nonatomic) CBPeripheral* myPeripheral;
@property (strong, nonatomic) NSMutableArray* nServices;
@property (strong, nonatomic) NSMutableArray* nDevices;
@property (strong, nonatomic) NSMutableArray* nCharacteristics;

@property (strong, nonatomic) NSString *resultStr;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *thirdView;

@property (nonatomic, strong) NSMutableString *mStr;
@property (nonatomic, strong) UITextView *noticeView;
//@property (nonatomic, assign) BOOL writeSuccess;
@property (nonatomic, assign) int num;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *dotArray;
@property (nonatomic, assign) int dotIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,assign) BOOL writeSuccess;
@property (nonatomic,assign) BOOL notifSuccess;
@end

@implementation MeasureViewController

- (id)init
{
    if (self = [super init])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"usermeasureing"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
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

- (void)dismiss
{
    [self.myCentralManager stopScan];
    [self clearMyPeripheral];//EB9002411301BF02CB00F3004A02041202D806171F009A01930403
//    self.resultStr = [[NSString alloc] initWithFormat:@"EB9002411301BF02FFFFF3004A02041202D806171F009A01930403"];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.delegate)
        {
            NSString *value = self.resultStr.length ? self.resultStr : nil;
            int type = self.resultStr.length ? 1 : 0;
            [self.delegate passValue:value type:type];
        }
    }];
}

- (void)resetBluetooth
{
    [self.myCentralManager stopScan];
    [self clearMyPeripheral];
    
    [self.mStr setString:@""];
    [self writeLog:self.mStr];
    
    NSString *message = @"";
    if (self.myCentralManager.state == CBCentralManagerStatePoweredOn)
    {
        [self scanClick];
        message = @"已经重新开启连接";
    }
    else
    {
        message = @"请打开蓝牙后重新连接";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)initView
{
    self.mStr = [NSMutableString stringWithCapacity:100];
    
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
    
    self.noticeView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 20.0f, self.view.width - 20.0f,
                                                                   SCREEN_HEIGHT_EXCEPTNAV - 40.0f)];
    self.noticeView.font = [UIFont systemFontOfSize:14.0];
    self.noticeView.backgroundColor = [UIColor blackColor];
    self.noticeView.textColor = [UIColor greenColor];
    self.noticeView.editable = NO;
    
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
    
    UILabel *resetTip = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, _scrollView.bottom + 60, self.view.width - 36, 30)];
    resetTip.backgroundColor = [UIColor clearColor];
    resetTip.layer.cornerRadius = 4.0;
    resetTip.layer.masksToBounds = YES;
    resetTip.textAlignment = NSTextAlignmentCenter;
    resetTip.font = [UIFont systemFontOfSize:12];
    resetTip.text = @"长时间没有连接上称，请点右上角的重新连接";
    resetTip.textColor = [UIColor grayColor];
    [self.view addSubview:resetTip];
    
    [self.view addSubview:self.noticeView];
    self.noticeView.hidden = YES;
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

- (UIView *)createItem:(CGFloat)top title:(NSString *)title sub:(NSString *)sub
{
    UIView *firstBgView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, top, self.view.width - 40.0f, 50.0f)];
    firstBgView.layer.cornerRadius = 10.0f;
    firstBgView.layer.masksToBounds = YES;
    firstBgView.backgroundColor = UIColorFromRGB(200.0f, 205.0f, 209.0f);
    [self.view addSubview:firstBgView];
    UIView *firstCoverView = [[UIView alloc] initWithFrame:firstBgView.frame];
    firstCoverView.layer.cornerRadius = 10.0f;
    firstCoverView.layer.masksToBounds = YES;
    firstCoverView.backgroundColor = UIColorFromRGB(86.0f, 189.0f, 243.0f);
    firstCoverView.hidden = YES;
    [self.view addSubview:firstCoverView];
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, firstCoverView.top + 10.0f, self.view.width, 17.0f)
                                             withSize:14.0f withColor:[UIColor whiteColor]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [self.view addSubview:titleLabel];
    UILabel *subLabel = [UILabel createLabelWithFrame:CGRectMake(0, titleLabel.bottom + 3.0f, titleLabel.width, 15.0f)
                                           withSize:12.0f withColor:UIColorFromRGB(200.0f, 205.0f, 209.0f)];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.text = @"等待程序与称自动建立连接";
    [self.view addSubview:subLabel];
    return firstCoverView;
}

- (void)clearMyPeripheral
{
    if(self.myPeripheral != nil)
    {
        [self.myCentralManager cancelPeripheralConnection:self.myPeripheral];
        self.myPeripheral.delegate = nil;
        self.myPeripheral = nil;
        [self writeLog:@"清除称连接的实例...\n"];
        self.writeSuccess = NO;
        self.notifSuccess = NO;
        [self changeTip];
    }
}

// 初始化蓝牙扫描
- (void)initModel
{
    dispatch_queue_t qt = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:qt];
}

//开始查看服务, 蓝牙开启
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
            [self scanClick];
            break;
        default:
            [self showBlueTip:@"蓝牙没有打开"];
            break;
    }
}

//扫描
- (void)scanClick
{
    [self writeLog:[NSString stringWithFormat:@"完整设备号:%@\n",[HTAppContext sharedContext].device]];
    [self writeLog:@"正在扫描称...\n"];

    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];

    [self.myCentralManager scanForPeripheralsWithServices:nil options:options];
    
    /*
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myCentralManager stopScan];
        if(self.myPeripheral != nil)
        {
            [self.myCentralManager cancelPeripheralConnection:_myPeripheral];
        }
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            if (self.delegate)
            {
                if (self.myPeripheral)
                {
                    [self.delegate passValue:self.resultStr type:1];
                }
                else
                {
                    [self.delegate passValue:@"" type:3];
                }
            }
        }];
    });
     */
}

//查到外设后的方法,peripherals
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *deviceName = [advertisementData valueForKey:CBAdvertisementDataLocalNameKey];
//    NSLog(@"advertisementData======>%@", advertisementData);
    HTAppContext *appContext = [HTAppContext sharedContext];
    if (deviceName && [appContext.device hasSuffix:deviceName] &&
        !self.myPeripheral&& self.myPeripheral.state == CBPeripheralStateDisconnected)
    {
        self.writeSuccess = NO;
        self.notifSuccess = NO;
        [self changeTip];
        [self writeLog:@"已扫描到称...\n"];
        [self setMyPeripheral:peripheral];
        [self.myPeripheral setDelegate:self];
        [self writeLog:@"获取连接称的实例并赋值给自己的属性...\n"];
        [self connectClick];
    }
}

//连接
- (void)connectClick
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
        [options setObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnConnectionKey];
        [options setObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey];
        [options setObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnNotificationKey];
        [weakSelf.myCentralManager connectPeripheral:weakSelf.myPeripheral options:options];
        [weakSelf writeLog:@"开始连接称...\n"];
    });
}

//连接外设成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self writeLog:@"成功连接称...\n"];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        NSMutableArray *serverUUIDs = [[NSMutableArray alloc] init];
        CBUUID *serverUUID_1 = [CBUUID UUIDWithString:UUIDSTR_ISSC_AIR_PATCH_SERVICE];
        [serverUUIDs addObject:serverUUID_1];
        CBUUID *serverUUID_2 = [CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE];
        [serverUUIDs addObject:serverUUID_2];
        [weakSelf.myPeripheral discoverServices:serverUUIDs];
        [weakSelf writeLog:@"扫描称上的服务...\n"];
    });
}

//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self writeLog:@"称的实例连接失败...\n"];
    [self clearMyPeripheral];

}

//掉线时调用
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self writeLog:@"和称断开了连接...\n"];
    [self clearMyPeripheral];
}

//已发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    [self writeLog:@"发现称上的服务....\n"];
    
    int i = 0;
    for(CBService *obj in peripheral.services)
    {
        [self.myPeripheral discoverCharacteristics:nil forService:obj];

        i++;
        NSString *log = [NSString stringWithFormat:@"去扫描称上的服务的属性%d次...\n",i];
        
        [self writeLog:log];
    }
}

//已发现characteristcs
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if ([service.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE]] ||
        [service.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_AIR_PATCH_SERVICE]])
    {
        for (CBCharacteristic* aChar in service.characteristics)
        {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]])
            {
                HTUserData *userData = [HTUserData sharedInstance];
                NSData *value = [self dataWithHexstring:[userData requestCode]];
                [_myPeripheral writeValue:value forCharacteristic:aChar type:CBCharacteristicWriteWithResponse];
                NSString *log = [NSString stringWithFormat:@"发现称上服务的写属性并发送信息:%@\n", [userData requestCode]];
                [self writeLog:log];
            }
            else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]])
            {
                [self.myPeripheral setNotifyValue:YES forCharacteristic:aChar];
                [self writeLog:@"发现称上服务的读属性并阅此属性...\n"];
            }
        }
    }
}

//获取外设发来的数据,不论是read和notify,获取数据都从这个方法中读取
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSData *data = characteristic.value;
    NSString *value = [self hexadecimalString:data];
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]])
    {
        
    }
    else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]])
    {
        self.resultStr = [value uppercaseString];
        NSString *log = [NSString stringWithFormat:@"回传数据:%@\n", value];
        [self writeLog:log];
        
        if ([self.resultStr hasPrefix:@"EB90024113"])//111改为113 20150926
        {
            [self writeLog:@"测量完毕点屏幕左上角的X按钮回主页看数据\n"];
            
            [self.myCentralManager stopScan];
            [self clearMyPeripheral];

            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                if (self.delegate)
                {
                    [self.delegate passValue:self.resultStr type:1];
                }
            }];
        }
    }
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if(!error)
    {
        [self writeLog:@"向称上服务的读属性订阅成功...\n"];
        self.notifSuccess = YES;
        [self changeTip];
    }
    else
    {
        [self clearMyPeripheral];
    }
}

//向peripheral中写入数据后的回调函数
- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error)
    {
        [self writeLog:@"向称上服务的写属性并发送信息成功...\n"];
        self.writeSuccess = YES;
        [self changeTip];
    }
    else
    {
        [self clearMyPeripheral];
    }
}

//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data
{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer)
    {
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++)
    {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.dotIndex != page)
    {
        if (page < 0 || page > [self.dotArray count])
        {
            return;
        }
        UIView *oldView = [self.dotArray objectAtIndex:self.dotIndex];
        oldView.backgroundColor = UIColorFromRGB(229.0f, 229.0f, 229.0f);
        UIView *newView = [self.dotArray objectAtIndex:page];
        ZouMaDengInfoModel *model = [self.array objectAtIndex:page];
        self.titleLabel.text = model.title;
        newView.backgroundColor = UIColorFromRGB(1.0f, 167.0f, 225.0f);
        self.dotIndex = page;
    }
}

- (void)writeLog:(NSString *)log
{
    NSLog(@"%@",log);
    if (self.noticeView.hidden)
    {
        return;
    }
    [self.mStr appendString:log];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.noticeView.text = weakSelf.mStr;
    });
}

- (void)changeTip
{
    if (self.writeSuccess && self.notifSuccess)
    {
        [self showBlueTip:@"请您上称"];
    }
    else
    {
        [self showBlueTip:@"请您等待"];
    }
}

- (void)showBlueTip:(NSString *)tip
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"usermeasureing"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
