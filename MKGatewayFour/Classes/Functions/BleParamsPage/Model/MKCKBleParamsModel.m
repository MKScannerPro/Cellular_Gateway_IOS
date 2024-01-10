//
//  MKCKBleParamsModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/7.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCKBleParamsModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKBleParamsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKBleParamsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readAdvName]) {
            [self operationFailedBlockWithMsg:@"Read Adv Name Error" block:failedBlock];
            return;
        }
        
        if (![self readAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Read Adv Interval Error" block:failedBlock];
            return;
        }
        
        if (![self readTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Adv Timeout Error" block:failedBlock];
            return;
        }
        
        if (![self readResponseStatus]) {
            [self operationFailedBlockWithMsg:@"Read Advertise response packet Error" block:failedBlock];
            return;
        }
        
        if (![self readMajor]) {
            [self operationFailedBlockWithMsg:@"Read Major Error" block:failedBlock];
            return;
        }
        
        if (![self readMinor]) {
            [self operationFailedBlockWithMsg:@"Read Minor Error" block:failedBlock];
            return;
        }
        
        if (![self readUUID]) {
            [self operationFailedBlockWithMsg:@"Read UUID Error" block:failedBlock];
            return;
        }
        
        if (![self readRssi1m]) {
            [self operationFailedBlockWithMsg:@"Read RSSI@1m Error" block:failedBlock];
            return;
        }
        
        if (![self readTxPower]) {
            [self operationFailedBlockWithMsg:@"Read Tx Power Error" block:failedBlock];
            return;
        }
        
        if (![self readNeedPassword]) {
            [self operationFailedBlockWithMsg:@"Read Need Password Error" block:failedBlock];
            return;
        }
        
        if (![self readPassword]) {
            [self operationFailedBlockWithMsg:@"Read Password Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configAdvName]) {
            [self operationFailedBlockWithMsg:@"Config Adv Name Error" block:failedBlock];
            return;
        }
        
        if (![self configAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Config Adv Interval Error" block:failedBlock];
            return;
        }
        
        if (![self configTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Adv Timeout Error" block:failedBlock];
            return;
        }
        
        if (![self configResponseStatus]) {
            [self operationFailedBlockWithMsg:@"Config Advertise response packet Error" block:failedBlock];
            return;
        }
        
        if (![self configMajor]) {
            [self operationFailedBlockWithMsg:@"Config Major Error" block:failedBlock];
            return;
        }
        
        if (![self configMinor]) {
            [self operationFailedBlockWithMsg:@"Config Minor Error" block:failedBlock];
            return;
        }
        
        if (![self configUUID]) {
            [self operationFailedBlockWithMsg:@"Config UUID Error" block:failedBlock];
            return;
        }
        
        if (![self configRssi1m]) {
            [self operationFailedBlockWithMsg:@"Config RSSI@1m Error" block:failedBlock];
            return;
        }
        
        if (![self configTxPower]) {
            [self operationFailedBlockWithMsg:@"Config Tx Power Error" block:failedBlock];
            return;
        }
        
        if (![self configNeedPassword]) {
            [self operationFailedBlockWithMsg:@"Config Need Password Error" block:failedBlock];
            return;
        }
        
        if (self.needPassword) {
            if (![self configPassword]) {
                [self operationFailedBlockWithMsg:@"Config Password Error" block:failedBlock];
                return;
            }
        }
        
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface

- (BOOL)readAdvName {
    __block BOOL success = NO;
    [MKCKInterface ck_readAdvertiseNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advName = returnData[@"result"][@"advName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvName {
    __block BOOL success = NO;
    [MKCKInterface ck_configAdvertiseName:self.advName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_readAdvIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_configAdvInterval:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_readAdvTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_configAdvTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readResponseStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readAdvertiseResponsePacketStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advPacket = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configResponseStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configAdvertiseResponsePacketStatus:self.advPacket sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMajor {
    __block BOOL success = NO;
    [MKCKInterface ck_readBeaconMajorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.major = returnData[@"result"][@"major"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMajor {
    __block BOOL success = NO;
    [MKCKInterface ck_configBeaconMajor:[self.major integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMinor {
    __block BOOL success = NO;
    [MKCKInterface ck_readBeaconMinorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minor = returnData[@"result"][@"minor"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMinor {
    __block BOOL success = NO;
    [MKCKInterface ck_configBeaconMinor:[self.minor integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_readBeaconUUIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uuid = returnData[@"result"][@"uuid"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_configBeaconUUID:self.uuid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRssi1m {
    __block BOOL success = NO;
    [MKCKInterface ck_readBeaconRssiWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi1m = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRssi1m {
    __block BOOL success = NO;
    [MKCKInterface ck_configBeaconRssi:self.rssi1m sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTxPower {
    __block BOOL success = NO;
    [MKCKInterface ck_readTxPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.txPower = [returnData[@"result"][@"txPower"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTxPower {
    __block BOOL success = NO;
    [MKCKInterface ck_configTxPower:self.txPower sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNeedPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_readConnectationNeedPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.needPassword = [returnData[@"result"][@"need"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNeedPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_configNeedPassword:self.needPassword sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_readPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.password = returnData[@"result"][@"password"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_configPassword:self.password sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"BleParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.advName) || self.advName.length > 10) {
        return NO;
    }
    
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 100) {
        return NO;
    }
    
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 0 || [self.timeout integerValue] > 60) {
        return NO;
    }
    
    if (!ValidStr(self.major) || [self.major integerValue] < 0 || [self.major integerValue] > 65535) {
        return NO;
    }
    
    if (!ValidStr(self.minor) || [self.minor integerValue] < 0 || [self.minor integerValue] > 65535) {
        return NO;
    }
    
    if (!ValidStr(self.uuid) || self.uuid.length != 32) {
        return NO;
    }
    
    if (self.rssi1m < -100 || self.rssi1m > 0) {
        return NO;
    }
    
    if (self.needPassword) {
        if (!ValidStr(self.password) || self.password.length < 6 || self.password.length > 10) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("BleQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
