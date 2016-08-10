//
//  SRTMutiLabel.m
//  shiritan
//
//  Created by seal on 6/17/16.
//  Copyright © 2016 Seamus. All rights reserved.
//

#import "MutiLabel.h"

@implementation MutiLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text withInteger:(NSString *)count
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *foStr = [NSString stringWithFormat:@"%@%@",text,count];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:foStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 4)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:29/255.0 green:168/255.0 blue:225/255.0 alpha:1] range:NSMakeRange(5, [foStr length]-5)];
    self.attributedText = attributedString;
}

- (void)setText:(NSString *)text withPercent:(NSString *)percent
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *foStr = [NSString stringWithFormat:@"%@%@%@",text,percent,@"%"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:foStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108/255.0 green:199/255.0 blue:181/255.0 alpha:1] range:NSMakeRange(4, [foStr length]-4)];
    self.attributedText = attributedString;
}



@end
