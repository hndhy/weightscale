//
//  AvatarAndNickView.h
//  WeighBean
//
//  Created by sealband on 16/8/26.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brisk_listModel.h"
#import "sum_listModel.h"

@interface AvatarAndNickView : UIView
{
    UIImageView *avatar;
    UILabel *nick;
}

- (void)setInfoActive:(brisk_listModel *)obj;
- (void)setInfoSum:(sum_listModel *)obj;

@end
