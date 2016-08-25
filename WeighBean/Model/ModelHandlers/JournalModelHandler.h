//
//  JournalModelHandler.h
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "JournalResponse.h"

@protocol JournalModelProtocol <NSObject>

- (void)syncFinished:(JournalResponse *)response;
- (void)syncFailure;


@end
@interface JournalModelHandler : HTBaseModelHandler
- (id)initWithController:(HTBaseViewController<JournalModelProtocol> *)controller;

@end
