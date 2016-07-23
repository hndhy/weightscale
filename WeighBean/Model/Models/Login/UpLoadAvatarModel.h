//
//  UpLoadAvatarModel.h
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

#import "UploadAvatarResponse.h"

@interface UpLoadAvatarModel : HTAbstractDataSource

- (void)uploadAvatarWithImage:(UIImage *)image;

- (void)uploadPhotoWithImage:(UIImage *)image tag:(NSString*)tag;

@end
