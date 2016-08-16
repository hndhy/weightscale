//
//  PersonalListModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "PersonalListResponse.h"

@protocol PersonalListModelProtocol <NSObject>

- (void)syncFinished:(PersonalListResponse *)response;
- (void)syncFailure;

@end

@interface PersonalListModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<PersonalListModelProtocol> *)controller;

@end
