//
//  MKCKHeartbeatReportModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKHeartbeatReportModel : NSObject<mk_ck_heartbeatReportItemsProtocol>

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL accelerometer;

@property (nonatomic, assign)BOOL vehicle;

@property (nonatomic, assign)BOOL sequence;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
