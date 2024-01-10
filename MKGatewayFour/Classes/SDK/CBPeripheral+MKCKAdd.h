//
//  CBPeripheral+MKCKAdd.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKCKAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ck_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ck_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ck_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ck_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ck_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ck_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ck_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ck_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ck_log;

- (void)ck_updateCharacterWithService:(CBService *)service;

- (void)ck_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)ck_connectSuccess;

- (void)ck_setNil;

@end

NS_ASSUME_NONNULL_END
