//
//  LBMViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "LBMViewController.h"

@implementation LBMViewController

- (void)initNavbar
{
  self.title = @"肌肉量";
}

- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, 90);
    layer.cornerRadius = 5;
    layer.borderWidth = 0.5;
    layer.borderColor = UIColorFromRGB(229, 229, 229).CGColor;
    [scrollView.layer addSublayer:layer];
    
    NSString *befor = @"根据美国FDA对身体成分测量仪中规定的肌肉量(Muscle Mass)标准为去脂体重减去无机物(骨骼矿物质)，即包括了";
    NSString *next1 = @"骨骼肌和非骨骼肌(平滑肌和心肌)。";
    NSString *next2 = @"如图所示";
    NSString *str = [NSString stringWithFormat:@"%@%@%@",befor,next1,next2];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:befor]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString: next1]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(15),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:next2]];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                          withSize:18.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.attributedText = text;
    [label sizeToFit];
    [scrollView addSubview:label];
    
    HTUserData *user = [HTUserData sharedInstance];
    
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:user.sex == 1?@"lbm2.0_m":@"lbm2.0_w"]];
    imageView.top = label.bottom + 10.0f;
    imageView.centerX = scrollView.centerX;
    
    [scrollView addSubview:imageView];
    scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom + 40.0f);
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, imageView.bottom+20);
    /*
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  scrollView.scrollsToTop = NO;
  [self.view addSubview:scrollView];

  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                        withSize:18.0f withColor:UIColorFromRGB(105.0f, 142.0f, 166.0f)];
  label.numberOfLines = 0;
//  label.text = @"肌肉大致可以分为构成内脏的平滑肌、构成 心脏的心肌和促进肢体运动的骨骼肌。骨骼 肌可以通过运动得到锻炼（增加）。";
    label.text = @"体重由两个部分组成：\n---去脂部分(Fat Free Mass)\n---脂肪部分(Fat Mass)";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 90.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 8.0f, view.width - 24.0f, 0)
                               withSize:16.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
//  label.text = @"肌肉率(%) = ( 肌肉的重量(kg)\n÷ 体重(kg)) x 100(%)";
//      label.text = @"根据FDA对体脂的要求标准、肌肉量(Muscle Mass)包括骨骼肌,平滑和水分等共同构成";
//  label.textAlignment = NSTextAlignmentCenter;
    label.text = @"去脂部分有骨头，骨骼肌，非骨骼肌。从化学角度看包含19.5%蛋白质，72.4%，8%的骨骼矿物质和0.1%肝糖";
  [label sizeToFit];
  [scrollView addSubview:label];

    
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 16.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
//  label.text = @"通过骨骼肌的维持、增加来塑造 不易胖的体质！";
    label.text = @"根据美国FDA对身体成分测量仪中规定的肌肉量(Muscle Mass)标准为去脂体重减去骨骼矿物质和肝糖";
//  label.textAlignment = NSTextAlignmentCenter;
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 20.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(153.0f, 209.0f, 234.0f)];
  label.numberOfLines = 0;
//  label.text = @"肌肉大致可以分为构成内脏的平滑肌、构 成心脏的心肌和促使肌体运动的骨骼肌。 骨骼肌可以通过运动得到锻炼（增加）。 通过增长骨骼";
    label.text = @"肌肉大致可以分为构成内脏平滑肌、构成心脏的心肌和促使肌体运动的骨骼肌。骨骼肌可以通过运动得到锻炼(增加)。通过增长骨骼肌、提高基础代谢的方式塑造成易消耗能量的体质(不易肥胖的体质)，同时肌肉的力量也得到增加，从而为您带来高质量的生活。";
  [label sizeToFit];
  [scrollView addSubview:label];
  
    label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 20.0f, scrollView.width - 28.0f, 0)
                                 withSize:18.0f withColor:UIColorFromRGB(77.0f, 77.0f, 77.0f)];
    label.numberOfLines = 0;

    label.text = @"*国际上，大多数相关专业单位及BIA设备厂家都以肌肉量(Muscle Mass)作为衡量身体成分的标准，为数不多的企业通过公式计算以骨骼肌作为衡量标准。";
    [label sizeToFit];
    [scrollView addSubview:label];
    
    
  view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, self.view.width - 28.0f, 35.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:view.frame withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"肌肉量的判定";
  label.textAlignment = NSTextAlignmentCenter;
  [scrollView addSubview:label];
    
    HTUserData *context = [HTUserData sharedInstance];
    NSString *name = (context.sex==0)?@"lbm_1.png":@"lbm_2.png";
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  scrollView.contentSize = CGSizeMake(scrollView.width, imageView.bottom);
     */
}

@end
