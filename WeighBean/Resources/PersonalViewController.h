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

@interface PersonalViewController : HTBaseViewController <UITableViewDelegate,UITableViewDataSource,PersonalListModelProtocol>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)PersonalListModelHandler *handle;
@property (nonatomic,strong)PersonalListModel *listModel;
//@property (nonatomic,strong)NSIndexPath *selectPath;

@end
