//
//  HTAbstractDataSource.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTApiClient.h"

@class BaseResponse;

@protocol HTDataSourceDelegate <NSObject>
@required
- (void)dataDidLoad:(id)sender data:(BaseResponse*)data;  //加载数据成功，返回正确
- (void)netError:(id)sender error:(NSError*)error;  //网络异常
- (void)parseError:(id)sender error:(NSError*)error; //正常返回数据，解析失败
- (void)resultError:(id)sender data:(BaseResponse*)data; //正常返回数据，解析成功，服务端status非0
@end

// abstract class
@interface HTAbstractDataSource : NSObject
@property (nonatomic, readonly, weak) id<HTDataSourceDelegate> delegate;

- (id)initWithHandler:(id<HTDataSourceDelegate>)delegate;
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (void)postPath:(NSString*)path parameters:(NSDictionary*)parameters;
- (void)uploadImage:(NSString*)path parameters:(NSDictionary*)parameters image:(UIImage*)image imageName:(NSString*)imageName;
- (void)uploadImage:(NSString*)path parameters:(NSDictionary*)parameters images:(NSArray *)images imageNames:(NSArray *)imageNames;
- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error;

+ (NSDictionary *)mcommonParams;

@end
