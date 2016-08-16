//
//  PersonalCell.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCell : UITableViewCell
{

    UIImageView *avatar;
    UILabel *nickName;
    UILabel *timeLbl;
    
    UIImageView *picView;
    
    UILabel *likeLbl;
    UIButton *commentBtn;
    NSMutableArray *favourArr;
    NSMutableArray *commentArr;
    
}

//@property (nonatomic,strong) CoachObjModel *obj;
//@property (nonatomic,copy) void (^selectBlock)(NSInteger index,CoachObjModel *obj,NSIndexPath *path);
@property (nonatomic,strong) NSIndexPath *path;
//@property (nonatomic, weak) id<CoachCellDelegate> coachCellDelegate;
//
//- (void)loadContent:(CoachObjModel *)obj path:(NSIndexPath *)path;

@end
