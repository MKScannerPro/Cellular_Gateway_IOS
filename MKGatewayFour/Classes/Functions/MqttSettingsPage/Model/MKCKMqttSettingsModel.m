//
//  MKCKMqttSettingsModel.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKMqttSettingsModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCKInterface+MKCKConfig.h"

@interface MKCKMqttSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t configQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCKMqttSettingsModel

- (NSString *)checkParams {
    if (!ValidStr(self.host) || self.host.length > 64 || ![self.host isAsciiString]) {
        return @"Host error";
    }
    if (!ValidStr(self.port) || [self.port integerValue] < 1 || [self.port integerValue] > 65535) {
        return @"Port error";
    }
    if (!ValidStr(self.clientID) || self.clientID.length > 64 || ![self.clientID isAsciiString]) {
        return @"ClientID error";
    }
    if (!ValidStr(self.publishTopic) || self.publishTopic.length > 128 || ![self.publishTopic isAsciiString]) {
        return @"PublishTopic error";
    }
    if (!ValidStr(self.subscribeTopic) || self.subscribeTopic.length > 128 || ![self.subscribeTopic isAsciiString]) {
        return @"SubscribeTopic error";
    }
    if (self.qos < 0 || self.qos > 2) {
        return @"Qos error";
    }
    if (!ValidStr(self.keepAlive) || [self.keepAlive integerValue] < 10 || [self.keepAlive integerValue] > 120) {
        return @"KeepAlive error";
    }
    if (self.userName.length > 256 || (ValidStr(self.userName) && ![self.userName isAsciiString])) {
        return @"UserName error";
    }
    if (self.password.length > 256 || (ValidStr(self.password) && ![self.password isAsciiString])) {
        return @"Password error";
    }
    if (self.sslIsOn) {
        if (self.certificate < 0 || self.certificate > 2) {
            return @"Certificate error";
        }
        if (self.certificate == 0) {
            return @"";
        }
        if (!ValidStr(self.caFileName)) {
            return @"CA File cannot be empty.";
        }
        if (self.certificate == 2 && (!ValidStr(self.clientKeyName) || !ValidStr(self.clientCertName))) {
            return @"Client File cannot be empty.";
        }
    }
    
    return @"";
}

