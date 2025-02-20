//
//  MKCKNetworkSettingsV2Model.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/18.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKNetworkSettingsV2Model.h"

#import "MKMacroDefines.h"

#import "MKCKInterface+MKCKConfig.h"

@interface MKCKNetworkRegionModel : NSObject<mk_ck_networkRegionsBandsProtocol>

@property (nonatomic, assign)BOOL us;

@property (nonatomic, assign)BOOL europe;

@property (nonatomic, assign)BOOL korea;

@property (nonatomic, assign)BOOL australia;

@property (nonatomic, assign)BOOL middleEst;

@property (nonatomic, assign)BOOL japan;

@property (nonatomic, assign)BOOL china;

///Only 2 areas can be configured at the same time. If allOfThem is selected, it can only be configured as allOfThem.
@property (nonatomic, assign)BOOL allOfThem;

@end

@implementation MKCKNetworkRegionModel
@end

@interface MKCKNetworkSettingsV2Model ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKNetworkSettingsV2Model

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPriority]) {
            [self operationFailedBlockWithMsg:@"Read Network Priority Error" block:failedBlock];
            return;
        }
        
        if (![self readApn]) {
            [self operationFailedBlockWithMsg:@"Read APN Error" block:failedBlock];
            return;
        }
        
        if (![self readApnUsername]) {
            [self operationFailedBlockWithMsg:@"Read APN Username Error" block:failedBlock];
            return;
        }
        
        if (![self readApnPassword]) {
            [self operationFailedBlockWithMsg:@"Read APN Password Error" block:failedBlock];
            return;
        }
        
        if (![self readConnectTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Connect Timeout Error" block:failedBlock];
            return;
        }
        
        if (![self readPin]) {
            [self operationFailedBlockWithMsg:@"Read Pin Error" block:failedBlock];
            return;
        }
        
        if (![self readRegion]) {
            [self operationFailedBlockWithMsg:@"Read Region Error" block:failedBlock];
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
        NSString *msg = [self checkMsg];
        
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        
        if (![self configPriority]) {
            [self operationFailedBlockWithMsg:@"Config Network Priority Error" block:failedBlock];
            return;
        }
        
        if (![self configApn]) {
            [self operationFailedBlockWithMsg:@"Config APN Error" block:failedBlock];
            return;
        }
        
        if (![self configApnUsername]) {
            [self operationFailedBlockWithMsg:@"Config APN Username Error" block:failedBlock];
            return;
        }
        
        if (![self configApnPassword]) {
            [self operationFailedBlockWithMsg:@"Config APN Password Error" block:failedBlock];
            return;
        }
        
        if (![self configConnectTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Connect Timeout Error" block:failedBlock];
            return;
        }
        
        if (![self configPin]) {
            [self operationFailedBlockWithMsg:@"Config Pin Error" block:failedBlock];
            return;
        }
        
        if (![self configRegion]) {
            [self operationFailedBlockWithMsg:@"Config Region Error" block:failedBlock];
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

- (BOOL)readPriority {
    __block BOOL success = NO;
    [MKCKInterface ck_readNetworkPriorityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.priority = [returnData[@"result"][@"priority"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPriority {
    __block BOOL success = NO;
    [MKCKInterface ck_configNetworkPriority:self.priority sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readApn {
    __block BOOL success = NO;
    [MKCKInterface ck_readApnWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.apn = returnData[@"result"][@"apn"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configApn {
    __block BOOL success = NO;
    [MKCKInterface ck_configApn:self.apn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readApnUsername {
    __block BOOL success = NO;
    [MKCKInterface ck_readApnUsernameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.userName = returnData[@"result"][@"username"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configApnUsername {
    __block BOOL success = NO;
    [MKCKInterface ck_configApnUsername:self.userName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readApnPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_readApnPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.password = returnData[@"result"][@"password"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configApnPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_configApnPassword:self.password sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConnectTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_readNBConnectTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configConnectTimeout {
    __block BOOL success = NO;
    [MKCKInterface ck_configNBConnectTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPin {
    __block BOOL success = NO;
    [MKCKInterface ck_readNBPinWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pin = returnData[@"result"][@"pin"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPin {
    __block BOOL success = NO;
    [MKCKInterface ck_configNBPin:self.pin sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRegion {
    __block BOOL success = NO;
    [MKCKInterface ck_readNBRegionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.regionsBands = [returnData[@"result"][@"region"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRegion {
    __block BOOL success = NO;
    
    MKCKNetworkRegionModel *regionModel = [[MKCKNetworkRegionModel alloc] init];
    if (self.regionsBands == 0x80) {
        regionModel.allOfThem = YES;
    }else {
        regionModel.allOfThem = NO;
        regionModel.us = (self.regionsBands & (1 << 0)) != 0;
        regionModel.europe = (self.regionsBands & (1 << 1)) != 0;
        regionModel.korea = (self.regionsBands & (1 << 2)) != 0;
        regionModel.australia = (self.regionsBands & (1 << 3)) != 0;
        regionModel.middleEst = (self.regionsBands & (1 << 4)) != 0;
        regionModel.japan = (self.regionsBands & (1 << 5)) != 0;
        regionModel.china = (self.regionsBands & (1 << 6)) != 0;
    }
    
    [MKCKInterface ck_configNBRegion:regionModel sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"NetworkParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)checkMsg {
    if (self.priority < 0 || self.priority > 10) {
        return @"Priority Error";
    }
    
    if (self.apn.length > 100) {
        return @"APN Error";
    }
    
    if (self.userName.length > 100) {
        return @"Username Error";
    }
    
    if (self.password.length > 100) {
        return @"Password Error";
    }
    
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 30 || [self.timeout integerValue] > 600) {
        return @"Connect timeout Error";
    }
    
    return @"";
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
