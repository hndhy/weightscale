//
//  JournalModel.h
//  WeighBean
//
//  Created by sealband on 16/8/25.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "HTAbstractDataSource.h"

@interface JournalModel : HTAbstractDataSource
- (void)getJournalWithStarttime:(NSString *)startTime endTime:(NSString *)endTime pageCount:(NSString *)pageCount starPage:(int)startPage;

@end
