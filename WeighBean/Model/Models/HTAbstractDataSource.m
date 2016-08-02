//
//  HTAbstractDataSource.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "NSDictionary+UrlEncoding.h"
#import "NSString+Additions.h"
#import "HTAppContext.h"
#import "BaseResponse.h"
#import "UtilsMacro.h"

typedef  void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef  void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation HTAbstractDataSource

- (id)initWithController:(UIViewController<HTDataSourceDelegate>*)delegate
{
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

- (id)initWithHandler:(id<HTDataSourceDelegate>)delegate
{
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

- (NSDictionary*)getCommonParameters
{
  NSMutableDictionary *commonParameters = [NSMutableDictionary dictionaryWithCapacity:5];
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
  [commonParameters setValue:appVersion forKey:@"appversion"];
  [commonParameters setValue:@"ios" forKey:@"platform"];
  
  HTAppContext *appContext = [HTAppContext sharedContext];
  if (ISEMPTY(appContext.uid)) {
      [commonParameters setValue:appContext.uid forKey:@"uid"];
  }
    
  if (ISEMPTY(appContext.uid) || [@"-1" isEqualToString:appContext.uid]) {
    [commonParameters setValue:@"" forKey:@"token"];
  } else {
    [commonParameters setValue:appContext.uid forKey:@"token"];
  }
  return commonParameters;
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
  HTApiClient *client = [HTApiClient sharedClient];
  if (![client isNetworkAvailable]) {
    NSLog(@"network unavailable");
    [self.delegate netError:self error:nil];
    return;
  }
  NSString *commonParameters = [[self getCommonParameters] urlEncodedString];
  NSString *newPath = [path URLStringByAppendingQueryString:commonParameters];
  __weak __typeof(self) weakSelf = self;
  [client GET:newPath parameters:parameters
      success:[self getSuccessBlock:weakSelf]
      failure:[self getFailureBlock:weakSelf]
   ];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters
{
  HTApiClient *client = [HTApiClient sharedClient];
  if (![client isNetworkAvailable]) {
    NSLog(@"network unavailable");
    [self.delegate netError:self error:nil];
    return;
  }
  [client.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
  NSString *commonParameters = [[self getCommonParameters] urlEncodedString];
  NSString *newPath = [path URLStringByAppendingQueryString:commonParameters];
  __weak __typeof(self) weakSelf = self;
  [client POST:newPath parameters:parameters
       success:[self getSuccessBlock:weakSelf]
       failure:[self getFailureBlock:weakSelf]
   ];
}

- (void)uploadImage:(NSString*)path parameters:(NSDictionary*)parameters image:(UIImage*)image imageName:(NSString*)imageName
{
  HTApiClient *client = [HTApiClient sharedClient];
  if (![client isNetworkAvailable]) {
    NSLog(@"network unavailable");
    [self.delegate netError:self error:nil];
    return;
  }
  [client.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
  NSString* commonParameters = [[self getCommonParameters] urlEncodedString];
  NSString* newPath = [path URLStringByAppendingQueryString:commonParameters];
  NSData* imageData = UIImageJPEGRepresentation(image, 0.5);
  __weak __typeof(self) weakSelf = self;
  [client POST:newPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/jpeg"];
  }
       success:[self getSuccessBlock:weakSelf]
       failure:[self getFailureBlock:weakSelf]
   ];
}

- (void)uploadImage:(NSString*)path parameters:(NSDictionary*)parameters images:(NSArray *)images imageNames:(NSArray *)imageNames
{
  HTApiClient *client = [HTApiClient sharedClient];
  if (![client isNetworkAvailable]) {
    NSLog(@"network unavailable");
    [self.delegate netError:self error:nil];
    return;
  }
  NSString* commonParameters = [[self getCommonParameters] urlEncodedString];
  NSString* newPath = [path URLStringByAppendingQueryString:commonParameters];
  __weak __typeof(self) weakSelf = self;
  [client POST:newPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    NSUInteger len = images.count;
    for (int i = 0; i < len; i++) {
      UIImage *image = [images objectAtIndex:i];
      NSData* imageData = UIImageJPEGRepresentation(image, 0.5);
      NSString *imageName = [imageNames objectAtIndex:i];
      [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/jpeg"];
    }
  }
       success:[self getSuccessBlock:weakSelf]
       failure:[self getFailureBlock:weakSelf]
   ];
}

- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
  return [[BaseResponse alloc] initWithDictionary:responseDict error:error];
}

//- (GAApiClient *)getClient
//{
//  GAApiClient* client = [GAApiClient sharedClient];
//  GAAppContext *appContext = [GAAppContext sharedContext];
//  [client.requestSerializer setValue:appContext.cookie forHTTPHeaderField:@"cookie"];
//  return client;
//}

- (SuccessBlock)getSuccessBlock:(HTAbstractDataSource*)weakSelf
{
  return ^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"network success:%@", responseObject);
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
      // parse response
      NSDictionary* responseDict = (NSDictionary*)responseObject;
      NSError* error = nil;
      BaseResponse* responseModel = nil;
      @try {
        responseModel = [weakSelf parseResponse:responseDict error:&error];
      }
      @catch (NSException *exception) {
        NSLog(@"parse error:%@", exception);
      }
      if (nil == responseModel || error) {
        responseModel = [[BaseResponse alloc] initWithDictionary:responseDict error:&error];
        if (nil != responseModel && 1 != responseModel.status) {
          NSLog(@"result error:%@", responseModel);
          [weakSelf.delegate resultError:weakSelf data:responseModel];
        } else {
          NSLog(@"parse failed:%@", error);
          [weakSelf.delegate parseError:weakSelf error:error];
        }
      } else {
        if (200 == responseModel.status) {
          NSLog(@"response model:%@", responseModel);
          [weakSelf.delegate dataDidLoad:weakSelf data:responseModel];
        } else {
          NSLog(@"result error:%@", responseModel);
          [weakSelf.delegate resultError:weakSelf data:responseModel];
        }
      }
    } else {
      NSLog(@"network error: not dictionary");
      [weakSelf.delegate netError:weakSelf error:nil];
    }
  };
}

- (FailureBlock)getFailureBlock:(HTAbstractDataSource*)weakSelf
{
  return ^(AFHTTPRequestOperation *operation, NSError *error) {
    [weakSelf.delegate netError:weakSelf error:error];
  };
}

+ (NSDictionary *)mcommonParams{
    NSMutableDictionary *commonParameters = [NSMutableDictionary dictionaryWithCapacity:5];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [commonParameters setValue:appVersion forKey:@"appversion"];
    [commonParameters setValue:@"ios" forKey:@"platform"];
    
    HTAppContext *appContext = [HTAppContext sharedContext];
    if (ISEMPTY(appContext.uid)) {
        [commonParameters setValue:appContext.uid forKey:@"uid"];
    }
    
    if (ISEMPTY(appContext.uid) || [@"-1" isEqualToString:appContext.uid]) {
        [commonParameters setValue:@"" forKey:@"token"];
    } else {
        [commonParameters setValue:appContext.uid forKey:@"token"];
    }
    return commonParameters;
}


@end
