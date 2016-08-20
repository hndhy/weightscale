//
//  UploadDakaModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "UploadDakaResponse.h"

@protocol UploadDakaModelProtocol <NSObject>

- (void)syncFinished:(UploadDakaResponse *)response;
- (void)syncFailure;

@end

@interface UploadDakaModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<UploadDakaModelProtocol> *)controller;

@end
