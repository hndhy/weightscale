//
//  PersonalCell.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalObjModel.h"
@interface PersonalCell : UITableViewCell
{

    UIImageView *avatar;
    UILabel *nickName;
    UILabel *timeLbl;
    
    UIImageView *picView;
    
    UIButton *likeBtn;
    UIButton *commentBtn;
    NSMutableArray *favourArr;
    NSMutableArray *commentArr;
    
}

@property (nonatomic,strong) PersonalObjModel *obj;
//@property (nonatomic,copy) void (^selectBlock)(NSInteger index,CoachObjModel *obj,NSIndexPath *path);
@property (nonatomic,strong) NSIndexPath *path;
//@property (nonatomic, weak) id<CoachCellDelegate> coachCellDelegate;
//
- (void)loadContent:(PersonalObjModel *)obj path:(NSIndexPath *)path;

@end
