//
//  HTApiClient.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTApiClient.h"
#import "Reachability.h"

//static NSString *const HTApiBaseURLString = @"http://123.57.20.86:80";
//static NSString *const HTApiBaseURLString = @"http://api.hao1da.com/";
static NSString *const HTApiBaseURLString = @"http://api.57spa.com/";

@implementation HTApiClient

+ (instancetype)sharedClient
{
  static HTApiClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    AFSecurityPolicy* policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    _sharedClient = [[HTApiClient alloc] initWithBaseURL:[NSURL URLWithString:HTApiBaseURLString]];
    [_sharedClient setSecurityPolicy:policy];
    _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
  });
  return _sharedClient;
}

- (BOOL)isNetworkAvailable
{
  Reachability* newtorkReachbility = [Reachability reachabilityForInternetConnection];
  NetworkStatus networkStatus = [newtorkReachbility currentReachabilityStatus];
  if (networkStatus == NotReachable) {
    return NO;
  }
  return YES;
}

@end
