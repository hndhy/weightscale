//
//  LikeModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "LikeModelHandler.h"

@implementation LikeModelHandler
- (id)initWithController:(HTBaseViewController<LikeModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<LikeModelProtocol> *controller = (HTBaseViewController<LikeModelProtocol>*)self.controller;
    [controller likeFinished:(LikeResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<LikeModelProtocol> *controller = (HTBaseViewController<LikeModelProtocol>*)self.controller;
    [controller likeFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<LikeModelProtocol> *controller = (HTBaseViewController<LikeModelProtocol>*)self.controller;
    [controller likeFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<LikeModelProtocol> *controller = (HTBaseViewController<LikeModelProtocol>*)self.controller;
    [controller likeFailure];
}
@end
