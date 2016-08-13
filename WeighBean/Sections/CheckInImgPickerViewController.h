//
//  CheckInImgPickerViewController.h
//  WeighBean
//
//  Created by sealband on 16/8/13.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTBaseModelHandler.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CheckInImageAlbumViewController.h"

@class CheckInImgPickerViewController;
@protocol CheckInImgPickerDelegate <NSObject>

@required
- (void)imagePicker:(CheckInImgPickerViewController *)picker selectIndex:(NSUInteger)index asset:(ALAsset *)al;

@end



@interface CheckInImgPickerViewController : HTBaseViewController <UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collection;
    BOOL reloadPhotosFlag;
    
    UILabel *labTitle;
    UIButton *btnClose;
    UIButton *nextBtn;
}

@property (weak,nonatomic) id <CheckInImgPickerDelegate> delegate;
@end
