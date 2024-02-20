//
//  MKCKSettingsModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/24.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"

@interface MKCKSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readBattery]) {
            [self operationFailedBlockWithMsg:@"Read Battery Error" block:failedBlock];
            return;
        }
        
        if (![self readPowerLoss]) {
            [self operationFailedBlockWithMsg:@"Read Power loss notification Error" block:failedBlock];
            return;
        }
        
        if (![self readPowerOnWhenCharging]) {
            [self operationFailedBlockWithMsg:@"Read Power on when charging Error" block:failedBlock];
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
- (BOOL)readBattery {
    __block BOOL success = NO;
    [MKCKInterface ck_readBatteryVoltageWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.battery = returnData[@"result"][@"voltage"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerLoss {
    __block BOOL success = NO;
    [MKCKInterface ck_readPowerLossNotificationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerLoss = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerOnWhenCharging {
    __block BOOL success = NO;
    [MKCKInterface ck_readPowerOnWhenChargingStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerOnWhenCharging = [returnData[@"result"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"SettingsParams"
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
        _readQueue = dispatch_queue_create("SettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
