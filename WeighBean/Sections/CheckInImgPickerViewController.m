//
//  CheckInImgPickerViewController.m
//  WeighBean
//
//  Created by sealband on 16/8/13.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInImgPickerViewController.h"
#import "CheckInImagePickerCell.h"
#import "CheckInPickResultViewController.h"
#import "ImageCropView.h"

@import Photos;


@interface CheckInImgPickerViewController () <PHPhotoLibraryChangeObserver>
{
    CheckInImageAlbumViewController *album;
    NSMutableArray *myAlbum;
    NSMutableArray *myArray;
    NSInteger currAlbumIndex;
    float size1,size2;//cell size
    
    UIImageView *imgArrow;
    
    NSUInteger currIndex;
}
@property (nonatomic, strong) NSMutableArray *myArray;
@property (nonatomic, strong) ALAssetsLibrary *library;
@end

@implementation CheckInImgPickerViewController 
@synthesize myArray;

- (void)dealloc
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
    }
    
    self.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (reloadPhotosFlag) {
        [self fetchAlbum];
        reloadPhotosFlag = NO;
    }
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [ALAssetsLibrary disableSharedPhotoStreamsSupport];
    
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchPhoto) name:ALAssetsLibraryChangedNotification object:nil];
    
    
    UILabel *addTagLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, DEVICEW-160, 40)];
    addTagLbl.backgroundColor = [UIColor whiteColor];
    addTagLbl.textColor = [UIColor grayColor];
    addTagLbl.font = UIFontOfSize(14);
    addTagLbl.text = @"相机胶卷";
    addTagLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:addTagLbl];

    
    btnClose = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 18, 18)];
    btnClose.backgroundColor = [UIColor whiteColor];
    [btnClose setImage:[UIImage imageNamed:@"closeicon"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(closeDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];

    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-104) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    
    nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, DEVICEH-49, DEVICEW, 49)];
    nextBtn.backgroundColor = [UIColor whiteColor];
    [nextBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = UIFontOfSize(14);
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICEH-50, DEVICEW, 1)];
    lineView.backgroundColor = UIColorFromRGB(238, 238, 238);
    [self.view addSubview:lineView];

    
    size1 = (DEVICEW-2)/2;
    size2 = (int)((DEVICEW-4)/3);
    
    currAlbumIndex = 0;
    
    [collection registerClass:[CheckInImagePickerCell class] forCellWithReuseIdentifier:@"MBImageCell"];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MBCell"];
    
    myAlbum = [[NSMutableArray alloc] init];
    myArray = [[NSMutableArray alloc] init];
    
    [self fetchAlbum];
    
}

- (void)nextStep
{
    
}

- (void)fetchAlbum
{
    //    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        NSString *errorMessage = NSLocalizedString(@"This app does not have access to your photos or videos. You can enable access in Privacy Settings.", nil);
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Access Denied", nil) message:errorMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil] show];
        return;
    }
    
    [myAlbum removeAllObjects];
    
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    NSArray *arr = @[smartAlbums,allPhotos,topLevelUserCollections];
    
    for (PHFetchResult *r in arr) {
        PHFetchResult *fetchResult = r;
        
        for (PHAssetCollection *c in fetchResult) {
            if ([c isKindOfClass:[PHAssetCollection class]]) {
                if (c.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumVideos && c.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumAllHidden && c.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumSlomoVideos && c.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumTimelapses && c.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumBursts && c.assetCollectionSubtype < 500) {
                    PHFetchResult *r = [PHAsset fetchAssetsInAssetCollection:c options:nil];
                    if (r.count == 0) {
                        continue;
                    }
                    if (c.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                        [myAlbum insertObject:c atIndex:0];
                    }
                    else
                    {
                        [myAlbum addObject:c];
                    }
                }
            }
            else
            {
                
            }
        }
    }
    [self fetchPhoto];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)fetchPhoto
{
    //    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
    if (currAlbumIndex < [myAlbum count]) {
        labTitle.text = ((PHAssetCollection *)[myAlbum objectAtIndex:currAlbumIndex]).localizedTitle;
        
//        CGRect r = [labTitle.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:labTitle.font} context:nil];
//        
//        imgArrow.frame = CGRectMake(DEVICEW/2+r.size.width/2+10, CGRectGetMinY(labTitle.frame), CGRectGetWidth(imgArrow.frame), CGRectGetHeight(imgArrow.frame));
    }
    currIndex = 0;
    [self performSelectorInBackground:@selector(preparePhotos:) withObject:@(currIndex*40)];
}

- (void)preparePhotos:(NSNumber *)n
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        if ([n intValue] != 0) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (currAlbumIndex < [myAlbum count]) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                PHAssetCollection *group = [myAlbum objectAtIndex:currAlbumIndex];
                PHFetchOptions *options = [PHFetchOptions new];
                options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
                PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:group options:options];
                for (PHAsset *as in assetsFetchResult) {
                    if (as.mediaType == PHAssetMediaTypeImage && as.pixelWidth < 20000 && as.pixelHeight < 20000) {
                        [arr insertObject:as atIndex:0];
                    }
                    
                }
                [self alassetDidGet:arr];
            }
        });
    }
}

- (void)alassetDidGet:(NSArray *)arr
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [myArray removeAllObjects];
    }
    [myArray addObjectsFromArray:arr];
    [collection reloadData];
}

