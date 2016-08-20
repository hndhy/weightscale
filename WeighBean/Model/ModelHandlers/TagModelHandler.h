//
//  TagModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "TagResponse.h"


@protocol TagModelProtocol <NSObject>

- (void)syncFinished:(TagResponse *)response;
- (void)syncFailure;

@end

@interface TagModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<TagModelProtocol> *)controller;

@end
