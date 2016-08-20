//
//  UploadDakaModel.h
//  WeighBean
//
//  Created by sealband on 16/8/20.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"
#import "UploadDakaResponse.h"

@interface UploadDakaModel : HTAbstractDataSource
- (void)uploadDakaWithImage:(UIImage *)img;
@end
