//
//  JournalModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JournalModelHandler.h"

@implementation JournalModelHandler
- (id)initWithController:(HTBaseViewController<JournalModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<JournalModelProtocol> *controller = (HTBaseViewController<JournalModelProtocol>*)self.controller;
    [controller syncFinished:(JournalResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<JournalModelProtocol> *controller = (HTBaseViewController<JournalModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<JournalModelProtocol> *controller = (HTBaseViewController<JournalModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<JournalModelProtocol> *controller = (HTBaseViewController<JournalModelProtocol>*)self.controller;
    [controller syncFailure];
}


@end
