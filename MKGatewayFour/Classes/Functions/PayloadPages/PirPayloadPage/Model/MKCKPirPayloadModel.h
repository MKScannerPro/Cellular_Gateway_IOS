//
//  MKCKPirPayloadModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKPirPayloadModel : NSObject<mk_ck_bxpPIRPayloadProtocol>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL delayResponseStatus;

@property (nonatomic, assign)BOOL doorStatus;

@property (nonatomic, assign)BOOL sensorSensitivity;

@property (nonatomic, assign)BOOL sensorDetectionStatus;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

@property (nonatomic, assign)BOOL rssi1m;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advName;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
