//
//  CheckInChooseTagViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"

@interface CheckInChooseTagViewController : HTBaseViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    NSMutableArray *selectedArr;
    NSMutableArray *selectedDataArr;
    
    UIImageView *sourceImageView;
    UIImage *sourceImg;
}
- (id)initWithImage:(UIImage *)img;
@end
