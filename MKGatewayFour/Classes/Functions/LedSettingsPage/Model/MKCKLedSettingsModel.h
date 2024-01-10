//
//  MKCKLedSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/6.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKLedSettingsModel : NSObject<mk_ck_indicatorStatusProtocol>

@property (nonatomic, assign)BOOL power;

@property (nonatomic, assign)BOOL powerOff;

@property (nonatomic, assign)BOOL network;

@property (nonatomic, assign)BOOL gps;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
