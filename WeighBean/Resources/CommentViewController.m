//
//  CommentViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/28.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CommentViewController.h"

@implementation CommentViewController

- (id)initWithDakaID:(NSString *)dakaID anthor:(NSString *)author
{
    self = [super init];
    if (self) {
        daka = dakaID;
        authorName = author;
    }
    return self;
}
- (void)initModel
{
    self.handle = [[CommentModelHandler alloc] initWithController:self];
    self.listModel = [[CommentModel alloc] initWithHandler:self.handle];

}

- (void)initView
{
    self.title = @"评论";
    commentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, DEVICEW, 160)];
    commentBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentBackView];
    
    commentLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 40)];
    commentLbl.backgroundColor = [UIColor clearColor];
    [commentLbl setTextColor:[UIColor blackColor]];
    [commentLbl setFont:[UIFont systemFontOfSize:15]];
    [commentLbl setText:@"评论内容:"];
    [commentBackView addSubview:commentLbl];
    
    commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(8, commentLbl.bottom, DEVICEW-16, 120)];
    commentTextView.backgroundColor = [UIColor clearColor];
    [commentTextView setTextColor:[UIColor grayColor]];
    [commentTextView setFont:[UIFont systemFontOfSize:12]];
    [commentBackView addSubview:commentTextView];
    
    
    //确认和分享按钮
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15,commentBackView.bottom+40,DEVICEW-30,40);
    confirmBtn.backgroundColor = BLUECOLOR;
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

- (void)btnAction:(id)sender
{
    [self.listModel postCommentWithDakaID:daka author:authorName comment:commentTextView.text];
}

- (void)commentFinished:(CommentResponse *)response
{
    [self alert:@"成功" message:response.msg delegate:nil cancelTitle:@"确定" otherTitles:nil];
}
- (void)commentFailure
{
    
}


@end
