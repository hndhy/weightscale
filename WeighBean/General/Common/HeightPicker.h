//
//  HeightPicker.h
//  WeighBean
//
//  Created by liumadu on 15/8/11.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol HeightPickerProtocol <NSObject>
@required
- (void)selectHeight:(NSString *)height;
@end


@interface HeightPicker : NSObject

- (id)initWithController:(UIViewController<HeightPickerProtocol> *)controller;
- (void)showHeightPicker;

@end
