//
//  MKCKMotionFixModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/4.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCKMotionFixModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKMotionFixModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKMotionFixModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFixWhenStart]) {
            [self operationFailedBlockWithMsg:@"Read Fix when starts Error" block:failedBlock];
            return;
        }
        if (![self readFixInTrip]) {
            [self operationFailedBlockWithMsg:@"Read Fix in trip Error" block:failedBlock];
            return;
        }
        if (![self readFixInTripReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Fix in trip report interval Error" block:failedBlock];
            return;
        }
        if (![self readFixWhenStop]) {
            [self operationFailedBlockWithMsg:@"Read Fix when stops Error" block:failedBlock];
            return;
        }
        if (![self readMotionStopsTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Motion stops timeout Error" block:failedBlock];
            return;
        }
        if (![self readFixInStationary]) {
            [self operationFailedBlockWithMsg:@"Read Fix in stationary Error" block:failedBlock];
            return;
        }
        if (![self readFixInStationaryReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Fix in stationary report interval Error" block:failedBlock];
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
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configFixWhenStart]) {
            [self operationFailedBlockWithMsg:@"Config Fix when starts Error" block:failedBlock];
            return;
        }
        if (![self configFixInTrip]) {
            [self operationFailedBlockWithMsg:@"Config Fix in trip Error" block:failedBlock];
            return;
        }
        if (![self configFixInTripReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Fix in trip report interval Error" block:failedBlock];
            return;
        }
        if (![self configFixWhenStop]) {
            [self operationFailedBlockWithMsg:@"Config Fix when stops Error" block:failedBlock];
            return;
        }
        if (![self configMotionStopsTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Motion stops timeout Error" block:failedBlock];
            return;
        }
        if (![self configFixInStationary]) {
            [self operationFailedBlockWithMsg:@"Config Fix in stationary Error" block:failedBlock];
            return;
        }
        if (![self configFixInStationaryReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Fix in stationary report interval Error" block:failedBlock];
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
- (BOOL)readFixWhenStart {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixWhenStartsStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixWhenStart = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixWhenStart {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixWhenStartsStatus:self.fixWhenStart sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixInTrip {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixInTripStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixInTrip = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixInTrip {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixInTripStatus:self.fixInTrip sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixInTripReportInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixInTripReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixInTripInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixInTripReportInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixInTripReportInterval:[self.fixInTripInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixWhenStop {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixWhenStopsStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixWhenStop = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixWhenStop {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixWhenStopsStatus:self.fixWhenStop sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMotionStopsTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixWhenStopsTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixWhenStopTimeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMotionStopsTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixWhenStopsTimeout:[self.fixWhenStopTimeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixInStationary {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixInStationaryStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixInStationary = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixInStationary {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixInStationaryStatus:self.fixInStationary sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixInStationaryReportInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_readFixInStationaryReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixInStationaryInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixInStationaryReportInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_configFixInStationaryReportInterval:[self.fixInStationaryInterval integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MotionFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.fixInTripInterval) || [self.fixInTripInterval integerValue] < 10 || [self.fixInTripInterval integerValue] > 86400) {
        return NO;
    }
    if (!ValidStr(self.fixWhenStopTimeout) || [self.fixWhenStopTimeout integerValue] < 3 || [self.fixWhenStopTimeout integerValue] > 180) {
        return NO;
    }
    if (!ValidStr(self.fixInStationaryInterval) || [self.fixInStationaryInterval integerValue] < 1 || [self.fixInStationaryInterval integerValue] > 1440) {
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
        _readQueue = dispatch_queue_create("MotionFixQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
