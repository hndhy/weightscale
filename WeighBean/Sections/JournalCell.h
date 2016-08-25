//
//  JournalCell.h
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JournalObjModel.h"
@interface JournalCell : UICollectionViewCell
{
    UIImageView *picView;
    
}

@property (nonatomic,strong) JournalObjModel *obj;
@property (nonatomic,strong) NSIndexPath *path;

- (void)loadContent:(JournalObjModel *)obj path:(NSIndexPath *)path;

@end
