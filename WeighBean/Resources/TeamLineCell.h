//
//  TeamLineCell.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamLineCell : UICollectionViewCell
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

@end
