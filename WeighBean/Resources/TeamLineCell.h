//
//  TeamLineCell.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamObjModel.h"

@protocol LikeDelegate <NSObject>

- (void)likeDidClickWithDakaID:(NSString *)dakaID;
- (void)commentDidClickWithDakaID:(NSString *)dakaID author:(NSString *)author;

@end

@interface TeamLineCell : UICollectionViewCell
{
    UIImageView *avatar;
    UILabel *nickName;
    UILabel *timeLbl;
    
    UIImageView *picView;
    UIView *containerView;
    
    UIButton *likeBtn;
    UIButton *commentBtn;
    NSMutableArray *favourArr;
    NSMutableArray *commentArr;
    
    UILabel *weightNumLbl;
    UILabel *weightRatioNumLbl;
    UILabel *innerNumLbl;
    UILabel *muscleNumLbl;

}
@property (nonatomic,strong) TeamObjModel *obj;
@property (nonatomic,strong) NSIndexPath *path;
@property (nonatomic, weak) id<LikeDelegate> delegate;

- (void)loadContent:(TeamObjModel *)obj path:(NSIndexPath *)path;


@end