- (void)updateValue:(MKCKMqttSettingsModel *)model {
    if (!model || ![model isKindOfClass:MKCKMqttSettingsModel.class]) {
        return;
    }
    self.host = model.host;
    self.port = model.port;
    self.clientID = model.clientID;
    self.subscribeTopic = model.subscribeTopic;
    self.publishTopic = model.publishTopic;
    self.cleanSession = model.cleanSession;
    
    self.qos = model.qos;
    self.keepAlive = model.keepAlive;
    self.userName = model.userName;
    self.password = model.password;
    self.sslIsOn = model.sslIsOn;
    self.certificate = model.certificate;
    self.caFileName = model.caFileName;
    self.clientKeyName = model.clientKeyName;
    self.clientCertName = model.clientCertName;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.configQueue, ^{
        if (![self readHost]) {
            [self operationFailedBlockWithMsg:@"Read Host Timeout" block:failedBlock];
            return;
        }
        if (![self readPort]) {
            [self operationFailedBlockWithMsg:@"Read Port Timeout" block:failedBlock];
            return;
        }
        if (![self readClientID]) {
            [self operationFailedBlockWithMsg:@"Read Client ID Timeout" block:failedBlock];
            return;
        }
        if (![self readUsername]) {
            [self operationFailedBlockWithMsg:@"Read Username Timeout" block:failedBlock];
            return;
        }
        if (![self readPassword]) {
            [self operationFailedBlockWithMsg:@"Read Password Timeout" block:failedBlock];
            return;
        }
        if (![self readCleanSession]) {
            [self operationFailedBlockWithMsg:@"Read Clean Session Timeout" block:failedBlock];
            return;
        }
        if (![self readKeepAlive]) {
            [self operationFailedBlockWithMsg:@"Read KeepAlive Timeout" block:failedBlock];
            return;
        }
        if (![self readQos]) {
            [self operationFailedBlockWithMsg:@"Read Qos Timeout" block:failedBlock];
            return;
        }
        if (![self readSubscribe]) {
            [self operationFailedBlockWithMsg:@"Read Subscribe Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readPublish]) {
            [self operationFailedBlockWithMsg:@"Read Publish Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readSSLStatus]) {
            [self operationFailedBlockWithMsg:@"Read SSL Status Timeout" block:failedBlock];
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
    dispatch_async(self.configQueue, ^{
        NSString *checkMsg = [self checkParams];
        if (ValidStr(checkMsg)) {
            [self operationFailedBlockWithMsg:checkMsg block:failedBlock];
            return;
        }
        if (![self configHost]) {
            [self operationFailedBlockWithMsg:@"Config Host Timeout" block:failedBlock];
            return;
        }
        if (![self configPort]) {
            [self operationFailedBlockWithMsg:@"Config Port Timeout" block:failedBlock];
            return;
        }
        if (![self configClientID]) {
            [self operationFailedBlockWithMsg:@"Config Client Id Timeout" block:failedBlock];
            return;
        }
        if (![self configUserName]) {
            [self operationFailedBlockWithMsg:@"Config UserName Timeout" block:failedBlock];
            return;
        }
        if (![self configPassword]) {
            [self operationFailedBlockWithMsg:@"Config Password Timeout" block:failedBlock];
            return;
        }
        if (![self configCleanSession]) {
            [self operationFailedBlockWithMsg:@"Config Clean Session Timeout" block:failedBlock];
            return;
        }
        if (![self configKeepAlive]) {
            [self operationFailedBlockWithMsg:@"Config Keep Alive Timeout" block:failedBlock];
            return;
        }
        if (![self configQos]) {
            [self operationFailedBlockWithMsg:@"Config Qos Timeout" block:failedBlock];
            return;
        }
        if (![self configSubscribe]) {
            [self operationFailedBlockWithMsg:@"Config Subscribe Topic Timeout" block:failedBlock];
            return;
        }
        if (![self configPublish]) {
            [self operationFailedBlockWithMsg:@"Config Publish Topic Timeout" block:failedBlock];
            return;
        }
        
        if (![self configSSLStatus]) {
            [self operationFailedBlockWithMsg:@"Config SSL Status Timeout" block:failedBlock];
            return;
        }
        if (self.sslIsOn && self.certificate > 0) {
            if (![self configCAFile]) {
                [self operationFailedBlockWithMsg:@"Config CA File Error" block:failedBlock];
                return;
            }
            if (self.certificate == 2) {
                //双向验证
                if (![self configClientKey]) {
                    [self operationFailedBlockWithMsg:@"Config Client Key Error" block:failedBlock];
                    return;
                }
                if (![self configClientCert]) {
                    [self operationFailedBlockWithMsg:@"Config Client Cert Error" block:failedBlock];
                    return;
                }
            }
        }
        
        if (![self restart]) {
            [self operationFailedBlockWithMsg:@"Restart Error" block:failedBlock];
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
- (BOOL)readHost {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerHostWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.host = returnData[@"result"][@"host"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHost {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerHost:self.host sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPort {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerPortWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.port = returnData[@"result"][@"port"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPort {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerPort:[self.port integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readClientID {
    __block BOOL success = NO;
    [MKCKInterface ck_readClientIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.clientID = returnData[@"result"][@"clientID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientID {
    __block BOOL success = NO;
    [MKCKInterface ck_configClientID:self.clientID sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUsername {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerUserNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.userName = returnData[@"result"][@"username"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUserName {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerUserName:self.userName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerPasswordWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.password = returnData[@"result"][@"password"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPassword {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerPassword:self.password sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCleanSession {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerCleanSessionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.cleanSession = [returnData[@"result"][@"clean"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCleanSession {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerCleanSession:self.cleanSession sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readKeepAlive {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerKeepAliveWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.keepAlive = returnData[@"result"][@"keepAlive"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configKeepAlive {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerKeepAlive:[self.keepAlive integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readQos {
    __block BOOL success = NO;
    [MKCKInterface ck_readServerQosWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.qos = [returnData[@"result"][@"qos"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configQos {
    __block BOOL success = NO;
    [MKCKInterface ck_configServerQos:self.qos sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

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

- (BOOL)configSubscribe {
    __block BOOL success = NO;
    [MKCKInterface ck_configSubscibeTopic:self.subscribeTopic sucBlock:^{
        success = YES;
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

- (BOOL)configPublish {
    __block BOOL success = NO;
    [MKCKInterface ck_configPublishTopic:self.publishTopic sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSSLStatus {
    __block BOOL success = NO;
    [MKCKInterface ck_readConnectModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger value = [returnData[@"result"][@"mode"] integerValue];
        self.sslIsOn = YES;
        if (value == 0) {
            //TCP
            self.sslIsOn = NO;
        }else if (value == 1) {
            self.certificate = 0;
        }else if (value == 2) {
            self.certificate = 1;
        }else if (value == 3) {
            self.certificate = 2;
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSSLStatus {
    __block BOOL success = NO;
    mk_ck_connectMode mode = mk_ck_connectMode_TCP;
    if (self.sslIsOn) {
        if (self.certificate == 0) {
            mode = mk_ck_connectMode_CASignedServerCertificate;
        }else if (self.certificate == 1) {
            mode = mk_ck_connectMode_CACertificate;
        }else if (self.certificate == 2) {
            mode = mk_ck_connectMode_SelfSignedCertificates;
        }
    }
    [MKCKInterface ck_configConnectMode:mode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCAFile {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.caFileName];
    NSData *caData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(caData)) {
        return NO;
    }
    [MKCKInterface ck_configCAFile:caData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientKey {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.clientKeyName];
    NSData *clientKeyData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(clientKeyData)) {
        return NO;
    }
    [MKCKInterface ck_configClientPrivateKey:clientKeyData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configClientCert {
    __block BOOL success = NO;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [document stringByAppendingPathComponent:self.clientCertName];
    NSData *clientCertData = [NSData dataWithContentsOfFile:filePath];
    if (!ValidData(clientCertData)) {
        return NO;
    }
    [MKCKInterface ck_configClientCert:clientCertData sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)restart {
    __block BOOL success = NO;
    [MKCKInterface ck_restartDeviceWithSucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"serverParams"
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
        _configQueue = dispatch_queue_create("serverSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _configQueue;
}

@end
