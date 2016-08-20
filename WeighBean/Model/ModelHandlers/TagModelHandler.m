//
//  TagModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TagModelHandler.h"

@implementation TagModelHandler
- (id)initWithController:(HTBaseViewController<TagModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<TagModelProtocol> *controller = (HTBaseViewController<TagModelProtocol>*)self.controller;
    [controller syncFinished:(TagResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<TagModelProtocol> *controller = (HTBaseViewController<TagModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<TagModelProtocol> *controller = (HTBaseViewController<TagModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<TagModelProtocol> *controller = (HTBaseViewController<TagModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
