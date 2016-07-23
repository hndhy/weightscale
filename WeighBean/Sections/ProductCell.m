//
//  ProductCell.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/16.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "ProductCell.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import <UIImageView+WebCache.h>

@implementation ProductCell

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
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, CGRectGetWidth(background.frame) - 20, 20)];
        _title.text = @"高级电子人体体重秤";
        _title.font = [UIFont systemFontOfSize:14];
        [background addSubview:_title];
        
        CALayer *topLine = [CALayer layer];
        topLine.frame = CGRectMake(0, 33, CGRectGetWidth(background.frame), 0.5);
        topLine.backgroundColor = UIColorFromRGB(229,229,229).CGColor;
        [background.layer addSublayer:topLine];
        
        _productImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(topLine.frame) + 10, 146, 146)];
        _productImage.backgroundColor = [UIColor orangeColor];
        _productImage.image = [UIImage imageNamed:@"zx_cheng_def"];
        [background addSubview:_productImage];
        
        CALayer *bottomLine = [CALayer layer];
        bottomLine.frame = CGRectMake(0, CGRectGetHeight(background.frame) - 44, CGRectGetWidth(background.frame), 0.5);
        bottomLine.backgroundColor = UIColorFromRGB(229,229,229).CGColor;
        [background.layer addSublayer:bottomLine];
        
        _saleBeforBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saleBeforBtn.frame = CGRectMake(0,CGRectGetMaxY(bottomLine.frame) + 2 ,CGRectGetWidth(background.frame)/3, 40);
        [_saleBeforBtn setImage:[UIImage imageNamed:@"zx_pre_sale"] forState:UIControlStateNormal];
        [_saleBeforBtn setImageEdgeInsets:UIEdgeInsetsMake(-4, 0, 8, 0)];
        [_saleBeforBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:_saleBeforBtn];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(_saleBeforBtn.frame), 20)];
        name.text = @"售前";
        name.font = [UIFont systemFontOfSize:12];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = UIColorFromRGB(229,229,229);
        [_saleBeforBtn addSubview:name];
        
        _saleAfterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saleAfterBtn.frame = CGRectMake(CGRectGetMaxX(_saleBeforBtn.frame),CGRectGetMaxY(bottomLine.frame) + 2 ,CGRectGetWidth(background.frame)/3, 40);
        [_saleAfterBtn setImage:[UIImage imageNamed:@"zx_sale_after"] forState:UIControlStateNormal];
        [_saleAfterBtn setImageEdgeInsets:UIEdgeInsetsMake(-4, 0, 8, 0)];
        [_saleAfterBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:_saleAfterBtn];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(_saleBeforBtn.frame), 20)];
        name.text = @"售后";
        name.font = [UIFont systemFontOfSize:12];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = UIColorFromRGB(229,229,229);
        [_saleAfterBtn addSubview:name];
        
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"zx_buy"] forState:UIControlStateNormal];
        _buyBtn.frame = CGRectMake(CGRectGetMaxX(_saleAfterBtn.frame) + (CGRectGetWidth(background.frame)/3 -80)/2,CGRectGetMaxY(bottomLine.frame) + 10 ,80, 24);
//        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn setTitle:@"在线购买" forState:UIControlStateNormal];
        [_buyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_buyBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:_buyBtn];
        
        CALayer *theLine =  [CALayer layer];
        theLine.frame = CGRectMake(CGRectGetMaxX(_saleBeforBtn.frame), CGRectGetMaxY(bottomLine.frame) + 12, 0.5, 20);
        theLine.backgroundColor = UIColorFromRGB(229,229,229).CGColor;
        [background.layer addSublayer:theLine];
        
        theLine =  [CALayer layer];
        theLine.frame = CGRectMake(CGRectGetMaxX(_saleAfterBtn.frame), CGRectGetMaxY(bottomLine.frame), 0.5, 44);
        theLine.backgroundColor = UIColorFromRGB(229,229,229).CGColor;
        [background.layer addSublayer:theLine];
     
        NSString *text = @"商品名称：智能体重秤脂肪秤健康人体秤家用计\n商品编号：1703916408\n店铺：Meilen官方旗舰店\n上架时间：2015-08-27 09:33:38\n商品毛重：1.5kg\n商品产地：中国\n大陆货号：MZ616";
        
        CGFloat width = CGRectGetMaxX(_buyBtn.frame) - CGRectGetMaxX(_productImage.frame) - 10;
        
        _productLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productImage.frame) + 10, CGRectGetMaxY(topLine.frame) + 10, width, 122)];
        _productLabel.text = text;
        _productLabel.backgroundColor = UIColorFromRGB(245, 245, 245);
        _productLabel.font = [UIFont systemFontOfSize:10];
        _productLabel.textColor = UIColorFromRGB(23,33,23);
        _productLabel.numberOfLines = 10;
        _productLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [background addSubview:_productLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productImage.frame) + 10, CGRectGetMaxY(_productLabel.frame), width, 24)];
        _priceLabel.backgroundColor = UIColorFromRGB(237, 237, 237);
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = UIColorFromRGB(255,161,5);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [background addSubview:_priceLabel];
        
        _priceLabel.text = @"￥499/箱";
        
    }
    return self;
}

- (void)btnAction:(UIButton *)btn
{
    NSInteger index = 0;
    if (btn == _buyBtn)
    {
        index = 3;
    }
    else if (btn == _saleAfterBtn)
    {
        index = 2;
    }
    else if (btn == _saleBeforBtn)
    {
        index = 1;
    }
    if (self.selectBlock)
    {
        self.selectBlock(index,_obj,_path);
    }
}

- (void)loadContent:(OLProductModel *)obj path:(NSIndexPath *)path
{
    self.obj = obj;
    self.path = path;
    _title.text = obj.title;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:obj.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image)
        {
            _productImage.image = image;
        }
    }];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@/箱",obj.price];
    _productLabel.text = obj.content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
