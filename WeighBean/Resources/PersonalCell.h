//
//  PersonalCell.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalObjModel.h"


@protocol LikeDelegate <NSObject>

- (void)likeDidClickWithDakaID:(NSString *)dakaID;
- (void)commentDidClickWithDakaID:(NSString *)dakaID author:(NSString *)author;

@end
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

@property (nonatomic, weak) id<LikeDelegate> delegate;

- (void)loadContent:(PersonalObjModel *)obj path:(NSIndexPath *)path;

@end
