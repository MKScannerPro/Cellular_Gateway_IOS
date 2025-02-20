//
//  MKCKUploadPayloadSettingsModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/19.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKUploadPayloadSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCKInterface+MKCKConfig.h"

@interface MKCKUploadPayloadSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKUploadPayloadSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readParams]) {
            [self operationFailedBlockWithMsg:@"Read Parmas Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        })
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configParams]) {
            [self operationFailedBlockWithMsg:@"Config Parmas Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        })
    });
}

#pragma mark - interface

- (BOOL)readParams {
    __block BOOL success = NO;
    [MKCKInterface ck_readPositionUploadPayloadSettingsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.hdop = [returnData[@"result"][@"hdop"] boolValue];
        self.sequenceNumber = [returnData[@"result"][@"sequence"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configParams {
    __block BOOL success = NO;
    [MKCKInterface ck_configPositionUploadPayload:self.hdop sequence:self.sequenceNumber sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"UploadPayloadParams"
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
        _readQueue = dispatch_queue_create("UploadPayloadQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
