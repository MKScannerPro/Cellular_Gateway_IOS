//
//  MKCKNanoBeaconPayloadModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKNanoBeaconPayloadModel : NSObject<mk_ck_bxpNanoBeaconPayloadProtocol>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL manufactureId;

@property (nonatomic, assign)BOOL advType;

@property (nonatomic, assign)BOOL batteryVoltage;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL secCNT;

@property (nonatomic, assign)BOOL triggerStatus;


@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
