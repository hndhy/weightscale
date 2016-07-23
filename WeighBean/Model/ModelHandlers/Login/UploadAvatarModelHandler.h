//
//  UploadAvatarModelHandler.h
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@class UploadAvatarResponse;

@protocol UploadAvatarModelProtocol <NSObject>

- (void)uploadAvatarFinished:(UploadAvatarResponse *)response;

@end

@interface UploadAvatarModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<UploadAvatarModelProtocol> *)controller;

@end
