//
//  MKCKSyncDeviceModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/3/11.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKSyncDeviceModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCKInterface+MKCKConfig.h"

@interface MKCKSyncDeviceModel ()

@property (nonatomic, strong)dispatch_queue_t configQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKSyncDeviceModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.configQueue, ^{
        if (![self readSubscribe]) {
            [self operationFailedBlockWithMsg:@"Read Subscribe Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readPublish]) {
            [self operationFailedBlockWithMsg:@"Read Publish Topic Timeout" block:failedBlock];
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

- (BOOL)readSubscribe {
    __block BOOL success = NO;
    [MKCKInterface ck_readSubscibeTopicWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.subscribeTopic = returnData[@"result"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPublish {
    __block BOOL success = NO;
    [MKCKInterface ck_readPublishTopicWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.publishTopic = returnData[@"result"][@"topic"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"syncDeviceParams"
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

- (dispatch_queue_t)configQueue {
    if (!_configQueue) {
        _configQueue = dispatch_queue_create("syncDeviceQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _configQueue;
}

@end
