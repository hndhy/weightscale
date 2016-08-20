//
//  CheckInChooseTagViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "TagModelHandler.h"
#import "TagModel.h"

@interface CheckInChooseTagViewController : HTBaseViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,TagModelProtocol>

{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    NSMutableArray *selectedArr;
    NSMutableArray *selectedDataArr;
    
    UIImageView *sourceImageView;
    UIImage *sourceImg;
}
@property (nonatomic,strong)TagModelHandler *handle;
@property (nonatomic,strong)TagModel *listModel;

- (id)initWithImage:(UIImage *)img;
@end
