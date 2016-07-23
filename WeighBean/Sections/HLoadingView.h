//
//  HLoadingView.h
//  WeighBean
//
//  Created by 曾宪东 on 15/12/1.
//  Copyright © 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLoadingView : UIView<UIScrollViewDelegate>
{
    UILabel *_titleView;
}
@property (nonatomic,copy) NSString *title;

@property (strong, nonatomic) NSString *resultStr;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *thirdView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *dotArray;
@property (nonatomic, assign) int dotIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) CALayer *backLayer;
@property (nonatomic, strong) CALayer *loadLayer;

@property (nonatomic, strong) UILabel *loadLabel;
@property (nonatomic, strong) NSTimer *loadTimer;

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) BOOL isFinish;

+ (instancetype)defaultView;

+ (void)show;

@end
