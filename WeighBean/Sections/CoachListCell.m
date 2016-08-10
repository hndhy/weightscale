//
//  CoachListCell.m
//  WeighBean
//
//  Created by sealband on 16/8/4.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "CoachListCell.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import <UIImageView+WebCache.h>
#import "UIView+Ext.h"


@implementation CoachListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgroundView];
        
        coachIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 35, 35)];
        coachIcon.backgroundColor = [UIColor clearColor];
        coachIcon.image = nil;
        [self.contentView addSubview:coachIcon];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(coachIcon.right+10, 15, 100, 20)];
        title.text = @"人教练战队";
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        
        subTitle1 = [[MutiLabel alloc] initWithFrame:CGRectMake(coachIcon.right+10, title.bottom, 65, 20)];
        subTitle1.text = @"活跃人数";
        subTitle1.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:subTitle1];
        
        subTitle2 = [[MutiLabel alloc] initWithFrame:CGRectMake(subTitle1.right+10, title.bottom, 70, 20)];
        subTitle2.text = @"有效率";
        subTitle2.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:subTitle2];
        
        joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        joinBtn.frame = CGRectMake(self.frame.size.width-15-65,18,65,25);
        joinBtn.backgroundColor = [UIColor clearColor];
        [joinBtn setImage:[UIImage imageNamed:@"join_team"] forState:UIControlStateNormal];
        [joinBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:joinBtn];
        joinBtn.hidden = YES;
        
        coachTypeLbl = [[UILabel alloc] initWithFrame:joinBtn.frame];
        coachTypeLbl.text = @"";
        coachTypeLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:coachTypeLbl];
        coachTypeLbl.hidden = YES;
//
//        stataLbl = [[UILabel alloc] initWithFrame:CGRectMake(title.right+50, 10, 150, 20)];
//        stataLbl.text = @"状态";
//        stataLbl.font = [UIFont systemFontOfSize:14];
//        [self.contentView addSubview:stataLbl];
//
    }
    return self;
}

//- (void)btnAction:(UIButton *)btn
//{
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
//}

- (void)loadContent:(CoachObjModel *)obj path:(NSIndexPath *)path
{
    self.obj = obj;
    self.path = path;
    title.text = obj.teamName;
//    subTitle1.text = [NSString stringWithFormat:@"活跃人数:%@",obj.activeNum];
    
    [subTitle1 setText:@"活跃人数：" withInteger:obj.activeNum];
//    subTitle2.text = [NSString stringWithFormat:@"有效率:%@",obj.valid];
//    [subTitle2 setText:@"有效率：" withInteger:obj.valid];
    [subTitle2 setText:@"有效率：" withPercent:obj.valid];
    stataLbl.text = [NSString stringWithFormat:@"状态:%@",obj.teamType];
    
    
    if (obj.teamType == @"1") {
        coachIcon.image = [UIImage imageNamed:@"fat_iconv"];
    } else if (obj.teamType == @"2")
    {
        coachIcon.image = [UIImage imageNamed:@"strong_iconv"];
    } else
    {
        coachIcon.image = [UIImage imageNamed:@"target_iconv"];
    }
    
    if (obj.flag == 1) {
        joinBtn.hidden = YES;
        coachTypeLbl.hidden = NO;
        coachTypeLbl.text = @"我是教练";
        coachTypeLbl.textColor = [UIColor orangeColor];
    } else if (obj.flag == 2)
    {
        joinBtn.hidden = YES;
        coachTypeLbl.hidden = NO;
        coachTypeLbl.textColor = [UIColor colorWithRed:29/255.0 green:168/255.0 blue:225/255.0 alpha:1];
        coachTypeLbl.text = @"下级战队";
    } else
    {
        joinBtn.hidden = NO;
        coachTypeLbl.hidden = YES;
    }
//    [coachIcon sd_setImageWithURL:[NSURL URLWithString:obj.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image)
//        {
//            _productImage.image = image;
//        }
//    }];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
