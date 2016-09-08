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
#import "TeamLineViewController.h"
#import "AvatarAndNickView.h"

@interface CoachDetailViewController : HTBaseViewController <ViewCoachDetailModelProtocol>
{
    UIScrollView *scrollView;
    
    NSString *teamID;
    
    
    BOOL isIngTitleOpened;
    BOOL isComPeopleOpened;
    BOOL isIngDataOpened;
    BOOL isComDataOpened;
    
    UIView *ingActiveRatioContainerView;
    UIView *comPeopleContainerView;
    
    UIView *ingDataContainerView;
    UIView *ingAndComValidContainerView;
    UIView *comDataContainerView;

    
    UILabel *coachNameLbl;
    UIButton *coachTypeLbl;
    UILabel *startTimeLbl;
    UILabel *endTimeLbl;
    UILabel *teamIdLbl;
    
//     *brisk_num;
//     *sum_num;
    UILabel *activeRatioLbl;
    UILabel *comPeopleLbl;
    
    UIImageView *activeRatioImgView;
    UIImageView *comPeopleImgView;

    UIScrollView *activeRatioScrollView;
    UIScrollView *comPeopleScrollView;
    
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
