//
//  CommentModel.h
//  WeighBean
//
//  Created by sealband on 16/8/29.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "CommentResponse.h"

@interface CommentModel : HTAbstractDataSource
- (void)postCommentWithDakaID:(NSString *)dakaID author:(NSString *)author comment:(NSString *)comment;

@end
