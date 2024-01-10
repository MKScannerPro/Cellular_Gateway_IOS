//
//  MKCKFilterByBXPTagModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKCKFilterByBXPTagModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKFilterByBXPTagModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByBXPTagModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Status Error" block:failedBlock];
            return;
        }
        if (![self readFilterPreciseMatch]) {
            [self operationFailedBlockWithMsg:@"Read Filter Precise Match Error" block:failedBlock];
            return;
        }
        if (![self readReverseFilter]) {
            [self operationFailedBlockWithMsg:@"Read Reverse Filter Error" block:failedBlock];
            return;
        }
        if (![self readTagIDList]) {
            [self operationFailedBlockWithMsg:@"Read TagID List Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithTagIDList:(NSArray <NSString *>*)tagIDList
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams:tagIDList]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Config Filter Status Error" block:failedBlock];
            return;
        }
        if (![self configFilterPreciseMatch]) {
            [self operationFailedBlockWithMsg:@"Config Filter Precise Match Error" block:failedBlock];
            return;
        }
        if (![self configReverseFilter]) {
            [self operationFailedBlockWithMsg:@"Config Reverse Filter Error" block:failedBlock];
            return;
        }
        if (![self configTagIDList:tagIDList]) {
            [self operationFailedBlockWithMsg:@"Config TagID List Error" block:failedBlock];
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
    [MKCKInterface ck_readFilterByBXPTagIDStatusWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKCKInterface ck_configFilterByBXPTagIDStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterPreciseMatch {
    __block BOOL success = NO;
    [MKCKInterface ck_readPreciseMatchTagIDStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.precise = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterPreciseMatch {
    __block BOOL success = NO;
    [MKCKInterface ck_configPreciseMatchTagIDStatus:self.precise sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReverseFilter {
    __block BOOL success = NO;
    [MKCKInterface ck_readReverseFilterTagIDStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.reverse = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReverseFilter {
    __block BOOL success = NO;
    [MKCKInterface ck_configReverseFilterTagIDStatus:self.reverse sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTagIDList {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterBXPTagIDListWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tagIDList = returnData[@"result"][@"tagIDList"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTagIDList:(NSArray <NSString *>*)list {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterBXPTagIDList:list sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"FilterByTagParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams:(NSArray <NSString *>*)tagIDList {
    if (tagIDList.count > 10) {
        return NO;
    }
    for (NSString *tagID in tagIDList) {
        if ((tagID.length % 2 != 0) || !ValidStr(tagID) || tagID.length > 12 || ![tagID regularExpressions:isHexadecimal]) {
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
        _readQueue = dispatch_queue_create("FilterByTagQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