- (void)showAblum:(BOOL)_yes
{
//    if (_yes) {
//        album.view.hidden = NO;
//        album.view.frame = CGRectOffset(collection.frame, 0, CGRectGetHeight(collection.frame));
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            album.view.frame = collection.frame;
//            btnClose.alpha = 0;
//        } completion:^(BOOL finished) {
//            //            [stillCamera stopCameraCapture];
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            album.view.frame = CGRectOffset(collection.frame, 0, CGRectGetHeight(collection.frame));
//            btnClose.alpha = 1;
//        } completion:^(BOOL finished) {
//            album.view.hidden = YES;
//            //            [stillCamera startCameraCapture];
//        }];
//    }
//}
//
//- (IBAction)titleDidClick:(id)sender {
//    if (!album) {
//        album = [[SRTImageAlbumViewController alloc] initWithArray:myAlbum];
//        [self.view addSubview:album.view];
//        album.delegate = self;
//        album.view.frame = collection.frame;
//        album.view.hidden = YES;
//    }
//    
//    if (album.view.hidden) {
//        [self showAblum:YES];
//        [self rotationTitleImage:YES];
//    }
//    else
//    {
//        [self showAblum:NO];
//        [self rotationTitleImage:NO];
//    }
}

- (void)closeDidClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - title img rotation
- (void)rotationTitleImage:(BOOL)_yes
{
    CGFloat rotation = 0;
    if (_yes) {
        rotation = M_PI;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imgArrow.layer.anchorPoint = CGPointMake(0.5, 0.5);
        imgArrow.transform = CGAffineTransformMakeRotation(rotation);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - collectionview delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [myArray count]+1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(size2, size2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
       
        //7.0主动调用刷新方法
        
        [self collectionView:collection willDisplayCell:nil forItemAtIndexPath:indexPath];
    }
    
    NSString *rid = @"MBImageCell";
    CheckInImagePickerCell *cell = (CheckInImagePickerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];
    if (!cell) {
        cell = [[CheckInImagePickerCell alloc] init];
    }
    
    float w = size2;
    
    if (indexPath.row < [myArray count]) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            PHAsset *asset = [myArray objectAtIndex:indexPath.row];
            cell.imageview.image = nil;
            cell.representedAssetIdentifier = asset.localIdentifier;
        
            
            NSString *path = [self fileWithDicPath:@"pic" fileName:[NSString stringWithFormat:@"album%@",[[cell.representedAssetIdentifier pathComponents] objectAtIndex:0]]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                cell.imageview.image = [UIImage imageWithContentsOfFile:path];
            }
            else
            {
                @autoreleasepool {
                    NSLog(@"%@",asset);
                    PHImageRequestOptions *op = [PHImageRequestOptions new];
                    op.synchronous = YES;
                    op.networkAccessAllowed = YES;
                    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(w, w) contentMode:PHImageContentModeAspectFill options:op resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        NSLog(@"%@",path);
                        [UIImageJPEGRepresentation(result, 0.8) writeToFile:path atomically:NO];
                        cell.imageview.image = [UIImage imageWithContentsOfFile:path];
                    }];
                }
            }
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self imagePicker:self selectIndex:indexPath.row asset:[myArray objectAtIndex:indexPath.row]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
- (void)album:(CheckInImageAlbumViewController *)_album selectIndex:(NSUInteger)index group:(ALAssetsGroup *)group
{
    if (index < [myAlbum count]) {
        currAlbumIndex = index;
        
        //        [myArray removeAllObjects];
        //        [collection reloadData];
        
        [self fetchPhoto];
        
        //        album.view.hidden = YES;
        [self showAblum:NO];
        
        [self rotationTitleImage:NO];
    }
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    /*
     Change notifications may be made on a background queue. Re-dispatch to the
     main queue before acting on the change as we'll be updating the UI.
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[self.navigationController viewControllers] lastObject] isEqual:self]) {
            [self fetchAlbum];
        }
        else
        {
            reloadPhotosFlag = YES;
        }
    });
}


- (NSString *)fileWithDicPath:(NSString *)_dictname fileName:(NSString *)_fname
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] stringByAppendingPathComponent:[_dictname copy]];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (!bo) {
        NSAssert(bo,@"创建目录失败");
    }
    
    NSString *result = [path stringByAppendingPathComponent:[_fname copy]];
    
    return result;
}










#pragma mark - srtimagepicker delegate
- (void)goWithImage:(UIImage *)img picker:(CheckInImgPickerViewController *)picker
{
    picker.view.userInteractionEnabled = YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    CheckInPickResultViewController *vc = [[CheckInPickResultViewController alloc] initWithImg:img];
//    [picker.navigationController pushViewController:vc animated:YES];
    ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:img];
    controller.blurredBackground = YES;
    [[self navigationController] pushViewController:controller animated:YES];

}

- (void)requestImageWithAsset:(PHAsset *)a options:(PHImageRequestOptions *)op picker:(CheckInImgPickerViewController *)picker
{
    [[PHImageManager defaultManager] requestImageDataForAsset:a options:op resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        UIImage *result = [UIImage imageWithData:imageData];
        if (result) {
            [self goWithImage:result picker:picker];
        }
        else
        {
            picker.view.userInteractionEnabled = YES;
        }
    }];
    
}

- (void)imagePicker:(CheckInImgPickerViewController *)picker selectIndex:(NSUInteger)index asset:(ALAsset *)al
{
    if ([al isKindOfClass:[PHAsset class]]) {
        PHAsset *a = (PHAsset *)al;
        PHImageRequestOptions *op = [PHImageRequestOptions new];
        op.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        op.networkAccessAllowed = YES;
        op.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                picker.view.userInteractionEnabled = NO;
            });
        };

        [self requestImageWithAsset:a options:op picker:picker];

    }
}


@end
