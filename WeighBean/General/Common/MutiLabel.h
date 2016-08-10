//
//  SRTMutiLabel.h
//  shiritan
//
//  Created by seal on 6/17/16.
//  Copyright © 2016 Seamus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutiLabel : UILabel
- (void)setText:(NSString *)text withInteger:(NSString *)count;
- (void)setText:(NSString *)text withPercent:(NSString *)percent;

@end
