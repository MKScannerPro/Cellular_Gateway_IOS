//
//  MKCKBleParamsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/7.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKBleParamsModel : NSObject

@property (nonatomic, copy)NSString *advName;

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, assign)BOOL advPacket;

@property (nonatomic, copy)NSString *major;

@property (nonatomic, copy)NSString *minor;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, assign)NSInteger rssi1m;

@property (nonatomic, assign)NSInteger txPower;

@property (nonatomic, assign)BOOL needPassword;

@property (nonatomic, copy)NSString *password;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
