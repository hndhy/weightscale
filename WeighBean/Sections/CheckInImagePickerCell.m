//
//  CheckInImagePickerCell.m
//  WeighBean
//
//  Created by sealband on 16/8/13.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CheckInImagePickerCell.h"
#import <ImageIO/ImageIO.h>
#import "NSDictionary+GetValue.h"

@implementation CheckInImagePickerCell
@synthesize imageview;


static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
           }
    
    return countRead;
}

static void releaseAssetCallback(void *info) {
    CFRelease(info);
}

- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size {
    NSParameterAssert(asset != nil);
    NSParameterAssert(size > 0);
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    if (!rep) {
        return [UIImage imageWithCGImage:asset.thumbnail];
    }
    
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInt:(int)size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}

- (void)getImageFromAsset:(ALAsset *)al size:(NSInteger)size block:(void (^)(UIImage * img,ALAsset *al)) block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *img = [self thumbnailForAsset:al maxPixelSize:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(img,al);
        });
    });
}


- (void)delay:(NSDictionary *)d
{
    [self getImageFromAsset:[d getValueForKey:@"al"] size:[[d getValueForKey:@"size"] intValue] block:^(UIImage *i,ALAsset *al) {
        //        devLog(@"%@,%@",[d getValueForKey:@"al"],al);
        if (myAsset == al) {
            imageview.image = i;
        }
    }];
}



- (void)prepareForReuse
{
    myAsset = nil;
    [super prepareForReuse];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    imageview.image = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageview = nil;
        imageview = [[UIImageView alloc] init];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        [self.contentView addSubview:imageview];
        
         }
    return self;
}

- (void)dealloc
{
    imageview.image = nil;
    imageview = nil;
}

- (void)layoutSubviews
{
    imageview.frame = self.bounds;
}
@end
