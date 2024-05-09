//
//  MKCKScanFilterSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKScanFilterSettingsModel : NSObject

/// -127~0
@property (nonatomic, assign)NSInteger rssi;

/// 0:1M PHY (V4.2)      1:1M PHY (V5.0)    2:1M PHY(V4.2) & 1M PHY(V5.0)     3:Coded PHY(V5.0)
@property (nonatomic, assign)NSInteger phy;

/// @[@"Null",@"Only MAC",@"Only ADV Name",@"Only Raw Data",@"ADV Name & Raw Data",@"MAC & ADV Name & Raw Data",@"ADV Name | Raw Data",@"ADV Name & MAC"]
@property (nonatomic, assign)NSInteger relationship;

/// 0:None      1:MAC    2:MAC + Data type     3:MAC + Raw data
@property (nonatomic, assign)NSInteger dataFilter;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
