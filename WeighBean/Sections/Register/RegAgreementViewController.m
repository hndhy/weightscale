//
//  RegAgreementViewController.m
//  WisdomRead
//
//  Created by 曾宪东 on 15/4/5.
//  Copyright (c) 2015年 minerva. All rights reserved.
//

#import "RegAgreementViewController.h"

@interface RegAgreementViewController ()
{
    UIWebView *_agreementWeb;
}
@end

@implementation RegAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (!_agreementWeb)
    {
        _agreementWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _agreementWeb.scalesPageToFit = YES;
        _agreementWeb.scrollView.bouncesZoom = NO;
    }
    
    [self.view addSubview:_agreementWeb];

    NSString *urlPolicy = @"http://api.hao1da.com/privacy_policy.html";
    NSString *urlProtocol = @"http://api.hao1da.com/user_agreement.html";
    NSURL *url = [NSURL URLWithString:self.type == 0 ? urlPolicy:urlProtocol];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_agreementWeb loadRequest:request];

}

- (void)initNavbar
{
    self.title = self.type == 0 ?  @"好益达隐私策略" : @"用户注册协议";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackUp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)onBackUp
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
