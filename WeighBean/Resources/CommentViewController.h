//
//  CommentViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/28.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "CommentModelHandler.h"
#import "CommentModel.h"

@interface CommentViewController : HTBaseViewController

{
    UIView *commentBackView;
    UILabel *commentLbl;
    UITextView *commentTextView;
    UIButton *confirmBtn;
    
    NSString *daka;
    NSString *authorName;
}
@property (nonatomic,strong)CommentModelHandler *handle;
@property (nonatomic,strong)CommentModel *listModel;
- (id)initWithDakaID:(NSString *)dakaID anthor:(NSString *)author;

@end
