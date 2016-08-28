//
//  CommentModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/29.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "CommentResponse.h"

@protocol CommentModelProtocol <NSObject>

- (void)commentFinished:(CommentResponse *)response;
- (void)commentFailure;


@end
@interface CommentModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<CommentModelProtocol> *)controller;

@end
