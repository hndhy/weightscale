//
//  VatViewController.m
//  WeighBean
//
//  Created by liumadu on 15/8/15.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "VatViewController.h"

@implementation VatViewController

- (void)initNavbar
{
  self.title = @"内脂指数";
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
    
    NSString *befor = @"内脏脂肪指的是";
    NSString *next1 = @"人体内脏周围的脂肪";
    NSString *next2 = @"，即下图所示人体胸腔（红色虚线左侧，脊柱右侧）内的脂肪（黄色部分）";
    NSString *str = [NSString stringWithFormat:@"%@%@%@",befor,next1,next2];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(14),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:befor]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(14),NSForegroundColorAttributeName:UIColorFromRGB(56, 150, 213)} range:[str rangeOfString: next1]];
    [text setAttributes:@{NSFontAttributeName:UIFontOfSize(14),NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)} range:[str rangeOfString:next2]];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20, scrollView.width - 40.0f, 0)
                                          withSize:14.0f withColor:UIColorFromRGB(51, 51, 51)];
    label.numberOfLines = 0;
    label.attributedText = text;
    [label sizeToFit];
    [scrollView addSubview:label];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_1_2.0"]];
    imageView1.top = label.bottom + 5.0f;
    imageView1.centerX = scrollView.centerX;
    [scrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_2_2.0"]];
    imageView2.top = imageView1.bottom + 5.0f;
    imageView2.centerX = scrollView.centerX;
    [scrollView addSubview:imageView2];

    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_3_2.0"]];
    imageView3.top = imageView2.bottom + 5.0f;
    imageView3.centerX = scrollView.centerX;
    [scrollView addSubview:imageView3];
    
    scrollView.contentSize = CGSizeMake(scrollView.width, imageView3.bottom + 40.0f);
    layer.frame = CGRectMake(10, 10, CGRectGetWidth(scrollView.frame) - 20, imageView3.bottom+20);
    
    /*
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_EXCEPTNAV)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = YES;
  scrollView.scrollsToTop = NO;
  [self.view addSubview:scrollView];
  UILabel *label = [UILabel createLabelWithFrame:CGRectMake(20.0f, 20.0f, scrollView.width - 40.0f, 0)
                                        withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"* 将腹部CT 扫描图像的内脏周围脂肪面积的大小分为9个等级，利用本公司特有的推算方法计算得出的结果。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_1.png"]];
  imageView.left = 40.0f;
  imageView.top = label.bottom + 20.0f;
  [scrollView addSubview:imageView];
  imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_2.png"]];
  imageView.right = scrollView.width - 40.0f;
  imageView.top = label.bottom + 20.0f;
  [scrollView addSubview:imageView];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, imageView.bottom + 30.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:[UIColor grayColor]];
  label.numberOfLines = 0;
  label.text = @"日本肥胖学会肥胖症诊断标准研究委员会的报告中指出，通过内脏脂肪面积与损害健康的并发症数量的研究得知，如果内脏脂肪面积值超过100 cm²，并发症数量就会显著上升，平均并发症数量会超过1.5 个；如果超过150 cm²，并发症数量会越发呈上升趋势，平均并发症数量将超过2 个。";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 20.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(249.0f, 150.0f, 21.0f)];
  label.numberOfLines = 0;
  label.textAlignment = NSTextAlignmentCenter;
  label.text = @"* 所谓并发症，是指因肥胖而引起的生活习惯病（主要有2型糖尿病、脂肪代谢异常、高血压等）。";
  [label sizeToFit];
  [scrollView addSubview:label];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(14.0f, label.bottom + 40.0f, self.view.width - 28.0f, 65.0f)];
  view.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  [scrollView addSubview:view];
  label = [UILabel createLabelWithFrame:CGRectMake(view.left + 12.0f, view.top + 15.0f, view.width - 24.0f, 0)
                               withSize:24.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.text = @"内脏脂肪越多\n患生活习惯病的危险性越大";
  label.textAlignment = NSTextAlignmentCenter;
  [label sizeToFit];
  [scrollView addSubview:label];
  view.height = label.height + 30.0f;
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, view.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"* 所谓并发症，是指因肥胖而引起的生活习惯病（主要有2型糖尿病、脂肪代谢异常、高血压等）。";
  [label sizeToFit];
  [scrollView addSubview:label];
  imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vat_4.png"]];
  imageView.top = label.bottom + 10.0f;
  imageView.centerX = scrollView.centerX;
  [scrollView addSubview:imageView];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, imageView.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:[UIColor grayColor]];
  label.numberOfLines = 0;
  label.text = @"※本产品无法显示未满18 岁的使用者的内脏脂肪指数。※既有身体脂肪率低、内脏脂肪指数高的情况，也有身体脂肪率高、内脏脂肪指数低的情况。※内脏脂肪指数始终是个大致数。有关医学诊断请咨询医生。";
  [scrollView addSubview:label];
  [label sizeToFit];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  label.text = @"内脏脂肪= 附着在内脏上的脂肪";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 5.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"内脏脂肪与生活习惯病有密切的关系。例如，它会增加血液中的脂肪含量，从而引起高血脂病，而且会扰乱胰岛素的正常代谢导致糖尿病的发生。所以，预防和改善生活习惯病的关键是如何减少内脏脂肪。属于内脏脂肪过多这种类型的肥胖人士，腹部会明显突出，但也有腹部不突出的“隐性肥胖”";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 10.0f, scrollView.width - 28.0f, 0)
                               withSize:20.0f withColor:[UIColor whiteColor]];
  label.numberOfLines = 0;
  label.backgroundColor = UIColorFromRGB(105.0f, 142.0f, 166.0f);
  label.text = @"皮下脂肪= 皮肤下面蓄积的脂肪";
  [label sizeToFit];
  [scrollView addSubview:label];
  label = [UILabel createLabelWithFrame:CGRectMake(14.0f, label.bottom + 5.0f, scrollView.width - 28.0f, 0)
                               withSize:18.0f withColor:UIColorFromRGB(1.0f, 167.0f, 225.0f)];
  label.numberOfLines = 0;
  label.text = @"皮下脂肪指的是皮肤下面蓄积的脂肪，它起到了储存能量、调节人体温度等作用。皮下脂肪不仅存在于腹部，还容易聚集在大臂、臀部、大腿等部位，过分蓄积则会影响体型的匀称。虽然与疾病的发生没有直接的关系，但它对内脏形成压迫，可能会引起各种并发症。";
  [label sizeToFit];
  [scrollView addSubview:label];
  scrollView.contentSize = CGSizeMake(scrollView.width, label.bottom + 10.0f);
     */
}

@end
