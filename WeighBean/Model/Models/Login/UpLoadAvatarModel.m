//
//  UpLoadAvatarModel.m
//  WeighBean
//
//  Created by liumadu on 15/8/10.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UpLoadAvatarModel.h"
#import "HTAppContext.h"

@implementation UpLoadAvatarModel

- (void)uploadAvatarWithImage:(UIImage *)image
{
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
  [self uploadImage:@"/uploadAvatar.htm" parameters:parameters image:image imageName:@"avatar"];
}

- (void)uploadPhotoWithImage:(UIImage *)image tag:(NSString*)tag
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    [parameters setValue:tag forKey:@"tag"];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [self uploadImage:@"/uploadPaizhao.htm" parameters:parameters image:image imageName:@"image"];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[UploadAvatarResponse alloc] initWithDictionary:responseDict error:error];
}

@end
