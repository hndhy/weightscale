//
//  UploadDakaModel.m
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "UploadDakaModel.h"
#import "HTAppContext.h"
@implementation UploadDakaModel
- (void)uploadDakaWithImage:(UIImage *)img;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    HTAppContext *appContext = [HTAppContext sharedContext];
    [parameters setValue:appContext.uid forKey:@"uid"];
    [parameters setValue:@"1" forKey:@"type"];
//    [self getPath:@"api/data/AddDaka" parameters:parameters];
    [self uploadImage:@"api/data/AddDaka" parameters:parameters image:img imageName:@"imageDaka"];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[UploadDakaResponse alloc] initWithDictionary:responseDict error:error];
}
@end
