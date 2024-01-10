//
//  MKCKBatteryManagementModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKBatteryManagementModel : NSObject

@property (nonatomic, assign)BOOL lowPowerIsOn;

@property (nonatomic, assign)NSInteger threshold;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
