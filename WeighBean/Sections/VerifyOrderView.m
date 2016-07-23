//
//  VerifyOrderView.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/17.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "VerifyOrderView.h"
#import "AppMacro.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"
#import "OnlineOrderData.h"

@implementation VerifyOrderView

+ (instancetype)viewWithSelect:(void (^)(NSInteger index))selectBlock
{
    VerifyOrderView *view = [[VerifyOrderView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 200)];
    
    [view setSelectBlock:selectBlock];
    
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _productImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _productImage.backgroundColor = [UIColor orangeColor];
        [self addSubview:_productImage];
        
        _productPrice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10 ,80, 20)];
        _productPrice.font = [UIFont systemFontOfSize:14];
        _productPrice.textColor = UIColorFromRGB(255,161,5);
        _productPrice.textAlignment = NSTextAlignmentRight;
        _productPrice.text = @"￥499";
        [self addSubview:_productPrice];
        
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productImage.frame) + 10, 10 ,CGRectGetMinX(_productPrice.frame) - CGRectGetMaxX(_productImage.frame) - 20, 20)];
        _productName.font = [UIFont systemFontOfSize:14];
        _productName.textColor = UIColorFromRGB(77, 77, 77);
        _productName.text = @"体脂秤";
        [self addSubview:_productName];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 67 ,80, 28)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(77, 77, 77);
        label.text = @"支付金额";
        [self addSubview:label];
        
        _payPrice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 67 ,80, 28)];
        _payPrice.font = [UIFont systemFontOfSize:14];
        _payPrice.textColor = UIColorFromRGB(255,161,5);
        _payPrice.textAlignment = NSTextAlignmentRight;
        _payPrice.text = @"￥499";
        [self addSubview:_payPrice];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) ,80, 35)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(77, 77, 77);
        label.text = @"收货地址";
        [self addSubview:label];
        
        _address = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, CGRectGetMinY(label.frame) ,SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 20 - 10, 35)];
        _address.font = [UIFont systemFontOfSize:14];
        _address.textColor = UIColorFromRGB(102,102,102);
        _address.textAlignment = NSTextAlignmentRight;
        _address.placeholder = @"请输入收货地址";
        _address.enabled = NO;
        [self addSubview:_address];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) ,80, 35)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(77, 77, 77);
        label.text = @"联系电话";
        [self addSubview:label];
        
        _phone = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, CGRectGetMinY(label.frame) ,SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 20 - 10, 35)];
        _phone.font = [UIFont systemFontOfSize:14];
        _phone.textColor = UIColorFromRGB(102,102,102);
        _phone.textAlignment = NSTextAlignmentRight;
        _phone.placeholder = @"请输入手机号码";
        _phone.enabled = NO;
        [self addSubview:_phone];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) ,80, 35)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(77, 77, 77);
        label.text = @"联系姓名";
        [self addSubview:label];
        
        _name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, CGRectGetMinY(label.frame) ,SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 20 - 10, 35)];
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = UIColorFromRGB(102,102,102);
        _name.textAlignment = NSTextAlignmentRight;
        _name.placeholder = @"请输入你的姓名";
        _name.enabled = NO;
        [self addSubview:_name];
        
        for (int i = 0; i < 6; i ++)
        {
            CGFloat maxY = i == 0 ? 0 : (60 + 35*(i-1));
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(0, maxY, SCREEN_WIDTH, 0.5);
            line.backgroundColor = UIColorFromRGB(229, 229, 229).CGColor;
            [self.layer addSublayer:line];
            
            if (i == 2 || i == 3 || i == 4)
            {
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15, CGRectGetMaxY(line.frame) + 10, 9, 15)];
                icon.image = [UIImage imageNamed:@"arrow_right_icon"];
                [self addSubview:icon];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line.frame)+1, SCREEN_WIDTH, 33)];
                view.tag = 98 + i;
                [view addTapCallBack:self sel:@selector(modifyAction:)];
                [self insertSubview:view aboveSubview:_payPrice];
            }
        }
    }
    return self;
}

- (void)modifyAction:(UIGestureRecognizer *)gest
{
    if (self.selectBlock)
    {
        self.selectBlock(gest.view.tag - 100);
    }
}

- (void)refreshObj:(OnlineOrderData *)obj
{
    _productPrice.text = [NSString stringWithFormat:@"￥%@",obj.productPrice];
    _payPrice.text = [NSString stringWithFormat:@"￥%@",obj.payPirece];
    _productName.text = obj.productName;
    _address.text = obj.address;
    _phone.text = obj.phone;
    _name.text = obj.name;
}

@end
