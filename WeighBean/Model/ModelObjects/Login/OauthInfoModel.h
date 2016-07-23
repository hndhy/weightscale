//
//  OauthInfoModel.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <JSONModel.h>

@protocol OauthInfoModel

@end

@interface OauthInfoModel : JSONModel

@property (nonatomic, assign) int olsid;
@property (nonatomic, copy) NSString* oauthUid;
@property (nonatomic, copy) NSString* oauthToken;
@property (nonatomic, copy) NSString* oauthUnick;
@property (nonatomic, copy) NSDate* expireDate;

@end
