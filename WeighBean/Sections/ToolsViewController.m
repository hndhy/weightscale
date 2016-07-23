//
//  ToolsViewController.m
//  WeighBean
//
//  Created by 曾宪东 on 15/11/13.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import "ToolsViewController.h"
#import "UIViewController+RESideMenu.h"
#import "WebViewDetailViewController.h"
#import "LibMacro.h"
#import "ToolsModel.h"
#import "ToolsModelHandler.h"
#import "ToolsObjModel.h"
#import <UIImageView+WebCache.h>
#import "WebViewDetailViewController.h"

@interface ToolsViewController ()<UIWebViewDelegate,ToolsModelProtocol>
{
    UIScrollView *_scroll;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)ToolsModelHandler *handle;
@property (nonatomic,strong)ToolsModel *listModel;
@property (nonatomic,copy) NSString *lineCount;

@end

@implementation ToolsViewController

- (void)initModel
{
    self.handle = [[ToolsModelHandler alloc] initWithController:self];
    self.listModel = [[ToolsModel alloc] initWithHandler:self.handle];
    _dataArray = [[NSMutableArray alloc] init];
    [self.listModel getTools];
}

- (void)initNavbar
{
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 145.0f, 44.0f)];
    self.navigationItem.titleView = titleView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, titleView.width, 44.0f)
                                           withSize:18.0f withColor:UIColorFromRGB(51.0f, 51.0f, 51.0f)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"创星工具";
    [titleView addSubview:titleLabel];
    
//    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
//    [rightButton setImage:[UIImage imageNamed:@"menu_nav_bar.png"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.transform = CGAffineTransformMakeRotation(-M_PI);
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightAction
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!_scroll)
    {
        _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
    }
    [self.view addSubview:_scroll];
    
}

- (void)loadContent
{
    for ( UIView *view in _scroll.subviews)
    {
        [view removeFromSuperview];
    }
     CGFloat oneH = 100;
    UIView  *_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, oneH*3)];
    [_scroll addSubview:_contentView];
    for (int i = 0 ; i < _dataArray.count; i ++) {
        int row = i/2;
        int lie = i%2;
        
        ToolsObjModel *obj = _dataArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_contentView.width/2*lie, oneH*row, _contentView.width/2, oneH);
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((btn.width-50)/2, 10, 50, 50)];
        [btn addSubview:imageview];
        
        [imageview sd_setImageWithURL:[NSURL  URLWithString:obj.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image)
            {
                imageview.image = image;
            }
        }];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageview.bottom+10, btn.width, 20)];
        label.text = obj.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(58, 58, 58);
        [btn addSubview:label];
        
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, oneH + row*oneH - 0.5, _contentView.width, 0.5);
        line.backgroundColor = UIColorFromRGB(225, 225, 225).CGColor;
        [_contentView.layer addSublayer:line];
    }
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, 0, _contentView.width, 0.5);
    line.backgroundColor = UIColorFromRGB(225, 225, 225).CGColor;
    [_contentView.layer addSublayer:line];
    
    line = [CALayer layer];
    line.frame = CGRectMake(_contentView.width/2, 0,0.5, oneH*3);
    line.backgroundColor =  UIColorFromRGB(225, 225, 225).CGColor;
    [_contentView.layer addSublayer:line];
    
//    UILabel *_onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(-2, CGRectGetMaxY(_contentView.frame) + 20, SCREEN_WIDTH + 4, 60)];
//    _onlineLabel.backgroundColor = [UIColor whiteColor];
//    _onlineLabel.textAlignment = NSTextAlignmentCenter;
//    _onlineLabel.font = [UIFont systemFontOfSize:14];
//    _onlineLabel.numberOfLines = 2;
//    _onlineLabel.layer.borderWidth = 0.5;
//    _onlineLabel.layer.borderColor =  UIColorFromRGB(225, 225, 225).CGColor;
//    _onlineLabel.textColor = UIColorFromRGB(58, 58, 58);
//
//    
//    NSString *online = [NSString stringWithFormat:@"在线人数\n%@",self.lineCount];
//    _onlineLabel.text = online;
//    
//    [_scroll addSubview:_onlineLabel];
    
    _scroll.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(line.frame) + 1);
}

- (void)pushDetail:(UIButton *)btn
{
    if (btn.tag < _dataArray.count)
    {
        HTUserData *userData = [HTUserData sharedInstance];
        ToolsObjModel *obj = _dataArray[btn.tag];
        NSString *burl = [NSString stringWithFormat:@"%@?os=ios&uid=%@",obj.url,userData.uid];
        
        NSString *title = obj.title;
        if ([title rangeOfString:@"开单"].length) {
            title = @"开单历史";
        }
        
        WebViewDetailViewController *planDetailVC = [[WebViewDetailViewController alloc]init];
        planDetailVC.titleName = title;
        planDetailVC.urlName = burl;
        planDetailVC.isOutNav = YES;
        [self.navigationController pushViewController:planDetailVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)syncFinished:(ToolsResponse *)response
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:response.results];
    self.lineCount = response.onlineCount;
    [self loadContent];
}

- (void)syncFailure
{
    
}
@end
