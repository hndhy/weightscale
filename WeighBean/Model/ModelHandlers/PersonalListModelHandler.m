//
//  PersonalListModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "PersonalListModelHandler.h"

@implementation PersonalListModelHandler

- (id)initWithController:(HTBaseViewController<PersonalListModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<PersonalListModelProtocol> *controller = (HTBaseViewController<PersonalListModelProtocol>*)self.controller;
    [controller syncFinished:(PersonalListResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<PersonalListModelProtocol> *controller = (HTBaseViewController<PersonalListModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<PersonalListModelProtocol> *controller = (HTBaseViewController<PersonalListModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<PersonalListModelProtocol> *controller = (HTBaseViewController<PersonalListModelProtocol>*)self.controller;
    [controller syncFailure];
}
@end
