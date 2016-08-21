//
//  TeamLineCell.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamObjModel.h"
@interface TeamLineCell : UICollectionViewCell
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
@property (nonatomic,strong) TeamObjModel *obj;
@property (nonatomic,strong) NSIndexPath *path;

- (void)loadContent:(TeamObjModel *)obj path:(NSIndexPath *)path;


@end
