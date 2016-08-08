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
    
    NSString *userid;
    NSString *teamid;
    NSString *teamname;
//    int ischat;
//    NSString *teamdescription;
    
    BOOL isEditType;
}

@property (nonatomic,strong) CreateCoachModelHandler *createCoachModelHandler;
@property (nonatomic,strong) CreateCoachModel *createCoachModel;

//- (id)initWithUserID:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)name isChat:(int)chat teamDescription:(NSString *)description;
- (id)initWithUserID:(NSString *)uid teamID:(NSString *)tid teamName:(NSString *)name;


@end
