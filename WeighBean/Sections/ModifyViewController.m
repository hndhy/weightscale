//
//  ModifyViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()<UITextFieldDelegate>

@end

@implementation ModifyViewController

- (void)initNavbar
{
    switch (self.selectIndex) {
        case 0:
            self.title = @"请输入地址";
            break;
        case 1:
            self.title = @"请输入手机";
            break;
        case 2:
            self.title = @"请输入姓名";
            break;
        default:
            break;
    }
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [backButton setImage:[UIImage imageNamed:@"black_nav_bar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *verfiyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [verfiyButton setTitle:@"确定" forState:UIControlStateNormal];
    [verfiyButton addTarget:self action:@selector(verfiyAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithCustomView:verfiyButton];
    self.navigationItem.rightBarButtonItem = rigthItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10,20, SCREEN_WIDTH - 2 * 10,30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.cornerRadius = 2;
    _textField.layer.masksToBounds = YES;
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    [self.view addSubview:_textField];
    
    if (self.selectIndex == 1)
    {
        _textField.keyboardType = UIKeyboardTypePhonePad;
    }
}

- (void)verfiyAction
{
    if (self.getInputBlock)
    {
        self.getInputBlock(_textField.text);
    }
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
