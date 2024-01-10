//
//  MKCKFilterByBXPButtonModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKCKFilterByBXPButtonModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKFilterByBXPButtonModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByBXPButtonModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Status Error" block:failedBlock];
            return;
        }
        if (![self readButtonAlarmContent]) {
            [self operationFailedBlockWithMsg:@"Read BXP-Button Content Error" block:failedBlock];
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
        if (![self configFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Config Filter Status Error" block:failedBlock];
            return;
        }
        if (![self configBXPButtonContent]) {
            [self operationFailedBlockWithMsg:@"Config BXP-Button Content Error" block:failedBlock];
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
    [MKCKInterface ck_readBXPButtonFilterStatusWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKCKInterface ck_configFilterByBXPButtonStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readButtonAlarmContent {
    __block BOOL success = NO;
    [MKCKInterface ck_readBXPButtonAlarmFilterStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.singlePress = [returnData[@"result"][@"singlePresse"] boolValue];
        self.doublePress = [returnData[@"result"][@"doublePresse"] boolValue];
        self.longPress = [returnData[@"result"][@"longPresse"] boolValue];
        self.abnormal = [returnData[@"result"][@"abnormal"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPButtonContent {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByBXPButtonAlarmStatus:self.singlePress
                                             doublePress:self.doublePress
                                               longPress:self.longPress
                                      abnormalInactivity:self.abnormal
                                                sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                                             failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"filterButtonParams"
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
        _readQueue = dispatch_queue_create("filterButtonQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
