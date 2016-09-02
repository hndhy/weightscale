//
//  TeamLineViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "TeamListModel.h"
#import "TeamLineModelHandler.h"
#import "LikeModelHandler.h"
#import "LikeModel.h"
#import "TeamLineCell.h"
#import "CommentViewController.h"

@interface TeamLineViewController : HTBaseViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LikeDelegate,UIScrollViewDelegate>
{
    UICollectionView *collection;
    NSMutableArray *_dataArray;
    NSString *teamid;
    int startFormCurrent;
}

@property (nonatomic,strong)TeamLineModelHandler *handle;
@property (nonatomic,strong)TeamListModel *listModel;

@property (nonatomic,strong)LikeModelHandler *likeHandle;
@property (nonatomic,strong)LikeModel *likeModel;

- (id)initWithTeamID:(NSString *)tid;

@end
