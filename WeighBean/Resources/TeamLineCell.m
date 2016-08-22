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
        
        containerView = [[UIView alloc] initWithFrame:CGRectMake(3, 59, self.frame.size.width-6, 100)];
        containerView.layer.cornerRadius = 2;
        containerView.backgroundColor = UIColorFromRGB(247, 247, 247);
        [self.contentView addSubview:containerView];
        containerView.hidden = YES;
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, 3, 50, 25)];
        weightLbl.backgroundColor = [UIColor clearColor];
        weightLbl.font = UIFontOfSize(11);
        weightLbl.text = @"体重";
        weightLbl.textColor = [UIColor blackColor];
        [containerView addSubview:weightLbl];
        
        weightNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, 3, 70, 25)];
        weightNumLbl.backgroundColor = [UIColor clearColor];
        weightNumLbl.font = UIFontOfSize(11);
        weightNumLbl.textColor = [UIColor lightGrayColor];
        [containerView addSubview:weightNumLbl];
        
        
        
        UILabel *weightRatioLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, weightLbl.bottom, 50, 25)];
        weightRatioLbl.backgroundColor = [UIColor clearColor];
        weightRatioLbl.font = UIFontOfSize(11);
        weightRatioLbl.text = @"体脂率";
        weightRatioLbl.textColor = [UIColor blackColor];
        [containerView addSubview:weightRatioLbl];
        
        weightRatioNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, weightLbl.bottom, 50, 25)];
        weightRatioNumLbl.backgroundColor = [UIColor clearColor];
        weightRatioNumLbl.font = UIFontOfSize(11);
        weightRatioNumLbl.textColor = [UIColor lightGrayColor];
        [containerView addSubview:weightRatioNumLbl];
        
        
        UILabel *innerLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, weightRatioLbl.bottom, 50, 25)];
        innerLbl.backgroundColor = [UIColor clearColor];
        innerLbl.font = UIFontOfSize(11);
        innerLbl.text = @"内脂";
        innerLbl.textColor = [UIColor blackColor];
        [containerView addSubview:innerLbl];
        
        innerNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, weightRatioLbl.bottom, 50, 25)];
        innerNumLbl.backgroundColor = [UIColor clearColor];
        innerNumLbl.font = UIFontOfSize(11);
        innerNumLbl.textColor = [UIColor lightGrayColor];
        [containerView addSubview:innerNumLbl];
        
        UILabel *muscleLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, innerLbl.bottom, 50, 25)];
        muscleLbl.backgroundColor = [UIColor clearColor];
        muscleLbl.font = UIFontOfSize(11);
        muscleLbl.text = @"肌肉量";
        muscleLbl.textColor = [UIColor blackColor];
        [containerView addSubview:muscleLbl];
        
        muscleNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, innerLbl.bottom, 50, 25)];
        muscleNumLbl.backgroundColor = [UIColor clearColor];
        muscleNumLbl.font = UIFontOfSize(11);
        muscleNumLbl.textColor = [UIColor lightGrayColor];
        [containerView addSubview:muscleNumLbl];



        
        
        
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

    
    if ([obj.dakatype isEqualToString:@"2"]) {
        containerView.hidden = NO;
        weightNumLbl.text = [NSString stringWithFormat:@"%@ 公斤",obj.measure.fat];
        weightRatioNumLbl.text = [NSString stringWithFormat:@"%@ %%",obj.measure.lbm];
        innerNumLbl.text = [NSString stringWithFormat:@"%@ 级",obj.measure.vat];
        muscleNumLbl.text = [NSString stringWithFormat:@"%@ 公斤",obj.measure.w];
        picView.hidden = YES;
    } else
    {
        [picView sd_setImageWithURL:[NSURL URLWithString:obj.pics] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            picView.image = image;
        }];
    }
    [avatar sd_setImageWithURL:[NSURL URLWithString:obj.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            avatar.image = image;
        }
    }];
    
    nickName.text = obj.nick;
    timeLbl.text = [formatter stringFromDate:createTime];
       [commentBtn setTitle:obj.comment_num forState:UIControlStateNormal];
    [likeBtn setTitle:obj.favour forState:UIControlStateNormal];

}

@end
