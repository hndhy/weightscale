//
//  PersonalViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "PersonalListModel.h"
#import "PersonalListModelHandler.h"
#import "LikeModelHandler.h"
#import "LikeModel.h"
#import "PersonalCell.h"
#import "CommentViewController.h"


@interface PersonalViewController : HTBaseViewController <UITableViewDelegate,UITableViewDataSource,PersonalListModelProtocol,LikeDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    NSString *userid;
}

@property (nonatomic,strong)PersonalListModelHandler *handle;
@property (nonatomic,strong)PersonalListModel *listModel;

@property (nonatomic,strong)LikeModelHandler *likeHandle;
@property (nonatomic,strong)LikeModel *likeModel;
//@property (nonatomic,strong)NSIndexPath *selectPath;
- (id)initPersonalUid:(NSString *)userID;

@end
