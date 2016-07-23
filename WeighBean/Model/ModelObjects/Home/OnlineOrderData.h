//
//  OnlineOrderData.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/18.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineOrderData : NSObject

@property (nonatomic,copy) NSString *productImgUrl;

@property (nonatomic,copy) NSString *productName;

@property (nonatomic,copy) NSString *productPrice;

@property (nonatomic,copy) NSString *payPirece;

@property (nonatomic,copy) NSString *address; // 收货地址

@property (nonatomic,copy) NSString *name; // 收货人姓名

@property (nonatomic,copy) NSString *phone; // 收货人电话

@end
