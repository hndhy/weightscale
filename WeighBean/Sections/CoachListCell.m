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
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.frame)-20, 240)];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.cornerRadius = 5;
        background.layer.masksToBounds = YES;
        [self addSubview:background];
        
        coachIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 60, 60)];
        coachIcon.backgroundColor = [UIColor blueColor];
        coachIcon.image = nil;
        [background addSubview:coachIcon];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(coachIcon.right+20, 25, 100, 30)];
        title.text = @"人教练战队";
        title.font = [UIFont systemFontOfSize:14];
        [background addSubview:title];
        
        subTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(coachIcon.right+20, title.bottom+5, 150, 30)];
        subTitle1.text = @"活跃人数";
        subTitle1.font = [UIFont systemFontOfSize:14];
        [background addSubview:subTitle1];
        
        subTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(subTitle1.right+20, title.bottom+5, 150, 30)];
        subTitle2.text = @"有效率";
        subTitle2.font = [UIFont systemFontOfSize:14];
        [background addSubview:subTitle2];
        
        stataLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-160, 20, 150, 20)];
        stataLbl.text = @"状态";
        stataLbl.font = [UIFont systemFontOfSize:14];
        [background addSubview:stataLbl];
        
        joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        joinBtn.frame = CGRectMake(stataLbl.left,stataLbl.bottom+5,80,40);
        joinBtn.backgroundColor = [UIColor blueColor];
        [joinBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:joinBtn];
        
        coachTypeLbl = [[UILabel alloc] initWithFrame:joinBtn.frame];
        coachTypeLbl.text = @"状态";
        coachTypeLbl.font = [UIFont systemFontOfSize:14];
        [background addSubview:coachTypeLbl];
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
    subTitle1.text = [NSString stringWithFormat:@"活跃人数:%@",obj.activeNum];
    subTitle2.text = [NSString stringWithFormat:@"有效率:%@",obj.valid];
    stataLbl.text = [NSString stringWithFormat:@"状态:%@",obj.teamType];
//    [_productImage sd_setImageWithURL:[NSURL URLWithString:obj.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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
