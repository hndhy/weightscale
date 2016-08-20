//
//  UploadDakaModelHandler.m
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "UploadDakaModelHandler.h"

@implementation UploadDakaModelHandler
- (id)initWithController:(HTBaseViewController<UploadDakaModelProtocol> *)controller;
{
    return [super initWithController:controller];
}

- (void)dataDidLoad:(id)sender data:(BaseResponse*)data
{
    [super dataDidLoad:sender data:data];
    HTBaseViewController<UploadDakaModelProtocol> *controller = (HTBaseViewController<UploadDakaModelProtocol>*)self.controller;
    [controller syncFinished:(UploadDakaResponse *)data];
}

- (void)netError:(id)sender error:(NSError*)error
{
    [super netError:sender error:error];
    HTBaseViewController<UploadDakaModelProtocol> *controller = (HTBaseViewController<UploadDakaModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)parseError:(id)sender error:(NSError*)error
{
    [super parseError:sender error:error];
    HTBaseViewController<UploadDakaModelProtocol> *controller = (HTBaseViewController<UploadDakaModelProtocol>*)self.controller;
    [controller syncFailure];
}

- (void)resultError:(id)sender data:(BaseResponse*)data
{
    [super resultError:sender data:data];
    HTBaseViewController<UploadDakaModelProtocol> *controller = (HTBaseViewController<UploadDakaModelProtocol>*)self.controller;
    [controller syncFailure];
}
@end
