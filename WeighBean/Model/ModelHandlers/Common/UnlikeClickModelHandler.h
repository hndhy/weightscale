//
//  UnlikeClickModelHandler.h
//  HereTravel
//
//  Created by liumadu on 15/6/25.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"

@protocol UnlikeClickModelProtocol<NSObject>

- (void)unlikeClickFinished:(BaseResponse *)response;

@end

@interface UnlikeClickModelHandler : HTBaseModelHandler

- (id)initWithController:(HTBaseViewController<UnlikeClickModelProtocol> *)controller;

@end
