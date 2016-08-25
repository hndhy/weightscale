//
//  AvatarAndNickView.m
//  WeighBean
//
//  Created by sealband on 16/8/26.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "AvatarAndNickView.h"
#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"

@implementation AvatarAndNickView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    avatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.width-10)];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.backgroundColor = [UIColor lightGrayColor];
    avatar.layer.cornerRadius = (self.frame.size.width-10)/2;
    avatar.clipsToBounds = YES;
    [self addSubview:avatar];
    
    nick = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    nick.backgroundColor = [UIColor clearColor];
    [nick setTextColor:[UIColor grayColor]];
    [nick setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:nick];
}

- (void)setInfoActive:(brisk_listModel *)obj
{
    [avatar sd_setImageWithURL:[NSURL URLWithString:obj.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar.image = image;
        }
    }];
    
    nick.text = obj.nick;
}

- (void)setInfoSum:(sum_listModel *)obj
{
    [avatar sd_setImageWithURL:[NSURL URLWithString:obj.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar.image = image;
        }
    }];
    
    nick.text = obj.nick;
}
@end
