//
//  CommentModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/29.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CommentModelHandler.h"

@implementation CommentModelHandler
- (id)initWithController:(HTBaseViewController<CommentModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<CommentModelProtocol> *controller = (HTBaseViewController<CommentModelProtocol>*)self.controller;
    [controller commentFinished:(CommentResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<CommentModelProtocol> *controller = (HTBaseViewController<CommentModelProtocol>*)self.controller;
    [controller commentFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<CommentModelProtocol> *controller = (HTBaseViewController<CommentModelProtocol>*)self.controller;
    [controller commentFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<CommentModelProtocol> *controller = (HTBaseViewController<CommentModelProtocol>*)self.controller;
    [controller commentFailure];
}

@end
