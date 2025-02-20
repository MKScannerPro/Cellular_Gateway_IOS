//
//  MKCKBXPSPayloadModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/19.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKBXPSPayloadModel : NSObject<mk_ck_bxpBXPSPayloadProtocol>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL sensorStatus;

@property (nonatomic, assign)BOOL hallTriggerEventCount;

@property (nonatomic, assign)BOOL motionTriggerEventCount;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL tagID;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL TH;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
