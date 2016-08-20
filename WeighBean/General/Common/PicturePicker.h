//
//  PicturePicker.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
  PicturePickerAvatar,
  PicturePickerPic,
  PicturePickerCheckIn
} PicturePickerType;

@protocol PicturePickerProtocol <NSObject>
@required
- (void)selectImage:(UIImage *)image;
@end

@interface PicturePicker : UIView<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) PicturePickerType type;

- (id)initWithController:(UIViewController<PicturePickerProtocol> *)controller;
- (void)showActionSheet:(id)sender;
- (void)showPicture;

@end
