//
//  CheckInPickResultViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/10.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseViewController.h"
#import "UploadDakaModelHandler.h"
#import "UploadDakaModel.h"

@interface CheckInPickResultViewController : HTBaseViewController <UploadDakaModelProtocol>
{
    UIImageView *imageView;
    UIImage *resultImg;
}
@property (nonatomic,strong)UploadDakaModelHandler *handle;
@property (nonatomic,strong)UploadDakaModel *listModel;

- (id)initWithImg:(UIImage *)img;
@end
