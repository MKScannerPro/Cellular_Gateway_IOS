//
//  MKCKNetworkModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKNetworkModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface.h"

@interface MKCKNetworkModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKNetworkModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readNetworkStatus]) {
            [self operationFailedBlockWithMsg:@"Read Network Status Error" block:failedBlock];
            return;
        }
        
        if (![self readMQTTStatus]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Status Error" block:failedBlock];
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

- (BOOL)readNetworkStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readNetworkStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger status = [returnData[@"result"][@"status"] integerValue];
        if (status == 0) {
            self.networkStatus = @"Unconnected";
        }else if (status == 1) {
            self.networkStatus = @"Connecting";
        }else if (status == 2) {
            self.networkStatus = @"Connected";
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readMQTTStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger status = [returnData[@"result"][@"status"] integerValue];
        if (status == 0) {
            self.mqttStatus = @"Unconnected";
        }else if (status == 1) {
            self.mqttStatus = @"Connected";
        }
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
        NSError *error = [[NSError alloc] initWithDomain:@"NetworkParams"
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
        _readQueue = dispatch_queue_create("NetworkQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
