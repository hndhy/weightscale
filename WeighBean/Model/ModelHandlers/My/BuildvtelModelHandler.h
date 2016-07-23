//
//  BuildvtelModelHandler.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/13.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import "BuildvtelResponse.h"

@protocol BuildvtelModelProtocol <NSObject>

- (void)syncFinished:(BuildvtelResponse *)response;
- (void)syncFailure;

@end

@interface BuildvtelModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<BuildvtelModelProtocol> *)controller;

@end
