//
//  PersonalCell.m
//  WeighBean
//
//  Created by sealband on 16/8/16.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "PersonalCell.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"
#import <UIImageView+WebCache.h>

@implementation PersonalCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICEW, DEVICEW+140)];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.masksToBounds = YES;
        [self.contentView addSubview:background];

        
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        avatar.contentMode = UIViewContentModeScaleAspectFill;
        avatar.backgroundColor = [UIColor lightGrayColor];
        avatar.layer.cornerRadius = 17.5;
        avatar.clipsToBounds = YES;
        [self.contentView addSubview:avatar];
        
        nickName = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right+8, avatar.top, 100, 35)];
        nickName.backgroundColor = [UIColor clearColor];
        nickName.font = UIFontOfSize(13);
        nickName.text = @"小曼xman";
        nickName.textColor = [UIColor blackColor];
        [self.contentView addSubview:nickName];
        
        timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(DEVICEW-120, 15, 120, 25)];
        timeLbl.backgroundColor = [UIColor clearColor];
        timeLbl.font = UIFontOfSize(11);
        timeLbl.text = @"1小时前发布";
        timeLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLbl];
        
        picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 57, DEVICEW, DEVICEW)];
        picView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:picView];
        
        likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(7, picView.bottom+20, 44, 18)];
        likeBtn.backgroundColor = UIColorFromRGB(238, 238, 238);
        likeBtn.titleLabel.font = UIFontOfSize(12);
        [likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [likeBtn setImage:[UIImage imageNamed:@"likeicon"] forState:UIControlStateNormal];
        [likeBtn setTitle:@"0" forState:UIControlStateNormal];
        [likeBtn setImageEdgeInsets:UIEdgeInsetsMake(likeBtn.titleLabel.intrinsicContentSize.height-14, -6, 0, likeBtn.titleLabel.intrinsicContentSize.width)];
        [likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, likeBtn.imageView.intrinsicContentSize.width, 0, 0)];
        [likeBtn addTarget:self action:@selector(likeDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:likeBtn];
        
        commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(DEVICEW-60, likeBtn.top, 45, 23)];
        [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commentBtn.titleLabel.font = UIFontOfSize(12);
        commentBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        commentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [commentBtn setImage:[UIImage imageNamed:@"commenticon"] forState:UIControlStateNormal];
        [commentBtn setTitle:@"0" forState:UIControlStateNormal];
        [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(commentBtn.titleLabel.intrinsicContentSize.height-16, -6, 0, commentBtn.titleLabel.intrinsicContentSize.width)];
        [commentBtn addTarget:self action:@selector(commentDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:commentBtn];
        
        favourArr = [[NSMutableArray alloc] init];
        commentArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)btnAction:(UIButton *)btn
{
//    NSInteger index = 0;
//    if (btn == _buyBtn)
//    {
//        index = 3;
//    }
//    else if (btn == _saleAfterBtn)
//    {
//        index = 2;
//    }
//    else if (btn == _saleBeforBtn)
//    {
//        index = 1;
//    }
//    if (self.selectBlock)
//    {
//        self.selectBlock(index,_obj,_path);
//    }
}

- (void)loadContent:(PersonalObjModel *)obj path:(NSIndexPath *)path;
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
    likeBtn.titleLabel.text = obj.favour;
    commentBtn.titleLabel.text = obj.comment_num;
    [commentBtn setTitle:obj.comment_num forState:UIControlStateNormal];
}

- (void)likeDidClick
{
    likeBtn.titleLabel.text = [NSString stringWithFormat:@"%d",[self.obj.favour integerValue]+1];
    [UIView animateWithDuration:0.2 animations:^{
        likeBtn.imageView.transform = CGAffineTransformScale(likeBtn.imageView.transform, 3, 3);
        
    }];
    [self.delegate likeDidClickWithDakaID:self.obj.dakaid];
}

- (void)commentDidClick
{
    [self.delegate commentDidClickWithDakaID:self.obj.dakaid author:self.obj.nick];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
