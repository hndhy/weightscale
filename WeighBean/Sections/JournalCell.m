//
//  JournalCell.m
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JournalCell.h"
#import "UtilsMacro.h"
#import "UIView+Ext.h"
#import <UIImageView+WebCache.h>


@implementation JournalCell
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
        
        
        
      
        

        
        picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, self.frame.size.width, 100)];
        picView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:picView];
        

        
        
        
        
        
        
        
     
    }
    return self;
}

- (void)loadContent:(JournalObjModel *)obj path:(NSIndexPath *)path
{
    
    self.obj = obj;
    self.path = path;
    
    NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:[obj.createTime intValue]/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    [picView sd_setImageWithURL:[NSURL URLWithString:obj.pics] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        picView.image = image;
    }];
    

    
}


@end
