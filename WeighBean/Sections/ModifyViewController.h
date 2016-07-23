//
//  ModifyViewController.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface ModifyViewController : HTBaseViewController
{
    UITextField *_textField;
}
@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,copy) void (^getInputBlock)(NSString *str);

@end
