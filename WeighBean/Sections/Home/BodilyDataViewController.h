//
//  BodilyDataViewController.h
//  WeighBean
//
//  Created by heng on 15/8/13.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTTableViewController.h"
#import "JournalCell.h"
#import "JournalModelHandler.h"
#import "JournalModel.h"

@interface BodilyDataViewController : HTTableViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    NSString *dataType;
    UIImageView *popView;
    UIView *maskview;
    BOOL isListShowed;

    NSDate *startTimesp;
    NSDate *endTimesp;
    NSMutableArray *_dataArray;
    int currentPage;
}
@property (nonatomic,strong)JournalModelHandler *handle;
@property (nonatomic,strong)JournalModel *listModel;

@property (nonatomic, strong) UICollectionView *collection;

@property(nonatomic,strong)NSMutableArray *bodilyArray;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *avatar;
- (id)initWithType:(NSString *)type;

@end
