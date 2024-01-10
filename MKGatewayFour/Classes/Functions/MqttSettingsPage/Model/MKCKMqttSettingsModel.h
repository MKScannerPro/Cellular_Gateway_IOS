//
//  MKCKMqttSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKExcelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKMqttSettingsModel : NSObject<MKCKExcelDeviceProtocol>

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *clientID;

@property (nonatomic, copy)NSString *subscribeTopic;

@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL cleanSession;

@property (nonatomic, assign)NSInteger qos;

@property (nonatomic, copy)NSString *keepAlive;

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientKeyName;

@property (nonatomic, copy)NSString *clientCertName;

- (NSString *)checkParams;

/// 更新数据
/// @param model 数据源
- (void)updateValue:(MKCKMqttSettingsModel *)model;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
