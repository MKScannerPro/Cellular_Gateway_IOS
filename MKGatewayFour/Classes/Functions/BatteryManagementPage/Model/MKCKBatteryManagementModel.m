//
//  MKCKBatteryManagementModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCKBatteryManagementModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKBatteryManagementModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKBatteryManagementModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readStatus]) {
            [self operationFailedBlockWithMsg:@"Read Status Error" block:failedBlock];
            return;
        }
        
        if (![self readThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Threshold Error" block:failedBlock];
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
        
        if (![self configStatus]) {
            [self operationFailedBlockWithMsg:@"Config Status Error" block:failedBlock];
            return;
        }
        
        if (![self configThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Threshold Error" block:failedBlock];
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
- (BOOL)readStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readLowPowerNotificationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerIsOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configLowPowerNotification:self.lowPowerIsOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readThreshold {
    __block BOOL success = NO;
    [MKCKInterface ck_readLowPowerThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.threshold = [returnData[@"result"][@"threshold"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configThreshold {
    __block BOOL success = NO;
    [MKCKInterface ck_configLowPowerThreshold:self.threshold sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BatteryManagementParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("BatteryManagementQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
