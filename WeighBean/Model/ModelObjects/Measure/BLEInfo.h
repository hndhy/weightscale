//
//  BLEInfo.h
//  WeighBean
//
//  Created by liumadu on 15/8/8.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEInfo : NSObject

@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;
@property (nonatomic, strong) NSNumber *rssi;

@end
