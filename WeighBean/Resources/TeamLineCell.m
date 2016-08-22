//
//  TeamLineCell.m
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "TeamLineCell.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"
#import <UIImageView+WebCache.h>


@implementation TeamLineCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.cornerRadius = 0.5;
        background.layer.masksToBounds = YES;
        [self.contentView addSubview:background];
        
        
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 35, 35)];
        avatar.contentMode = UIViewContentModeScaleAspectFill;
        avatar.backgroundColor = [UIColor lightGrayColor];
        avatar.layer.cornerRadius = 17.5;
        avatar.clipsToBounds = YES;
        [self.contentView addSubview:avatar];
        
        nickName = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right+8, avatar.top, 100, 20)];
        nickName.backgroundColor = [UIColor clearColor];
        nickName.font = UIFontOfSize(13);
        nickName.text = @"小曼xman";
        nickName.textColor = [UIColor blackColor];
        [self.contentView addSubview:nickName];
        
        timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(nickName.left, nickName.bottom, 100, 15)];
        timeLbl.backgroundColor = [UIColor clearColor];
        timeLbl.font = UIFontOfSize(11);
        timeLbl.text = @"1小时前发布";
        timeLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLbl];
        
        picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, self.frame.size.width, 100)];
        picView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:picView];
        
        commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(7, picView.bottom+25, 45, 23)];
        [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commentBtn.titleLabel.font = UIFontOfSize(12);
        [commentBtn setImage:[UIImage imageNamed:@"coachlinecomment"] forState:UIControlStateNormal];
        [commentBtn setTitle:@"1" forState:UIControlStateNormal];
        commentBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:commentBtn];
        
        likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentBtn.right+10, commentBtn.top, 44, 23)];
        likeBtn.titleLabel.font = UIFontOfSize(12);
        [likeBtn setImage:[UIImage imageNamed:@"coachlinelike"] forState:UIControlStateNormal];
        [likeBtn setTitle:@"3" forState:UIControlStateNormal];
        [likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:likeBtn];
        
        favourArr = [[NSMutableArray alloc] init];
        commentArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadContent:(TeamObjModel *)obj path:(NSIndexPath *)path
{
    self.obj = obj;
    self.path = path;
    
    NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:[obj.createTime intValue]/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    [avatar sd_setImageWithURL:[NSURL URLWithString:obj.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar.image = image;
        }
    }];
    
    nickName.text = obj.nick;
    timeLbl.text = [formatter stringFromDate:createTime];
    [picView sd_setImageWithURL:[NSURL URLWithString:obj.pics] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        picView.image = image;
    }];
    [commentBtn setTitle:obj.comment_num forState:UIControlStateNormal];
    [likeBtn setTitle:obj.favour forState:UIControlStateNormal];

}

@end