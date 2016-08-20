//
//  PicturePicker.h
//  HereTravel
//
//  Created by liumadu on 15/5/30.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "PicturePicker.h"

#import "AppMacro.h"
#import "UIIMage+Resizing.h"
#import "UIView+Ext.h"
#import "UILabel+Ext.h"
#import "UtilsMacro.h"
#import <iToast.h>
#import "CheckInImgPickerViewController.h"
#import "HTNavigationController.h"

//static const NSTimeInterval kAnimationDuration = 0.33;

@interface PicturePicker ()<UIActionSheetDelegate>

@property (nonatomic, readonly, weak) UIViewController<PicturePickerProtocol> *controller;
@property (nonatomic, strong) UIViewController* imagePickerViewController;

@property (nonatomic, strong) UIView *popView;

@end

@implementation PicturePicker

- (id)initWithController:(UIViewController<PicturePickerProtocol> *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

- (void)showPicture
{
  UIWindow *window = self.controller.view.window;
  if (self.popView) {
    [window addSubview:self.popView];
    return;
  }
  self.popView = [[UIView alloc] initWithFrame:window.frame];
  [self.popView addTapCallBack:self sel:@selector(onCloseClick:)];
  self.popView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
  [window addSubview:self.popView];
  UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_bg.png"]];
  bgImageView.top = self.popView.height - bgImageView.height;
  [self.popView addSubview:bgImageView];
  UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74.0f, 74.0f)];
  cameraButton.centerY = bgImageView.centerY;
  cameraButton.centerX = bgImageView.width / 4.0f;
  [cameraButton addTarget:self action:@selector(getPhotoFromCamera) forControlEvents:UIControlEventTouchUpInside];
  [cameraButton setImage:[UIImage imageNamed:@"photo_camera_icon.png"] forState:UIControlStateNormal];
  [self.popView addSubview:cameraButton];
  UIButton *albumButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 50.0f)];
  albumButton.centerX = bgImageView.width / 4.0f * 3.0f;
  albumButton.centerY = bgImageView.centerY;
  [albumButton addTarget:self action:@selector(getPhotoFromLibrary) forControlEvents:UIControlEventTouchUpInside];
  [albumButton setImage:[UIImage imageNamed:@"photo_album_icon.png"] forState:UIControlStateNormal];
  [self.popView addSubview:albumButton];
  UILabel *label = [UILabel createLabelWithFrame:CGRectZero withSize:10.0f withColor:UIColorFromRGB(66.0f, 66.0f, 66.0f)];
  label.text = @"本地相册";
  [self.popView addSubview:label];
  [label sizeToFit];
  label.centerX = albumButton.centerX;
  label.top = albumButton.top - label.height - 2.0f;
}

- (void)onCloseClick:(id)button
{
  if (self.popView && self.popView.superview) {
    [self.popView removeFromSuperview];
  }
}

- (void)showActionSheet:(id)sender
{
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [actionSheet addButtonWithTitle:@"拍照"];
  }
  [actionSheet addButtonWithTitle:@"从相册选择"];
  [actionSheet addButtonWithTitle:@"取消"];
  [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
  [actionSheet showInView:self.controller.view];
}

/** 从相机里获取图片*/
- (void)getPhotoFromCamera
{
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    self.imagePickerViewController = imagePC;
    imagePC.delegate = self;
    if (PicturePickerAvatar == self.type) {
      imagePC.allowsEditing = YES;
    }
    imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self onCloseClick:nil];
    [self.controller presentViewController:imagePC animated:YES completion:NULL];
  } else {
    [[iToast makeText:@"该设备不支持相机功能"] show];
    return;
  }
}

/**从相册里获取图片*/
- (void)getPhotoFromLibrary
{

    if (PicturePickerCheckIn == self.type) {
    
        CheckInImgPickerViewController *imgPickerVC = [[CheckInImgPickerViewController alloc] init];
        HTNavigationController *navController = [[HTNavigationController alloc] initWithRootViewController:imgPickerVC];
        [self.controller presentViewController:navController animated:YES completion:nil];

    } else
    {
      UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
      if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    
      }
      pickerImage.delegate = self;
      if (PicturePickerAvatar == self.type) {
        pickerImage.allowsEditing = YES;
      }
      [self onCloseClick:nil];
      [self.controller presentViewController:pickerImage animated:YES completion:NULL];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (actionSheet.numberOfButtons > 2) {
    if (buttonIndex == 0) {
      [self getPhotoFromCamera];
    } else if (buttonIndex == 1) {
      [self getPhotoFromLibrary];
    }
  } else {
    if (buttonIndex == 0) {
      [self getPhotoFromLibrary];
    }
  }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  [picker dismissViewControllerAnimated:YES completion:nil];
  if (PicturePickerPic == self.type) {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* scaledImage = [image scaleToFitSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.controller selectImage:scaledImage];
  } else {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.controller selectImage:image];
  }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
