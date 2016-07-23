//
//  TrendModelHandler.m
//  WeighBean
//
//  Created by 曾宪东 on 15/12/10.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "TrendModelHandler.h"

@implementation TrendModelHandler


- (id)initWithController:(HTBaseViewController<TrendModelProtocol> *)controller
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<TrendModelProtocol> *controller = (HTBaseViewController<TrendModelProtocol>*)self.controller;
    [controller syncFinished:(TrendResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<TrendModelProtocol> *controller = (HTBaseViewController<TrendModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<TrendModelProtocol> *controller = (HTBaseViewController<TrendModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<TrendModelProtocol> *controller = (HTBaseViewController<TrendModelProtocol>*)self.controller;
    [controller syncFailure];
}

@end
