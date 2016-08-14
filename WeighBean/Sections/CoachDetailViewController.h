//
//  CoachDetailViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/9.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "ViewCoachDetailModel.h"
#import "ViewCoachDetailModelHandler.h"

@interface CoachDetailViewController : HTBaseViewController <ViewCoachDetailModelProtocol>
{
    UIScrollView *scrollView;
    
    NSString *teamID;
    
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

    
    UIView *lineView1;
    UIView *lineView2;
    UIView *lineView3;
    UIView *lineView4;
    UIView *lineView5;
    UIView *lineView6;
    UIView *lineView7;
    UIView *lineView8;
    UIView *lineView9;
    UIView *lineView10;
}
@property (nonatomic,strong)ViewCoachDetailModelHandler *viewCoachDetailModelHandler;
@property (nonatomic,strong)ViewCoachDetailModel *viewCoachDetailModel;

- (id)initWithTeamID:(NSString *)tid;
@end
