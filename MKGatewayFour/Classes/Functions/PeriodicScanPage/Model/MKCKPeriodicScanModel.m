//
//  MKCKPeriodicScanModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/26.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKPeriodicScanModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKPeriodicScanModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKPeriodicScanModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readInterval]) {
            [self operationFailedBlockWithMsg:@"Read Interval Error" block:failedBlock];
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
        
        if (![self configInterval]) {
            [self operationFailedBlockWithMsg:@"Config Interval Error" block:failedBlock];
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
- (BOOL)readInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_readPeriodicScanImmediateReportParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.duration = returnData[@"result"][@"duration"];
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configInterval {
    __block BOOL success = NO;
    [MKCKInterface ck_configPeriodicScanImmediateReportDuratin:[self.duration integerValue] interval:[self.interval integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"PeriodicScanParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.duration) || [self.duration integerValue] < 3 || [self.duration integerValue] > 3600) {
        return NO;
    }
    if (!ValidStr(self.interval) || [self.interval integerValue] < 10 || [self.interval integerValue] > 86400) {
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
        _readQueue = dispatch_queue_create("PeriodicScanQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
