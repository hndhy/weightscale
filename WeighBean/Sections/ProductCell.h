//
//  ProductCell.h
//  WeighBean
//
//  Created by 曾宪东 on 15/11/16.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLProductModel.h"

@interface ProductCell : UITableViewCell
{
    UILabel *_title;
    UIImageView *_productImage;
    UIButton *_saleBeforBtn;
    UIButton *_saleAfterBtn;
    UIButton *_buyBtn;
    
    UILabel *_productLabel;
    UILabel *_priceLabel;
}

@property (nonatomic,strong) OLProductModel *obj;
@property (nonatomic,copy) void (^selectBlock)(NSInteger index,OLProductModel *obj,NSIndexPath *path);
@property (nonatomic,strong) NSIndexPath *path;
- (void)loadContent:(OLProductModel *)obj path:(NSIndexPath *)path;

@end
