//
//  BaseResponse.m
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

+ (void)initKeyMapper
{
  [JSONModel setGlobalKeyMapper:[
            [JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"recommended_result" : @"recommendedResult",
                                                       @"count_comment" : @"countComment",
                                                       @"count_like" : @"countLike",
                                                       @"count_play" : @"countPlay",
                                                       @"zoneid" : @"zoneId",
                                                       @"count_share" : @"countShare",
                                                       @"count_collect" : @"countCollect",
                                                       @"subtitle" : @"subTitle",
                                                       @"city_name" : @"cityName",
                                                       @"share_link" : @"shareLink",
                                                       @"share_pic" : @"sharePic",
                                                       @"share_title" : @"shareTitle",
                                                       @"best_trip" : @"bestTrip",
                                                       @"stampid" : @"stampId",
                                                       @"spotid" : @"spotId",
                                                       @"totalcount" : @"totalCount",
                                                       @"techanid" : @"techanId",
                                                       @"zuimeiid" : @"zuimeiId",
                                                       @"timestamp" : @"timesTamp",
                                                       @"lgid" : @"lgId",
                                                       @"company_name" : @"companyName",
                                                       @"id" : @"hid",
                                                       @"searchid" : @"searchId",
                                                       @"sorttime" : @"sortTime",
                                                       @"resultsize" : @"resultSize",
                                                       @"collect_count" : @"collectCount",
                                                       @"comment_count" : @"commentCount",
                                                       @"like_count" : @"likeCount",
                                                       @"share_count" : @"shareCount",
                                                       @"opentime" : @"openTime",
                                                       @"address" : @"address",
                                                       @"coordxy" : @"gaodeCoordxy",
                                                       @"lideid" : @"lideId",
                                                       @"sellerid" : @"sellerId",
                                                       @"hdurl" : @"hdUrl"
                                                      }
                                 ]
  ];
}

@end
