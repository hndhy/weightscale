//
//  CheckInReleaseViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface CheckInReleaseViewController : HTBaseViewController
{
    UIImageView *imageView;
    UIImage *resultImg;
    NSMutableArray *sourceArr;
}
- (id)initWithImg:(UIImage *)img selectedArr:(NSMutableArray *)arr;
@end
