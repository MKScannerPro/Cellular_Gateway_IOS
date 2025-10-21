//
//  MKCKFilterByNanoBeaconModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/10/20.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKFilterByNanoBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCKInterface.h"
#import "MKCKInterface+MKCKConfig.h"

@interface MKCKFilterByNanoBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKFilterByNanoBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterInformation]) {
            [self operationFailedBlockWithMsg:@"Read Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithManufactureList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams:macList]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configFilterInformation:macList]) {
            [self operationFailedBlockWithMsg:@"Config Data Error" block:failedBlock];
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

- (BOOL)readFilterInformation {
    __block BOOL success = NO;
    [MKCKInterface ck_readFilterNanoBeaconWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.triggerType = [returnData[@"result"][@"triggerType"] integerValue];
        self.manufactureList = returnData[@"result"][@"manufactureIDList"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterInformation:(NSArray <NSString *>*)list {
    __block BOOL success = NO;
    [MKCKInterface ck_configFilterNanoBeacon:self.isOn advType:self.triggerType manufactureIDList:list sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"FilterByMacParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams:(NSArray <NSString *>*)macList {
    if (macList.count > 10) {
        return NO;
    }
    for (NSString *mac in macList) {
        if ((mac.length != 4) || ![mac regularExpressions:isHexadecimal]) {
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
        _readQueue = dispatch_queue_create("FilterByMacQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
