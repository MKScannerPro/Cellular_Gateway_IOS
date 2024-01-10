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

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param deviceName deviceName
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
           deviceName:(NSString *)deviceName
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
