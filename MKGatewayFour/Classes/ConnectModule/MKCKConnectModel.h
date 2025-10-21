//
//  MKCKConnectModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKCKConnectModel : NSObject

+ (MKCKConnectModel *)shared;

/// 设备连接的时候是否需要密码
@property (nonatomic, assign, readonly)BOOL hasPassword;

@property (nonatomic, copy, readonly)NSString *deviceName;

@property (nonatomic, copy, readonly)NSString *macAddress;

@property (nonatomic, assign, readonly)BOOL isV104;

@property (nonatomic, assign, readonly)BOOL isV200;

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param deviceName deviceName
/// @param deviceType 0:V1.4之前的固件 1:1.4之后的固件 2:2.0需求版本
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
           deviceName:(NSString *)deviceName
           deviceType:(NSInteger)deviceType
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
