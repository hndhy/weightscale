//
//  CoachListCell.h
//  WeighBean
//
//  Created by sealband on 16/8/4.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachObjModel.h"
#import "SWTableViewCell.h"
#import "MutiLabel.h"
#import "MGSwipeTableCell.h"

@interface CoachListCell : MGSwipeTableCell


{
    UIImageView *coachIcon;
    
    UILabel *title;
    MutiLabel *subTitle1;
    MutiLabel *subTitle2;
    UILabel *stataLbl;
    UIButton *joinBtn;
    UILabel *coachTypeLbl;
}

@property (nonatomic,strong) CoachObjModel *obj;
@property (nonatomic,copy) void (^selectBlock)(NSInteger index,CoachObjModel *obj,NSIndexPath *path);
@property (nonatomic,strong) NSIndexPath *path;
- (void)loadContent:(CoachObjModel *)obj path:(NSIndexPath *)path;

@end
