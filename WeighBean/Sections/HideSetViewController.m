//
//  HideSetViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/8.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HideSetViewController.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"
#import "HideModelHandler.h"
#import "HideModel.h"
#import <RESideMenu.h>

@interface HideSetViewController ()<HideModelProtocol>
{
    UILabel *_label;
    UISwitch *_hideSwitch;
}
@property (nonatomic,strong)HideModelHandler *handle;
@property (nonatomic,strong)HideModel *model;

@end


@implementation HideSetViewController


- (void)initModel
{
    self.handle = [[HideModelHandler alloc] initWithController:self];
    self.model = [[HideModel alloc] initWithHandler:self.handle];
    [self.model getHideStatus];
}

- (void)initNavbar
{
    self.title = @"V战队设置";
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initView
{
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
    content.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:content];
    
    _hideSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(content.width - 70, 3, 60, 30)];
    _hideSwitch.on = YES;
    [_hideSwitch addTarget:self action:@selector(hideAction:) forControlEvents:UIControlEventValueChanged];
    [content addSubview:_hideSwitch];
    content.frame = CGRectMake(0, 20, SCREEN_WIDTH, _hideSwitch.height +6);
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, content.height)];
    _label.backgroundColor = [UIColor clearColor];
    _label.text = @"隐藏";
    [content addSubview:_label];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(content.frame), SCREEN_WIDTH, content.height)];
    tip.backgroundColor = [UIColor clearColor];
    tip.text = @"测量数据对战队成员隐藏，只有本人和教练可见";
    tip.font = [UIFont systemFontOfSize:13];
    tip.textColor = UIColorFromRGB(160, 160, 160);
    [self.view addSubview:tip];
}

- (void)hideAction:(UISwitch *)sender
{
    NSString *stat = @"1";
    if (!sender.on)
    {
//        _label.text = @"隐藏";
        stat = @"0";
    }
    else
    {
//        _label.text = @"打开";
        stat = @"1";
    }
    [self.model setHideStatus:stat];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)syncFinished:(HideModelResponse *)response;
{
    if (response.stat)
    {
        // 0开1关
        if ([response.stat boolValue])
        {
            _hideSwitch.on = YES;
//            _label.text = @"隐藏";
        }
        else
        {
            _hideSwitch.on = NO;
//            _label.text = @"打开";
        }
    }
}

- (void)syncFailure
{
    
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
