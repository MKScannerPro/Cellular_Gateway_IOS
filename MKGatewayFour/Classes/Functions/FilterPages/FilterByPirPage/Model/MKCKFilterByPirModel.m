//
//  MKCKFilterByPirModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKFilterByPirModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKFilterByPirModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByPirModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter PIR Status Error" block:failedBlock];
            return;
        }
        if (![self readDelayResponseStatus]) {
            [self operationFailedBlockWithMsg:@"Read Delay response status Error" block:failedBlock];
            return;
        }
        if (![self readDoorStatus]) {
            [self operationFailedBlockWithMsg:@"Read Door status Error" block:failedBlock];
            return;
        }
        if (![self readSensorSensitivity]) {
            [self operationFailedBlockWithMsg:@"Read Sensor sensitivity Error" block:failedBlock];
            return;
        }
        if (![self readDetectionStatus]) {
            [self operationFailedBlockWithMsg:@"Read Detection status Error" block:failedBlock];
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
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        NSString *msg = [self checkParams];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Config Filter PIR Status Error" block:failedBlock];
            return;
        }
        if (![self configDelayResponseStatus]) {
            [self operationFailedBlockWithMsg:@"Config Delay response status Error" block:failedBlock];
            return;
        }
        if (![self configDoorStatus]) {
            [self operationFailedBlockWithMsg:@"Config Door status Error" block:failedBlock];
            return;
        }
        if (![self configSensorSensitivity]) {
            [self operationFailedBlockWithMsg:@"Config Sensor sensitivity Error" block:failedBlock];
            return;
        }
        if (![self configDetectionStatus]) {
            [self operationFailedBlockWithMsg:@"Config Detection status Error" block:failedBlock];
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
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readPirFilterStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDelayResponseStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readPirFilterDelayResponseStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.delayRespneseStatus = [returnData[@"result"][@"status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDelayResponseStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterDelayResponseStatus:self.delayRespneseStatus sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDoorStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readPirFilterDoorStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.doorStatus = [returnData[@"result"][@"status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDoorStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterDoorStatus:self.doorStatus sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSensorSensitivity {
    __block BOOL success = NO;
    [MKCKInterface ck_readPirFilterSensorSensitivityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sensorSensitivity = [returnData[@"result"][@"sensitivity"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSensorSensitivity {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterSensorSensitivity:self.sensorSensitivity sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDetectionStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readPirFilterDetectionStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sensorDetectionStatus = [returnData[@"result"][@"status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDetectionStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterDetectionStatus:self.sensorDetectionStatus sucBlock:^{
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
    [MKCKInterface ck_readPirFilterByMajorRangeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minMajor = returnData[@"result"][@"minValue"];
        self.maxMajor = returnData[@"result"][@"maxValue"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMajor {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterByMajorRange:[self.minMajor integerValue] maxValue:[self.maxMajor integerValue] sucBlock:^{
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
    [MKCKInterface ck_readPirFilterByMinorRangeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minMinor = returnData[@"result"][@"minValue"];
        self.maxMinor = returnData[@"result"][@"maxValue"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMinor {
    __block BOOL success = NO;
    [MKCKInterface ck_configPirFilterByMinorRange:[self.minMinor integerValue] maxValue:[self.maxMinor integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterByPirParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)checkParams {
    if (!ValidStr(self.minMajor) && ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (!ValidStr(self.minMinor) && ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if (ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if ([self.minMinor integerValue] < 0 || [self.minMinor integerValue] > 65535 || [self.maxMinor integerValue] < [self.minMinor integerValue] || [self.maxMinor integerValue] > 65535) {
        return @"Minor error";
    }
    if ([self.minMajor integerValue] < 0 || [self.minMajor integerValue] > 65535 || [self.maxMajor integerValue] < [self.minMajor integerValue] || [self.maxMajor integerValue] > 65535) {
        return @"Major error";
    }
    return @"";
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
        _readQueue = dispatch_queue_create("filterByPirQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
