//
//  MeasureObjModel.h
//  WeighBean
//
//  Created by sealband on 16/8/17.
//  Copyright © 2016年 lmd. All rights reserved.
//

#import "JSONModel.h"
@protocol MeasureObjModel <NSObject>
@end

@interface MeasureObjModel : JSONModel
@property (nonatomic,copy)NSString *fat;
@property (nonatomic,copy)NSString *lbm;
@property (nonatomic,copy)NSString *vat;
@property (nonatomic,copy)NSString *w;
@property (nonatomic,copy)NSString <Optional>*measureTime;

@end
