//
//  CoachDetailViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/9.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface CoachDetailViewController : HTBaseViewController
{
    UIScrollView *scrollView;
    
    
    
    UILabel *coachNameLbl;
    UILabel *coachTypeLbl;
    UILabel *startTimeLbl;
    UILabel *endTimeLbl;
    UILabel *teamIdLbl;
    
//     *brisk_num;
//     *sum_num;
    UILabel *activeRatioLbl;
    
    UILabel *meanfatLbl;
    UILabel *loseWeightRatioLbl;
    UILabel *muscleBuilderLbl;
    UILabel *dynamiteRatioLbl;
    
    UILabel *underwayRatioLbl;
    UILabel *completeRatioLbl;
    
    UILabel *meanfat_completeLbl;
    UILabel *loseWeight_completeRatioLbl;
    UILabel *muscleBuilder_completeLbl;
    UILabel *dynamite_completeRatioLbl;

    
}
@end
