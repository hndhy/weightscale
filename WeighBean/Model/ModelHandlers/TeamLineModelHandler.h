//
//  TeamLineModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "TeamLineResponse.h"

@protocol TeamLineModelProtocol <NSObject>

- (void)syncFinished:(TeamLineResponse *)response;
- (void)syncFailure;

@end
@interface TeamLineModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<TeamLineModelProtocol> *)controller;

@end
