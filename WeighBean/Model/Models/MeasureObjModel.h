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
@property (nonatomic,assign)NSString *fat;
@property (nonatomic,assign)NSString *lbm;
@property (nonatomic,assign)NSString *vat;
@property (nonatomic,assign)NSString *w;
@property (nonatomic,assign)NSString <Optional>*measureTime;

@end
