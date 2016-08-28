//
//  LikeModel.h
//  WeighBean
//
//  Created by sealband on 16/8/27.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "LikeResponse.h"

@interface LikeModel : HTAbstractDataSource
- (void)postLikeWithPicID:(NSString *)picID;

@end
