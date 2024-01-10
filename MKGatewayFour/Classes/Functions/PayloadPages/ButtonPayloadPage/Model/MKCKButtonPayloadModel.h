//
//  MKCKButtonPayloadModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKButtonPayloadModel : NSObject<mk_ck_bxpButtonPayloadProtocol>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL frameType;

@property (nonatomic, assign)BOOL statusFlag;

@property (nonatomic, assign)BOOL triggerCount;

@property (nonatomic, assign)BOOL deviceId;

@property (nonatomic, assign)BOOL firmwareType;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
