//
//  MKCKAxisSettingsModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/6.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCKAxisSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKAxisSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKAxisSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readWakeupParmas]) {
            [self operationFailedBlockWithMsg:@"Read Wakeup Parmas Errro" block:failedBlock];
            return;
        }
        if (![self readMotionParams]) {
            [self operationFailedBlockWithMsg:@"Read Motion Params Error" block:failedBlock];
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
        if (![self configWakeupParmas]) {
            [self operationFailedBlockWithMsg:@"Config Wakeup Parmas Errro" block:failedBlock];
            return;
        }
        if (![self configMotionParams]) {
            [self operationFailedBlockWithMsg:@"Config Motion Params Error" block:failedBlock];
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
- (BOOL)readWakeupParmas {
    __block BOOL success = NO;
    [MKCKInterface ck_readAxisWakeupParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.wakeupThreshold = returnData[@"result"][@"threshold"];
        self.wakeupDuration = returnData[@"result"][@"duration"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configWakeupParmas {
    __block BOOL success = NO;
    [MKCKInterface ck_configAxisWakeupParams:[self.wakeupThreshold integerValue] duration:[self.wakeupDuration integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMotionParams {
    __block BOOL success = NO;
    [MKCKInterface ck_readAxisMotionParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.motionThreshold = returnData[@"result"][@"threshold"];
        self.motionDuration = returnData[@"result"][@"duration"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMotionParams {
    __block BOOL success = NO;
    [MKCKInterface ck_configAxisMotionParams:[self.motionThreshold integerValue] duration:[self.motionDuration integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"AxisSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.wakeupThreshold) || [self.wakeupThreshold integerValue] < 1 || [self.wakeupThreshold integerValue] > 20) {
        return NO;
    }
    if (!ValidStr(self.wakeupDuration) || [self.wakeupDuration integerValue] < 1 || [self.wakeupDuration integerValue] > 10) {
        return NO;
    }
    if (!ValidStr(self.motionThreshold) || [self.motionThreshold integerValue] < 10 || [self.motionThreshold integerValue] > 250) {
        return NO;
    }
    if (!ValidStr(self.motionDuration) || [self.motionDuration integerValue] < 1 || [self.motionDuration integerValue] > 15) {
        return NO;
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
        _readQueue = dispatch_queue_create("AxisSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
