//
//  VerifyOrderView.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/17.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OnlineOrderData;
@interface VerifyOrderView : UIView
{
    UIImageView *_productImage;
    UILabel *_productName;
    UILabel *_productPrice;
    UILabel *_payPrice;
    
    UITextField *_address;
    UITextField *_phone;
    UITextField *_name;
}
@property (nonatomic,copy) void (^selectBlock)(NSInteger index);

+ (instancetype)viewWithSelect:(void (^)(NSInteger index))selectBlock;

- (void)refreshObj:(OnlineOrderData *)obj;

@end
