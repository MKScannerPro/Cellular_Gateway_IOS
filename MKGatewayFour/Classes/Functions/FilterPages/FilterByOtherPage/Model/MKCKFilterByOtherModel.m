//
//  MKCKFilterByOtherModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2021/12/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCKFilterByOtherModel.h"

#import "MKMacroDefines.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@implementation MKCKFilterRawAdvDataModel

- (BOOL)validParams {
    if (!ValidStr(self.dataType)) {
        //新需求，DataType为空等同于00，
        self.dataType = @"00";
    }
    if ([self.dataType isEqualToString:@"00"]) {
        self.minIndex = 0;
        self.maxIndex = 0;
    }
    if (!ValidStr(self.dataType) || self.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.dataType]) {
        return NO;
    }
    if (self.minIndex == 0 && self.maxIndex == 0) {
        if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData] || (self.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (self.minIndex < 0 || self.minIndex > 29 || self.maxIndex < 0 || self.maxIndex > 29) {
        return NO;
    }
    if (self.minIndex == 0 && self.maxIndex != 0) {
        return NO;
    }
    if (self.maxIndex < self.minIndex) {
        return NO;
    }
    if (!ValidStr(self.rawData) || self.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.rawData]) {
        return NO;
    }
    NSInteger totalLen = (self.maxIndex - self.minIndex + 1) * 2;
    if (totalLen > 58 || self.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

@end


@interface MKCKFilterByOtherModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByOtherModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Status Error" block:failedBlock];
            return;
        }
        if (![self readRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Relationship Error" block:failedBlock];
            return;
        }
        if (![self readConditions]) {
            [self operationFailedBlockWithMsg:@"Read Conditions Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithRawDataList:(NSArray <MKCKFilterRawAdvDataModel *>*)list
                 relationship:(mk_ck_filterByOther)relationship
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configConditions:list]) {
            [self operationFailedBlockWithMsg:@"Config Conditions Error" block:failedBlock];
            return;
        }
        if (![self configFilterStatus]) {
            [self operationFailedBlockWithMsg:@"Config Filter Status Error" block:failedBlock];
            return;
        }
        if (![self configRelationship:relationship]) {
            [self operationFailedBlockWithMsg:@"Config Relationship Error" block:failedBlock];
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
    [MKCKInterface ck_readFilterByOtherStatusWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKCKInterface ck_configFilterByOtherStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRelationship {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByOtherRelationshipWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.relationship = [returnData[@"result"][@"relationship"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRelationship:(NSInteger)relationship {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByOtherRelationship:relationship sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConditions {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterByOtherConditionsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rawDataList = returnData[@"result"][@"conditionList"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configConditions:(NSArray <MKCKFilterRawAdvDataModel *>*)list {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterByOtherConditions:list sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterOtherParams"
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
        _readQueue = dispatch_queue_create("filterOtherQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
