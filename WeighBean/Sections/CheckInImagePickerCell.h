//
//  CheckInImagePickerCell.h
//  WeighBean
//
//  Created by sealband on 16/8/13.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PhotosUI/PhotosUI.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CheckInImagePickerCell : UICollectionViewCell


{
    UIImageView *imageview;
    ALAsset *myAsset;
}
@property (nonatomic, strong) NSString *representedAssetIdentifier;
@property (nonatomic, strong) UIImageView *imageview;

@end
