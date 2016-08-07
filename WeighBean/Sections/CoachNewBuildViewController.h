//
//  CoachNewBuildViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/6.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "CreateCoachModelHandler.h"
#import "CreateCoachModel.h"

@interface CoachNewBuildViewController : HTBaseViewController<CreateCoachModelProtocol>

{
    UILabel *coachNameLabel;
    UILabel *allowExchangeLabel;
    UILabel *introductionLabel;
    
    UIButton *nameBtn;
    UISwitch *allowSwitch;
    UILabel *introDetailLabel;
    
    UIButton *buildBtn;
}

@property (nonatomic,strong) CreateCoachModelHandler *createCoachModelHandler;
@property (nonatomic,strong) CreateCoachModel *createCoachModel;

@end
