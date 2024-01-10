//
//  MKCKFilterByBeaconModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCKFilterByBeaconModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKFilterByBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    if (self.pageType == mk_ck_filterByBeaconPageType_beacon) {
        [self readBeaconDataWithSucBlock:sucBlock failedBlock:failedBlock];
        return;
    }
    if (self.pageType == mk_ck_filterByBeaconPageType_bxpBeacon) {
        [self readBXPBeaconDataWithSucBlock:sucBlock failedBlock:failedBlock];
        return;
    }
    moko_dispatch_main_safe(^{
        if (sucBlock) {
            sucBlock();
        }
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    if (self.pageType == mk_ck_filterByBeaconPageType_beacon) {
        [self configBeaconDataWithSucBlock:sucBlock failedBlock:failedBlock];
        return;
    }
    if (self.pageType == mk_ck_filterByBeaconPageType_bxpBeacon) {
        [self configBXPBeaconDataWithSucBlock:sucBlock failedBlock:failedBlock];
        return;
    }
    moko_dispatch_main_safe(^{
        if (sucBlock) {
            sucBlock();
        }
    });
}

#pragma mark - interface

#pragma mark - iBeacon
- (void)readBeaconDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBeaconFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Status Error" block:failedBlock];
            return;
        }
        if (![self readBeaconFilterMajor]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Major Error" block:failedBlock];
            return;
        }
        if (![self readBeaconFilterMinor]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Minor Error" block:failedBlock];
            return;
        }
        if (![self readBeaconFilterUUID]) {
            [self operationFailedBlockWithMsg:@"Read Beacon UUID Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configBeaconDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configBeaconFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Config Filter Status Error" block:failedBlock];
            return;
        }
        if (![self configBeaconFilterMajor]) {
            [self operationFailedBlockWithMsg:@"Config Beacon Major Error" block:failedBlock];
            return;
        }
        if (![self configBeaconFilterMinor]) {
            [self operationFailedBlockWithMsg:@"Config Beacon Minor Error" block:failedBlock];
            return;
        }
        if (![self configBeaconFilterUUID]) {
            [self operationFailedBlockWithMsg:@"Config Beacon UUID Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)readBeaconFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBeaconStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBeaconFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByBeaconStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBeaconFilterMajor {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBeaconMajorRangeWithSucBlock:^(id  _Nonnull returnData) {
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

- (BOOL)configBeaconFilterMajor {
    __block BOOL success = NO;
    NSInteger min = 0;
    if (ValidStr(self.minMajor)) {
        min = [self.minMajor integerValue];
    }
    NSInteger max = 0;
    if (ValidStr(self.maxMajor)) {
        max = [self.maxMajor integerValue];
    }
    [MKCKInterface ck_configFilterByBeaconMajor:min maxValue:max sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBeaconFilterMinor {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBeaconMinorRangeWithSucBlock:^(id  _Nonnull returnData) {
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

- (BOOL)configBeaconFilterMinor {
    __block BOOL success = NO;
    NSInteger min = 0;
    if (ValidStr(self.minMinor)) {
        min = [self.minMinor integerValue];
    }
    NSInteger max = 0;
    if (ValidStr(self.maxMinor)) {
        max = [self.maxMinor integerValue];
    }
    [MKCKInterface ck_configFilterByBeaconMinor:min maxValue:max sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBeaconFilterUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBeaconUUIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uuid = returnData[@"result"][@"uuid"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBeaconFilterUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByBeaconUUID:self.uuid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - BXP-iBeacon
- (void)readBXPBeaconDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
//        if (![self readBXPBeaconFilterStatus]) {
//            [self operationFailedBlockWithMsg:@"Read Filter Status Error" block:failedBlock];
//            return;
//        }
//        if (![self readBXPBeaconFilterMajor]) {
//            [self operationFailedBlockWithMsg:@"Read Beacon Major Error" block:failedBlock];
//            return;
//        }
//        if (![self readBXPBeaconFilterMinor]) {
//            [self operationFailedBlockWithMsg:@"Read Beacon Minor Error" block:failedBlock];
//            return;
//        }
//        if (![self readBXPBeaconFilterUUID]) {
//            [self operationFailedBlockWithMsg:@"Read Beacon UUID Error" block:failedBlock];
//            return;
//        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configBXPBeaconDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
//        if (![self configBXPBeaconFilterStatus]) {
//            [self operationFailedBlockWithMsg:@"Config Filter Status Error" block:failedBlock];
//            return;
//        }
//        if (![self configBXPBeaconFilterMajor]) {
//            [self operationFailedBlockWithMsg:@"Config Beacon Major Error" block:failedBlock];
//            return;
//        }
//        if (![self configBXPBeaconFilterMinor]) {
//            [self operationFailedBlockWithMsg:@"Config Beacon Minor Error" block:failedBlock];
//            return;
//        }
//        if (![self configBXPBeaconFilterUUID]) {
//            [self operationFailedBlockWithMsg:@"Config Beacon UUID Error" block:failedBlock];
//            return;
//        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}
/*
- (BOOL)readBXPBeaconFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBXPBeaconStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPBeaconFilterStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByBXPBeaconStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPBeaconFilterMajor {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBXPBeaconMajorRangeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        BOOL isOn = [returnData[@"result"][@"isOn"] boolValue];
        if (isOn) {
            self.minMajor = returnData[@"result"][@"minValue"];
            self.maxMajor = returnData[@"result"][@"maxValue"];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPBeaconFilterMajor {
    __block BOOL success = NO;
    BOOL isOn = ValidStr(self.minMajor);
    NSInteger min = 0;
    if (ValidStr(self.minMajor)) {
        min = [self.minMajor integerValue];
    }
    NSInteger max = 0;
    if (ValidStr(self.maxMajor)) {
        max = [self.maxMajor integerValue];
    }
    [MKCKInterface ck_configFilterByBXPBeaconMajor:isOn minValue:min maxValue:max sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPBeaconFilterMinor {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBXPBeaconMinorRangeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        BOOL isOn = [returnData[@"result"][@"isOn"] boolValue];
        if (isOn) {
            self.minMinor = returnData[@"result"][@"minValue"];
            self.maxMinor = returnData[@"result"][@"maxValue"];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPBeaconFilterMinor {
    __block BOOL success = NO;
    BOOL isOn = ValidStr(self.minMinor);
    NSInteger min = 0;
    if (ValidStr(self.minMinor)) {
        min = [self.minMinor integerValue];
    }
    NSInteger max = 0;
    if (ValidStr(self.maxMinor)) {
        max = [self.maxMinor integerValue];
    }
    [MKCKInterface ck_configFilterByBXPBeaconMinor:isOn minValue:min maxValue:max sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPBeaconFilterUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByBXPBeaconUUIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uuid = returnData[@"result"][@"uuid"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPBeaconFilterUUID {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByBXPBeaconUUID:self.uuid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}
*/
#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"filterBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (self.uuid.length > 32 || self.uuid.length % 2 != 0) {
        return NO;
    }
    if (ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        return NO;
    }
    if (!ValidStr(self.minMinor) && ValidStr(self.maxMinor)) {
        return NO;
    }
    if (ValidStr(self.minMinor) && ValidStr(self.maxMinor)) {
        if ([self.minMinor integerValue] < 0 || [self.minMinor integerValue] > 65535) {
            return NO;
        }
        if ([self.maxMinor integerValue] < [self.minMinor integerValue] || [self.maxMinor integerValue] > 65535) {
            return NO;
        }
    }
    
    if (ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        return NO;
    }
    if (!ValidStr(self.minMajor) && ValidStr(self.maxMajor)) {
        return NO;
    }
    if (ValidStr(self.minMajor) && ValidStr(self.maxMajor)) {
        if ([self.minMajor integerValue] < 0 || [self.minMajor integerValue] > 65535) {
            return NO;
        }
        if ([self.maxMajor integerValue] < [self.minMajor integerValue] || [self.maxMajor integerValue] > 65535) {
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
        _readQueue = dispatch_queue_create("filterBeaconQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
