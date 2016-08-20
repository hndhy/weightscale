//
//  CheckInReleaseViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/14.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "UploadDakaModelHandler.h"
#import "UploadDakaModel.h"

@interface CheckInReleaseViewController : HTBaseViewController <UploadDakaModelProtocol>
{
    UIImageView *imageView;
    UIImage *resultImg;
    NSMutableArray *sourceArr;
}
@property (nonatomic,strong)UploadDakaModelHandler *handle;
@property (nonatomic,strong)UploadDakaModel *listModel;
- (id)initWithImg:(UIImage *)img selectedArr:(NSMutableArray *)arr;
@end
