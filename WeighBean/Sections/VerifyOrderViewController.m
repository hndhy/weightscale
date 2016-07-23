//
//  VerifyOrderViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/17.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "VerifyOrderViewController.h"
#import "VerifyOrderView.h"
#import "ModifyViewController.h"
#import "OnlineOrderData.h"
#import "WXThrid.h"
#import "VerifyOrderHander.h"
#import "VerifyOrderModel.h"

@interface VerifyOrderViewController ()<VerifyOrderModelProtocol>
{
    VerifyOrderView *_headerView;
    
    UIButton *_wxbtn;
}
@property (nonatomic,strong) OnlineOrderData *preOrder;
@property (nonatomic,strong) VerifyOrderHander *hander;
@property (nonatomic,strong) VerifyOrderModel *model;
@end

@implementation VerifyOrderViewController

- (void)initModel
{
    self.hander = [[VerifyOrderHander alloc] initWithController:self];
    self.model = [[VerifyOrderModel alloc] initWithHandler:_hander];
//    [_model getProductid:@"1"];
}

- (void)initNavbar
{
    self.title = @"商品详情";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackUp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [forwardButton setImage:[UIImage imageNamed:@"home_forward_icon.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(onOpenURLClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height-64)];
    [self.view addSubview:web];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.weburl]];
    [web loadRequest:req];
    
    NSRange range = [self.weburl rangeOfString:@"https:"];
    if (!range.length)
    {
        range = [self.weburl rangeOfString:@"http:"];
    }
    if (range.length)
    {
        NSMutableString *url = [[NSMutableString alloc] initWithString:self.weburl];
        [url replaceCharactersInRange:range withString:@"taobao:"];
        self.clienturl = url;
        
        NSURL *URL = [NSURL URLWithString:self.clienturl];
        if ([[UIApplication sharedApplication] canOpenURL:URL])
        {
            [[UIApplication sharedApplication] openURL:URL];
        }
    }
    
    /*
    _preOrder = [[OnlineOrderData alloc] init];
    _preOrder.productName = @"高级人体体脂秤重秤";
    _preOrder.productPrice = @"800";
    _preOrder.payPirece = @"800";
    
    if (!_headerView)
    {
        __weak typeof(self) weakSelf = self;
        _headerView = [VerifyOrderView viewWithSelect:^(NSInteger index) {
            [weakSelf modifyIndex:index];
        }];
    }
    [_headerView refreshObj:_preOrder];
    
    [self.view addSubview:_headerView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 20, SCREEN_WIDTH, 44)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    line.backgroundColor = UIColorFromRGB(229, 229, 229).CGColor;
    [contentView.layer addSublayer:line];
    
    line = [CALayer layer];
    line.frame = CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5);
    line.backgroundColor = UIColorFromRGB(229, 229, 229).CGColor;
    [contentView.layer addSublayer:line];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 25, 22)];
    icon.image = [UIImage imageNamed:@"verfiy_wx_icon"];
    [contentView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 8, 11 ,80, 22)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = UIColorFromRGB(77, 77, 77);
    label.text = @"微信支付";
    [contentView addSubview:label];
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 32, 11, 22, 22)];
    icon.image = [UIImage imageNamed:@"verfiy_select_icon"];
    [contentView addSubview:icon];
    
    _wxbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wxbtn.backgroundColor = UIColorFromRGB(1, 167, 225);
    _wxbtn.frame = CGRectMake(15,CGRectGetMaxY(contentView.frame) + 20, SCREEN_WIDTH - 30, 40);
    [_wxbtn setTitle:@"确认支付" forState:UIControlStateNormal];
    _wxbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_wxbtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxbtn];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onOpenURLClick
{
    NSURL *URL = [NSURL URLWithString:self.weburl];
    [[UIApplication sharedApplication] openURL:URL];
}

- (void)onBackUp
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)modifyIndex:(NSInteger )index
{
    ModifyViewController *modify = [[ModifyViewController alloc] init];
    modify.selectIndex = index;
    [modify setGetInputBlock:^(NSString *str) {
        switch (index) {
            case 0:
                _preOrder.address = str;
                break;
            case 1:
                _preOrder.phone = str;
                break;
            case 2:
                _preOrder.name = str;
                break;
            default:
                break;
        }
        [_headerView refreshObj:_preOrder];
    }];
    [self.navigationController pushViewController:modify animated:YES];
}

- (void)buyAction
{
    [[WXThrid defualtWXThrid] getPayAccessToken];
}

- (void)syncFinished:(VerfiyOrderResponse *)response
{
    
}

- (void)syncFailure
{
    
}


@end
