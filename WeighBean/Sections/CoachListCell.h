//
//  CoachListCell.h
//  WeighBean
//
//  Created by sealband on 16/8/4.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachObjModel.h"

@interface CoachListCell : UITableViewCell


{
    UIImageView *coachIcon;
    
    UILabel *title;
    UILabel *subTitle1;
    UILabel *subTitle2;
    UILabel *stataLbl;
    UIButton *joinBtn;
    UILabel *coachTypeLbl;
}

@property (nonatomic,strong) CoachObjModel *obj;
@property (nonatomic,copy) void (^selectBlock)(NSInteger index,CoachObjModel *obj,NSIndexPath *path);
@property (nonatomic,strong) NSIndexPath *path;
- (void)loadContent:(CoachObjModel *)obj path:(NSIndexPath *)path;

@end
