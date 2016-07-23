//
//  AddLookViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/9/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "AddLookViewController.h"
#import "SyncDataModelHander.h"
#import "HTAddLookModel.h"
#import "AddLookResponse.h"
#import <AFNetworking/AFNetworking.h>

#import "NSDictionary+UrlEncoding.h"
#import "NSString+Additions.h"
#import "HTAppContext.h"
#import "JSONKit.h"

#import "DiaryViewController.h"

@interface AddLookViewController ()< SyncModelProtocol>

@property (nonatomic, strong)SyncDataModelHander *syncHandler;
@property (nonatomic, strong)HTAddLookModel *addLookModel;

@end

@implementation AddLookViewController

-(void)initModel
{
    self.syncHandler = [[SyncDataModelHander alloc]initWithController:self];
    self.addLookModel = [[HTAddLookModel alloc]initWithHandler:self.syncHandler];
}

- (void)initNavbar
{
    self.title = @"添加查看";
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [menuButton setTitle:@"搜索" forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"check_mark_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.rightBarButtonItem = leftItem;
}

- (void)initView
{
    UITextField *textf = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH - 60, 35)];
    textf.placeholder = @"请输入要查询的手机号";
    textf.backgroundColor = [UIColor whiteColor];
    textf.layer.cornerRadius = 2;
    textf.layer.masksToBounds = YES;
    textf.font = [UIFont systemFontOfSize:15];
    textf.tag = 0xfbc;
//    textf.text = @"13011892932";
    [self.view addSubview:textf];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction
{
    [self.view endEditing:YES];
}

- (void)rightAction
{
    UITextField *textf = (UITextField *)[self.view viewWithTag:0xfbc];
    if (textf.text.length >= 7)
    {
        [self.addLookModel searchChengYan:textf.text];
    }
    else
    {
        [self alert:@"温馨提示" message:@"您输入的手机号位数不对" delegate:nil cancelTitle:@"确定" otherTitles:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)syncFinished:(AddLookResponse *)response;
{
    if (response.userExist)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户已存在我的下级" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 0xfcc;
        [alert show];
    }
    else
    {
        [self joinTeamWithId:response.uid];
    }
}
- (void)syncFailure;
{

}

- (void)joinTeamWithId:(NSString *)uid
{
    HTApiClient *client = [HTApiClient sharedClient];
    if (![client isNetworkAvailable])
    {
        NSLog(@"network unavailable");
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:@"ios" forKey:@"os"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:uid forKey:@"underUid"];
    
    NSString *commonParameters = [[HTAbstractDataSource mcommonParams] urlEncodedString];
    NSString *newPath = [@"/joinMyTeam.htm" URLStringByAppendingQueryString:commonParameters];
            __weak __typeof(self) weakSelf = self;
    [client GET:newPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [operation.responseString objectFromJSONString];
        NSLog(@"msg = %@",dic[@"msg"]);
        if (dic && [dic isKindOfClass:[NSDictionary class]]) {
            if ([[dic objectForKey:@"status"] boolValue]) {
                [weakSelf pushChengYanWeb:uid];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
        [weakSelf alert:@"温馨提示" message:@"网络请求失败" delegate:nil cancelTitle:@"确定" otherTitles:nil];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0xfcc) {
        
    }
}

- (void)pushChengYanWeb:(NSString *)uid
{
    DiaryViewController *dia = [[DiaryViewController alloc] init];
    dia.coachUid = uid;
    [self.navigationController pushViewController:dia animated:YES];
}


@end
