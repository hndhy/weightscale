//
//  CoachNewTypeViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/5.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface CoachNewTypeViewController : HTBaseViewController
{
    UIView *fatLossBackView;
    UIView *muscleGainBackView;
    UIView *goalSetBackView;
    
    UILabel *fatLossLbl;
    UILabel *muscleGainLbl;
    UITextView *fatLossTextView;
    UITextView *muscleGainTextView;
    UIButton *confirmBtn;
    UIButton *shareBtn;
    
    int currentNewType;
}
- (void)createType:(int)type;

@end
