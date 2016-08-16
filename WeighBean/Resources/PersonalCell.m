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

@implementation PersonalCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICEW, 355)];
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
        
        timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(DEVICEW-100, 15, 100, 25)];
        timeLbl.backgroundColor = [UIColor clearColor];
        timeLbl.font = UIFontOfSize(11);
        timeLbl.text = @"1小时前发布";
        timeLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLbl];
        
        picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 57, DEVICEW, 213)];
        picView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:picView];
        
        likeLbl = [[UILabel alloc] initWithFrame:CGRectMake(7, picView.bottom+12, 44, 18)];
        likeLbl.backgroundColor = UIColorFromRGB(238, 238, 238);
        likeLbl.font = UIFontOfSize(12);
        likeLbl.text = @"3";
        likeLbl.textColor = [UIColor grayColor];
        [self.contentView addSubview:likeLbl];
        
        commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(DEVICEW-60, likeLbl.top, 45, 23)];
        [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commentBtn.titleLabel.font = UIFontOfSize(12);
        [commentBtn setTitle:@"1" forState:UIControlStateNormal];
        commentBtn.titleLabel.textAlignment = NSTextAlignmentRight;
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

//- (void)loadContent:(OLProductModel *)obj path:(NSIndexPath *)path
//{
//    self.obj = obj;
//    self.path = path;
//    _title.text = obj.title;
//    //    [_productImage sd_setImageWithURL:[NSURL URLWithString:obj.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//    //        if (image)
//    //        {
//    //            _productImage.image = image;
//    //        }
//    //    }];
//    _priceLabel.text = [NSString stringWithFormat:@"￥%@/箱",obj.price];
//    _productLabel.text = obj.content;
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
