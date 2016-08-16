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

@interface TeamLineViewController : HTBaseViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collection;
    //    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)TeamLineModelHandler *handle;
@property (nonatomic,strong)TeamListModel *listModel;
@end
