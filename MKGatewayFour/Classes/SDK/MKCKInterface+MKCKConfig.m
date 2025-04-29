//
//  MKCKInterface+MKCKConfig.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKInterface+MKCKConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseCentralManager.h"

#import "MKCKCentralManager.h"
#import "MKCKOperationID.h"
#import "MKCKOperation.h"
#import "CBPeripheral+MKCKAdd.h"
#import "MKCKSDKDataAdopter.h"

#define centralManager [MKCKCentralManager shared]

static NSInteger const maxDataLen = 150;

@implementation MKCKInterface (MKCKConfig)

#pragma mark ****************************************System************************************************

+ (void)ck_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed010100";
    [self configDataWithTaskID:mk_ck_taskRestartDeviceOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed010200";
    [self configDataWithTaskID:mk_ck_taskPowerOffOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed010b00";
    [self configDataWithTaskID:mk_ck_taskFactoryResetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configIndicatorStatus:(id <mk_ck_indicatorStatusProtocol>)protocol
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.gps ? @"1" : @"0"),(protocol.network ? @"1" : @"0"),(protocol.powerOff ? @"1" : @"0"),(protocol.power ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed010c01",value];
    [self configDataWithTaskID:mk_ck_taskConfigIndicatorStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNtpServerStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed010d0101" : @"ed010d0100");
    [self configDataWithTaskID:mk_ck_taskConfigNtpServerStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNtpSyncInterval:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 720) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed010e02" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigNtpSyncIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNTPServerHost:(NSString *)host
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (host.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [MKCKSDKDataAdopter fetchAsciiCode:host];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010f",lenString,tempString];
    
    [self configDataWithTaskID:mk_ck_taskConfigNTPServerHostOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *zoneString = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:timeZone];
    NSString *commandString = [@"ed011001" stringByAppendingString:zoneString];
    [self configDataWithTaskID:mk_ck_taskConfigTimeZoneOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configHeartbeatReportInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 86400 || (interval > 0 && interval < 30)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed011104" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigHeartbeatReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configHeartbeatReportItems:(id <mk_ck_heartbeatReportItemsProtocol>)protocol
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.sequence ? @"1" : @"0"),(protocol.vehicle ? @"1" : @"0"),(protocol.accelerometer ? @"1" : @"0"),(protocol.battery ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed011201",value];
    [self configDataWithTaskID:mk_ck_taskConfigHeartbeatReportItemsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPowerLossNotification:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01130101" : @"ed01130100");
    [self configDataWithTaskID:mk_ck_taskConfigPowerLossNotificationOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(password) || password.length < 6 || password.length > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < password.length; i ++) {
        int asciiCode = [password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:password.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0114",len,commandData];
    [self configDataWithTaskID:mk_ck_taskConfigPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (need ? @"ed01150101" : @"ed01150100");
    [self configDataWithTaskID:mk_ck_taskConfigNeedPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configLowPowerNotification:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01160101" : @"ed01160100");
    [self configDataWithTaskID:mk_ck_taskConfigLowPowerNotificationOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configLowPowerThreshold:(mk_ck_lowPowerPrompt)threshold
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *commandString = [@"ed011701" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigLowPowerThresholdOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_deleteBufferDataWithSucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed011800";
    [self configDataWithTaskID:mk_ck_taskDeleteBufferDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPowerOnWhenChargingStatus:(mk_ck_powerOnByChargingType)type
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:type byteLen:1];
    NSString *commandString = [@"ed011901" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigPowerOnWhenChargingStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPowerOnByMagnet:(mk_ck_powerOnByMagnetType)type
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:type byteLen:1];
    NSString *commandString = [@"ed011a01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigPowerOnByMagnetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************MQTT Params************************

+ (void)ck_configServerHost:(NSString *)host
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(host) || host.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [MKCKSDKDataAdopter fetchAsciiCode:host];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0120",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigServerHostOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configServerPort:(NSInteger)port
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (port < 0 || port > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:port byteLen:2];
    NSString *commandString = [@"ed012102" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigServerPortOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configClientID:(NSString *)clientID
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(clientID) || clientID.length > 64) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [MKCKSDKDataAdopter fetchAsciiCode:clientID];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:clientID.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0122",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigClientIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configServerUserName:(NSString *)userName
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (userName.length > 256) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!MKValidStr(userName)) {
        //空的
        NSString *commandString = @"ee0123010000";
        [self configDataWithTaskID:mk_ck_taskConfigServerUserNameOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSInteger totalNum = userName.length / maxDataLen;
    NSInteger packRemain = userName.length % maxDataLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *totalNumHex = [MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1];
    NSString *commandHeader = @"ee0123";
    dispatch_queue_t queue = dispatch_queue_create("configUserNameQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *packIndex = [MKBLEBaseSDKAdopter fetchHexValue:i byteLen:1];
            NSInteger len = maxDataLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *asciiChar = [MKCKSDKDataAdopter fetchAsciiCode:[userName substringWithRange:NSMakeRange(i * maxDataLen, len)]];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,totalNumHex,packIndex,lenString,asciiChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ck_taskConfigServerUserNameOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ck_configServerPassword:(NSString *)password
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (password.length > 256) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!MKValidStr(password)) {
        //空的
        NSString *commandString = @"ee0124010000";
        [self configDataWithTaskID:mk_ck_taskConfigServerPasswordOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSInteger totalNum = password.length / maxDataLen;
    NSInteger packRemain = password.length % maxDataLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *totalNumHex = [MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1];
    NSString *commandHeader = @"ee0124";
    dispatch_queue_t queue = dispatch_queue_create("configPasswordQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *packIndex = [MKBLEBaseSDKAdopter fetchHexValue:i byteLen:1];
            NSInteger len = maxDataLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *asciiChar = [MKCKSDKDataAdopter fetchAsciiCode:[password substringWithRange:NSMakeRange(i * maxDataLen, len)]];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",commandHeader,totalNumHex,packIndex,lenString,asciiChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ck_taskConfigServerPasswordOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ck_configServerCleanSession:(BOOL)clean
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (clean ? @"ed01250101" : @"ed01250100");
    [self configDataWithTaskID:mk_ck_taskConfigServerCleanSessionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configServerKeepAlive:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 120) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed012601" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigServerKeepAliveOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configServerQos:(mk_ck_mqttServerQosMode)mode
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *qosString = [MKCKSDKDataAdopter fetchMqttServerQosMode:mode];
    NSString *commandString = [@"ed012701" stringByAppendingString:qosString];
    [self configDataWithTaskID:mk_ck_taskConfigServerQosOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configSubscibeTopic:(NSString *)subscibeTopic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(subscibeTopic) || subscibeTopic.length > 128) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [MKCKSDKDataAdopter fetchAsciiCode:subscibeTopic];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:subscibeTopic.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0128",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigSubscibeTopicOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPublishTopic:(NSString *)publishTopic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(publishTopic) || publishTopic.length > 128) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = [MKCKSDKDataAdopter fetchAsciiCode:publishTopic];
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:publishTopic.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0129",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigPublishTopicOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configConnectMode:(mk_ck_connectMode)mode
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *modeString = [MKCKSDKDataAdopter fetchConnectModeString:mode];
    NSString *commandString = [@"ed012a01" stringByAppendingString:modeString];
    [self configDataWithTaskID:mk_ck_taskConfigConnectModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configCAFile:(NSData *)caFile
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(caFile)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *caStrings = [MKBLEBaseSDKAdopter hexStringFromData:caFile];
    NSInteger totalNum = (caStrings.length / 2) / maxDataLen;
    NSInteger packRemain = (caStrings.length / 2) % maxDataLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = [NSString stringWithFormat:@"%@%@",@"ee012b",[MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1]];
    dispatch_queue_t queue = dispatch_queue_create("configCAFileQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *index = [MKBLEBaseSDKAdopter fetchHexValue:i byteLen:1];
            NSInteger len = maxDataLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [caStrings substringWithRange:NSMakeRange(i * 2 * maxDataLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",commandHeader,index,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ck_taskConfigCAFileOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ck_configClientCert:(NSData *)cert
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(cert)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *certStrings = [MKBLEBaseSDKAdopter hexStringFromData:cert];
    NSInteger totalNum = (certStrings.length / 2) / maxDataLen;
    NSInteger packRemain = (certStrings.length / 2) % maxDataLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = [NSString stringWithFormat:@"%@%@",@"ee012c",[MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1]];
    dispatch_queue_t queue = dispatch_queue_create("configCertQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *index = [MKBLEBaseSDKAdopter fetchHexValue:i byteLen:1];
            NSInteger len = maxDataLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [certStrings substringWithRange:NSMakeRange(i * 2 * maxDataLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",commandHeader,index,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ck_taskConfigClientCertOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

+ (void)ck_configClientPrivateKey:(NSData *)privateKey
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidData(privateKey)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *privateKeyStrings = [MKBLEBaseSDKAdopter hexStringFromData:privateKey];
    NSInteger totalNum = (privateKeyStrings.length / 2) / maxDataLen;
    NSInteger packRemain = (privateKeyStrings.length / 2) % maxDataLen;
    if (packRemain > 0) {
        totalNum ++;
    }
    NSString *commandHeader = [NSString stringWithFormat:@"%@%@",@"ee012d",[MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1]];
    dispatch_queue_t queue = dispatch_queue_create("configPrivateKeyQueue", 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < totalNum; i ++) {
            NSString *index = [MKBLEBaseSDKAdopter fetchHexValue:i byteLen:1];
            NSInteger len = maxDataLen;
            if ((i == totalNum - 1) && (packRemain > 0)) {
                //最后一帧
                len = packRemain;
            }
            NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:len byteLen:1];
            NSString *subChar = [privateKeyStrings substringWithRange:NSMakeRange(i * 2 * maxDataLen, 2 * len)];
            NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",commandHeader,index,lenString,subChar];
            BOOL success = [self sendDataToPeripheral:commandString
                                               taskID:mk_ck_taskConfigClientPrivateKeyOperation
                                            semaphore:semaphore];
            if (!success) {
                [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                return;
            }
        }
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark *********************NB参数***************************

+ (void)ck_configNetworkPriority:(NSInteger)priority
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (priority < 0 || priority > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:priority byteLen:1];
    NSString *commandString = [@"ed013001" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigNetworkPriorityOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configApn:(NSString *)apn
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock {
    if (!apn || ![apn isKindOfClass:NSString.class] || apn.length > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *apnString = [MKCKSDKDataAdopter fetchAsciiCode:apn];
    NSString *length = [MKBLEBaseSDKAdopter fetchHexValue:apn.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0131",length,apnString];
    [self configDataWithTaskID:mk_ck_taskConfigApnOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configApnUsername:(NSString *)username
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!username || ![username isKindOfClass:NSString.class] || username.length > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *usernameString = [MKCKSDKDataAdopter fetchAsciiCode:username];
    NSString *length = [MKBLEBaseSDKAdopter fetchHexValue:username.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0132",length,usernameString];
    [self configDataWithTaskID:mk_ck_taskConfigApnUsernameOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configApnPassword:(NSString *)password
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!password || ![password isKindOfClass:NSString.class] || password.length > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *passwordString = [MKCKSDKDataAdopter fetchAsciiCode:password];
    NSString *length = [MKBLEBaseSDKAdopter fetchHexValue:password.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0133",length,passwordString];
    [self configDataWithTaskID:mk_ck_taskConfigApnPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNBConnectTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeout < 30 || timeout > 600) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:timeout byteLen:2];
    NSString *commandString = [@"ed013402" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigNBConnectTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNBPin:(NSString *)pin
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if ((pin.length > 0 && pin.length < 4) || pin.length > 8) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *pinString = [MKCKSDKDataAdopter fetchAsciiCode:pin];
    NSString *length = [MKBLEBaseSDKAdopter fetchHexValue:pin.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0135",length,pinString];
    [self configDataWithTaskID:mk_ck_taskConfigNBPinOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configNBRegion:(id <mk_ck_networkRegionsBandsProtocol>)protocol
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmdString = [MKCKSDKDataAdopter fetchRegionCmdString:protocol];
    if (!MKValidStr(cmdString)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed013601" stringByAppendingString:cmdString];
    [self configDataWithTaskID:mk_ck_taskConfigNBRegionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************扫描上报参数***************************

+ (void)ck_configScanReportMode:(mk_ck_scanReportMode)mode
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:mode byteLen:1];
    NSString *commandString = [@"ed014001" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigScanReportModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configModeAutomaticSwitch:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01410101" : @"ed01410100");
    [self configDataWithTaskID:mk_ck_taskConfigModeAutomaticSwitchOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configRealtimeScanPeriodicReportInterval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed014204" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigRealtimeScanPeriodicReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPeriodicScanImmediateReportDuratin:(NSInteger)duration
                                           interval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 86400 || duration < 3 || duration > 3600) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *durationValue = [MKBLEBaseSDKAdopter fetchHexValue:duration byteLen:2];
    NSString *intervalValue = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed014306",durationValue,intervalValue];
    [self configDataWithTaskID:mk_ck_taskConfigPeriodicScanImmediateReportParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPeriodicScanReportScanDuratin:(NSInteger)scanDuration
                                  scanInterval:(NSInteger)scanInterval
                                reportInterval:(NSInteger)reportInterval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (scanDuration < 3 || scanDuration > 3600 || scanInterval < 10
        || scanInterval > 86400 || reportInterval < 10 || reportInterval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *scanDurationValue = [MKBLEBaseSDKAdopter fetchHexValue:scanDuration byteLen:2];
    NSString *scanIntervalValue = [MKBLEBaseSDKAdopter fetchHexValue:scanInterval byteLen:4];
    NSString *reportIntervalValue = [MKBLEBaseSDKAdopter fetchHexValue:reportInterval byteLen:4];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed01440a",scanDurationValue,scanIntervalValue,reportIntervalValue];
    [self configDataWithTaskID:mk_ck_taskConfigPeriodicScanReportScanParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configScanReportUploadPriority:(mk_ck_scanReportUploadPriority)priority
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:priority byteLen:1];
    NSString *commandString = [@"ed014501" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigScanReportUploadPriorityOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configDataRetentionPrority:(mk_ck_dataRetentionPrority)priority
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:priority byteLen:1];
    NSString *commandString = [@"ed014601" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigDataRetentionProrityOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************蓝牙扫描过滤参数***************************
+ (void)ck_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (rssi < -127 || rssi > 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *rssiValue = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:rssi];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed015001",rssiValue];
    [self configDataWithTaskID:mk_ck_taskConfigRssiFilterValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configScanningPHYType:(mk_ck_PHYMode)mode
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKBLEBaseSDKAdopter fetchHexValue:mode byteLen:1];
    NSString *commandString = [@"ed015101" stringByAppendingString:type];
    [self configDataWithTaskID:mk_ck_taskConfigScanningPHYTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterRelationship:(mk_ck_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:relationship byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed015201",value];
    [self configDataWithTaskID:mk_ck_taskConfigFilterRelationshipOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByMacPreciseMatch:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01530101" : @"ed01530100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByMacPreciseMatchOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByMacReverseFilter:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01540101" : @"ed01540100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByMacReverseFilterOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (macList.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *macString = @"";
    if (MKValidArray(macList)) {
        for (NSString *mac in macList) {
            if ((mac.length % 2 != 0) || !MKValidStr(mac) || mac.length > 12 || ![MKBLEBaseSDKAdopter checkHexCharacter:mac]) {
                [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
                return;
            }
            NSString *tempLen = [MKBLEBaseSDKAdopter fetchHexValue:(mac.length / 2) byteLen:1];
            NSString *string = [tempLen stringByAppendingString:mac];
            macString = [macString stringByAppendingString:string];
        }
    }
    NSString *dataLen = [MKBLEBaseSDKAdopter fetchHexValue:(macString.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0155%@%@",dataLen,macString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterMACAddressListOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByAdvNamePreciseMatch:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01560101" : @"ed01560100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByAdvNamePreciseMatchOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByAdvNameReverseFilter:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01570101" : @"ed01570100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByAdvNameReverseFilterOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (nameList.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!MKValidArray(nameList)) {
        //无列表
        NSString *commandString = @"ee0158010000";
        [self configDataWithTaskID:mk_ck_taskConfigFilterAdvNameListOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSString *nameString = @"";
    if (MKValidArray(nameList)) {
        for (NSString *name in nameList) {
            if (!MKValidStr(name) || name.length > 20 || ![MKBLEBaseSDKAdopter asciiString:name]) {
                [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
                return;
            }
            NSString *nameAscii = @"";
            for (NSInteger i = 0; i < name.length; i ++) {
                int asciiCode = [name characterAtIndex:i];
                nameAscii = [nameAscii stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
            }
            NSString *tempLen = [MKBLEBaseSDKAdopter fetchHexValue:(nameAscii.length / 2) byteLen:1];
            NSString *string = [tempLen stringByAppendingString:nameAscii];
            nameString = [nameString stringByAppendingString:string];
        }
    }
    NSInteger totalLen = nameString.length / 2;
    NSInteger totalNum = (totalLen / maxDataLen);
    if (totalLen % maxDataLen != 0) {
        totalNum ++;
    }
    NSMutableArray *commandList = [NSMutableArray array];
    for (NSInteger i = 0; i < totalNum; i ++) {
        NSString *tempString = @"";
        if (i == totalNum - 1) {
            //最后一帧
            tempString = [nameString substringFromIndex:(i * 2 * maxDataLen)];
        }else {
            tempString = [nameString substringWithRange:NSMakeRange(i * 2 * maxDataLen, 2 * maxDataLen)];
        }
        [commandList addObject:tempString];
    }
    NSString *totalNumberHex = [MKBLEBaseSDKAdopter fetchHexValue:totalNum byteLen:1];
    
    __block NSInteger commandIndex = 0;
    dispatch_queue_t dataQueue = dispatch_queue_create("filterNameListQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dataQueue);
    //当2s内没有接收到新的数据的时候，也认为是接受超时
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 0.05 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (commandIndex >= commandList.count) {
            //停止
            dispatch_cancel(timer);
            MKCKOperation *operation = [[MKCKOperation alloc] initOperationWithID:mk_ck_taskConfigFilterAdvNameListOperation commandBlock:^{
                
            } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
                BOOL success = [returnData[@"success"] boolValue];
                if (!success) {
                    [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
                    return ;
                }
                if (sucBlock) {
                    sucBlock();
                }
            }];
            [[MKCKCentralManager shared] addOperation:operation];
            return;
        }
        NSString *tempCommandString = commandList[commandIndex];
        NSString *indexHex = [MKBLEBaseSDKAdopter fetchHexValue:commandIndex byteLen:1];
        NSString *totalLenHex = [MKBLEBaseSDKAdopter fetchHexValue:(tempCommandString.length / 2) byteLen:1];
        NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ee0158",totalNumberHex,indexHex,totalLenHex,tempCommandString];
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandString characteristic:[MKBLEBaseCentralManager shared].peripheral.ck_custom type:CBCharacteristicWriteWithResponse];
        commandIndex ++;
    });
    dispatch_resume(timer);
}

+ (void)ck_configFilterByBeaconStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed015a0101" : @"ed015a0100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBeaconStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBeaconMajor:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (minValue < 0 || minValue > 65535 || maxValue < minValue || maxValue > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [MKBLEBaseSDKAdopter fetchHexValue:minValue byteLen:2];
    NSString *maxString = [MKBLEBaseSDKAdopter fetchHexValue:maxValue byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed015b04",minString,maxString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBeaconMajorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBeaconMinor:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (minValue < 0 || minValue > 65535 || maxValue < minValue || maxValue > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [MKBLEBaseSDKAdopter fetchHexValue:minValue byteLen:2];
    NSString *maxString = [MKBLEBaseSDKAdopter fetchHexValue:maxValue byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed015c04",minString,maxString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBeaconMinorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBeaconUUID:(NSString *)uuid
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (uuid.length > 32) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!uuid) {
        uuid = @"";
    }
    if (MKValidStr(uuid)) {
        if (![MKBLEBaseSDKAdopter checkHexCharacter:uuid] || uuid.length % 2 != 0) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(uuid.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed015d",lenString,uuid];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBeaconUUIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByUIDStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed015e0101" : @"ed015e0100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByUIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByUIDNamespaceID:(NSString *)namespaceID
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    if (namespaceID.length > 20) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!namespaceID) {
        namespaceID = @"";
    }
    if (MKValidStr(namespaceID)) {
        if (![MKBLEBaseSDKAdopter checkHexCharacter:namespaceID] || namespaceID.length % 2 != 0) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(namespaceID.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed015f",lenString,namespaceID];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByUIDNamespaceIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByUIDInstanceID:(NSString *)instanceID
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (instanceID.length > 12) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (!instanceID) {
        instanceID = @"";
    }
    if (MKValidStr(instanceID)) {
        if (![MKBLEBaseSDKAdopter checkHexCharacter:instanceID] || instanceID.length % 2 != 0) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(instanceID.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0160",lenString,instanceID];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByUIDInstanceIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByURLStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01610101" : @"ed01610100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByURLStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByURLContent:(NSString *)content
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (content.length > 100 || ![MKBLEBaseSDKAdopter asciiString:content]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    if (content.length == 0) {
        NSString *commandString = @"ed016200";
        [self configDataWithTaskID:mk_ck_taskConfigFilterByURLContentOperation
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < content.length; i ++) {
        int asciiCode = [content characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:content.length byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0162",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByURLContentOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByTLMStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01630101" : @"ed01630100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByTLMStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByTLMVersion:(mk_ck_filterByTLMVersion)version
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *versionString = [MKBLEBaseSDKAdopter fetchHexValue:version byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed016401",versionString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByTLMVersionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBXPDeviceInfoStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01650101" : @"ed01650100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBXPDeviceInfoStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPAccFilterStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01660101" : @"ed01660100");
    [self configDataWithTaskID:mk_ck_taskConfigBXPAccFilterStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPTHFilterStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01670101" : @"ed01670100");
    [self configDataWithTaskID:mk_ck_taskConfigBXPTHFilterStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBXPButtonStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01680101" : @"ed01680100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBXPButtonStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBXPButtonAlarmStatus:(BOOL)singlePress
                                  doublePress:(BOOL)doublePress
                                    longPress:(BOOL)longPress
                           abnormalInactivity:(BOOL)abnormalInactivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(abnormalInactivity ? @"1" : @"0"),(longPress ? @"1" : @"0"),(doublePress ? @"1" : @"0"),(singlePress ? @"1" : @"0")];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed016901",[MKBLEBaseSDKAdopter getHexByBinary:binary]];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBXPButtonAlarmStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBXPTagIDStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed016a0101" : @"ed016a0100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBXPTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPreciseMatchTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed016b0101" : @"ed016b0100");
    [self configDataWithTaskID:mk_ck_taskConfigPreciseMatchTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configReverseFilterTagIDStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed016c0101" : @"ed016c0100");
    [self configDataWithTaskID:mk_ck_taskConfigReverseFilterTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterBXPTagIDList:(NSArray <NSString *>*)tagIDList
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (tagIDList.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tagIDString = @"";
    if (MKValidArray(tagIDList)) {
        for (NSString *tagID in tagIDList) {
            if ((tagID.length % 2 != 0) || !MKValidStr(tagID) || tagID.length > 12 || ![MKBLEBaseSDKAdopter checkHexCharacter:tagID]) {
                [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
                return;
            }
            NSString *tempLen = [MKBLEBaseSDKAdopter fetchHexValue:(tagID.length / 2) byteLen:1];
            NSString *string = [tempLen stringByAppendingString:tagID];
            tagIDString = [tagIDString stringByAppendingString:string];
        }
    }
    NSString *dataLen = [MKBLEBaseSDKAdopter fetchHexValue:(tagIDString.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed016d%@%@",dataLen,tagIDString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterBXPTagIDListOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed016e0101" : @"ed016e0100");
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterDelayResponseStatus:(mk_ck_pirFilterDelayResponseStatus)status
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:status byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed016f01",value];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterDelayResponseStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterDoorStatus:(mk_ck_pirFilterDoorStatus)status
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:status byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed017001",value];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterDoorStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterSensorSensitivity:(mk_ck_pirFilterSensorSensitivity)sensitivity
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:sensitivity byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed017101",value];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterSensorSensitivityOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}


+ (void)ck_configPirFilterDetectionStatus:(mk_ck_pirFilterDetectionStatus)status
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:status byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed017201",value];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterDetectionStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterByMajorRange:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (minValue < 0 || minValue > 65535 || maxValue < 0 || maxValue > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *min = [MKBLEBaseSDKAdopter fetchHexValue:minValue byteLen:2];
    NSString *max = [MKBLEBaseSDKAdopter fetchHexValue:maxValue byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed017304",min,max];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterByMajorRangeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPirFilterByMinorRange:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (minValue < 0 || minValue > 65535 || maxValue < 0 || maxValue > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *min = [MKBLEBaseSDKAdopter fetchHexValue:minValue byteLen:2];
    NSString *max = [MKBLEBaseSDKAdopter fetchHexValue:maxValue byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed017404",min,max];
    [self configDataWithTaskID:mk_ck_taskConfigPirFilterByMinorRangeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByTofStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01750101" : @"ed01750100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByTofStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)  ck_configFilterTofCodeList:(NSArray <NSString *>*)codeList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (codeList.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *codeString = @"";
    if (MKValidArray(codeList)) {
        for (NSString *code in codeList) {
            if (!MKValidStr(code) || code.length != 4 || ![MKBLEBaseSDKAdopter checkHexCharacter:code]) {
                [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
                return;
            }
            codeString = [codeString stringByAppendingString:code];
        }
    }
    NSString *dataLen = [MKBLEBaseSDKAdopter fetchHexValue:(codeString.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0176%@%@",dataLen,codeString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterTofCodeListOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByOtherStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01770101" : @"ed01770100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByOtherStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByOtherRelationship:(mk_ck_filterByOther)relationship
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKCKSDKDataAdopter parseOtherRelationshipToCmd:relationship];
    NSString *commandString = [@"ed017801" stringByAppendingString:type];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByOtherRelationshipOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByOtherConditions:(NSArray <mk_ck_BLEFilterRawDataProtocol>*)conditions
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!conditions || ![conditions isKindOfClass:NSArray.class] || conditions.count > 3) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *dataContent = @"";
    for (id <mk_ck_BLEFilterRawDataProtocol>protocol in conditions) {
        if (![MKCKSDKDataAdopter isConfirmRawFilterProtocol:protocol]) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
        NSString *start = [MKBLEBaseSDKAdopter fetchHexValue:protocol.minIndex byteLen:1];
        NSString *end = [MKBLEBaseSDKAdopter fetchHexValue:protocol.maxIndex byteLen:1];
        NSString *content = [NSString stringWithFormat:@"%@%@%@%@",protocol.dataType,start,end,protocol.rawData];
        NSString *tempLenString = [MKBLEBaseSDKAdopter fetchHexValue:(content.length / 2) byteLen:1];
        dataContent = [dataContent stringByAppendingString:[tempLenString stringByAppendingString:content]];
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(dataContent.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed0179",lenString,dataContent];
    [self configDataWithTaskID:mk_ck_taskConfigFilterByOtherConditionsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configDuplicateDataFilter:(mk_ck_duplicateDataFilter)type
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:type byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed017a01",value];
    [self configDataWithTaskID:mk_ck_taskConfigDuplicateDataFilterOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterByBXPSTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed017b0101" : @"ed017b0100");
    [self configDataWithTaskID:mk_ck_taskConfigFilterByBXPSTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPreciseMatchBXPSTagIDStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed017c0101" : @"ed017c0100");
    [self configDataWithTaskID:mk_ck_taskConfigPreciseMatchBXPSTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configReverseFilterBXPSTagIDStatus:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed017d0101" : @"ed017d0100");
    [self configDataWithTaskID:mk_ck_taskConfigReverseFilterBXPSTagIDStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFilterBXPSTagIDList:(NSArray <NSString *>*)tagIDList
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (tagIDList.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tagIDString = @"";
    if (MKValidArray(tagIDList)) {
        for (NSString *tagID in tagIDList) {
            if ((tagID.length % 2 != 0) || !MKValidStr(tagID) || tagID.length > 12 || ![MKBLEBaseSDKAdopter checkHexCharacter:tagID]) {
                [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
                return;
            }
            NSString *tempLen = [MKBLEBaseSDKAdopter fetchHexValue:(tagID.length / 2) byteLen:1];
            NSString *string = [tempLen stringByAppendingString:tagID];
            tagIDString = [tagIDString stringByAppendingString:string];
        }
    }
    NSString *dataLen = [MKBLEBaseSDKAdopter fetchHexValue:(tagIDString.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed017e%@%@",dataLen,tagIDString];
    [self configDataWithTaskID:mk_ck_taskConfigFilterBXPSTagIDListOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************蓝牙广播参数************************
+ (void)ck_configAdvertiseResponsePacketStatus:(BOOL)isOn
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01800101" : @"ed01800100");
    [self configDataWithTaskID:mk_ck_taskConfigAdvertiseResponsePacketStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configAdvertiseName:(NSString *)deviceName
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceName) || deviceName.length > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < deviceName.length; i ++) {
        int asciiCode = [deviceName characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)deviceName.length];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
    NSString *commandString = [NSString stringWithFormat:@"ed0181%@%@",lenString,tempString];
    [self configDataWithTaskID:mk_ck_taskConfigDeviceNameOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBeaconMajor:(NSInteger)major
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (major < 0 || major > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:major byteLen:2];
    NSString *commandString = [@"ed018202" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigBeaconMajorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBeaconMinor:(NSInteger)minor
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (minor < 0 || minor > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:minor byteLen:2];
    NSString *commandString = [@"ed018302" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigBeaconMinorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBeaconUUID:(NSString *)uuid
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(uuid) || uuid.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:uuid]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed018410" stringByAppendingString:uuid];
    [self configDataWithTaskID:mk_ck_taskConfigBeaconUUIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBeaconRssi:(NSInteger)rssi
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (rssi < -100 || rssi > 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *rssiValue = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:rssi];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed018501",rssiValue];
    [self configDataWithTaskID:mk_ck_taskConfigBeaconRssiOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed018601" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigAdvIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configTxPower:(mk_ck_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKCKSDKDataAdopter fetchTxPower:txPower];
    NSString *commandString = [@"ed018701" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigTxPowerOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configAdvTimeout:(NSInteger)timeout
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeout < 0 || timeout > 60) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:timeout byteLen:1];
    NSString *commandString = [@"ed018801" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigAdvTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************定位参数************************

+ (void)ck_configFixModeSelection:(mk_ck_positionFixMode)mode
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:mode byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed019001",value];
    [self configDataWithTaskID:mk_ck_taskConfigFixModeSelectionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPeriodicFixInterval:(NSInteger)interval
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed019104" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigPeriodicFixIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configAxisWakeupParams:(NSInteger)threshold
                         duration:(NSInteger)duration
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 1 || threshold > 20 || duration < 1 || duration > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *thresholdHex = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *durationHex = [MKBLEBaseSDKAdopter fetchHexValue:duration byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed019202",thresholdHex,durationHex];
    [self configDataWithTaskID:mk_ck_taskConfigAxisWakeupParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configAxisMotionParams:(NSInteger)threshold
                         duration:(NSInteger)duration
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 10 || threshold > 250 || duration < 1 || duration > 15) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *thresholdHex = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *durationHex = [MKBLEBaseSDKAdopter fetchHexValue:duration byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed019302",thresholdHex,durationHex];
    [self configDataWithTaskID:mk_ck_taskConfigAxisMotionParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixWhenStartsStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01940101" : @"ed01940100");
    [self configDataWithTaskID:mk_ck_taskConfigFixWhenStartsStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixInTripStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01950101" : @"ed01950100");
    [self configDataWithTaskID:mk_ck_taskConfigFixInTripStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixInTripReportInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed019604" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigFixInTripReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixWhenStopsTimeout:(NSInteger)timeout
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeout < 3 || timeout > 180) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:timeout byteLen:1];
    NSString *commandString = [@"ed019701" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigFixWhenStopsTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixWhenStopsStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01980101" : @"ed01980100");
    [self configDataWithTaskID:mk_ck_taskConfigFixWhenStopsStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixInStationaryStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01990101" : @"ed01990100");
    [self configDataWithTaskID:mk_ck_taskConfigFixInStationaryStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configFixInStationaryReportInterval:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 1440) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed019a02" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigFixInStationaryReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configGpsFixTimeout:(NSInteger)timeout
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeout < 60 || timeout > 600) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:timeout byteLen:2];
    NSString *commandString = [@"ed019b02" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigGpsFixTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configGpsPDOPLimit:(NSInteger)pdop
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (pdop < 25 || pdop > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:pdop byteLen:1];
    NSString *commandString = [@"ed019c01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_ck_taskConfigGpsPDOPLimitOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configPositionUploadPayload:(BOOL)hdop
                              sequence:(BOOL)sequence
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@",@"000000",(sequence ? @"1" : @"0"),(hdop ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed019d01",value];
    [self configDataWithTaskID:mk_ck_taskConfigPositionUploadPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark *********************蓝牙数据上报************************

+ (void)ck_configBeaconPayload:(id <mk_ck_beaconPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.rssi1m ? @"1" : @"0"),(protocol.minor ? @"1" : @"0"),(protocol.major ? @"1" : @"0"),(protocol.uuid ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01a001",value];
    [self configDataWithTaskID:mk_ck_taskConfigBeaconPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configUIDPayload:(id <mk_ck_uidPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"0",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.instanceID ? @"1" : @"0"),(protocol.namespaceID ? @"1" : @"0"),(protocol.rssi0m ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01a101",value];
    [self configDataWithTaskID:mk_ck_taskConfigUIDPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configUrlPayload:(id <mk_ck_urlPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"0",@"0",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.url ? @"1" : @"0"),(protocol.rssi0m ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01a201",value];
    [self configDataWithTaskID:mk_ck_taskConfigUrlPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configTLMPayload:(id <mk_ck_tlmPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.advertising ? @"1" : @"0"),(protocol.secCount ? @"1" : @"0"),(protocol.advCount ? @"1" : @"0"),(protocol.temperature ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.tlmVersion ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@",@"0000000",(protocol.response ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a302",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigTlmPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPDeviceInfoPayload:(id <mk_ck_bxpDeviceInfoPayloadProtocol>)protocol
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.switchStatusIndicator ? @"1" : @"0"),(protocol.devicePropertyIndicator ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0"),(protocol.firmwareVersion ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a402",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPDeviceInfoPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPACCPayload:(id <mk_ck_bxpACCPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.motionThreshold ? @"1" : @"0"),(protocol.fullScale ? @"1" : @"0"),(protocol.sampleRate ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@%@%@",@"00000",(protocol.advertising ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a502",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPACCPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPTHPayload:(id <mk_ck_bxpTHPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.voltage ? @"1" : @"0"),(protocol.humidity ? @"1" : @"0"),(protocol.temperature ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@",@"0000000",(protocol.advertising ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a602",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPTHPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPButtonPayload:(id <mk_ck_bxpButtonPayloadProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.deviceName ? @"1" : @"0"),(protocol.firmwareType ? @"1" : @"0"),(protocol.deviceId ? @"1" : @"0"),(protocol.triggerCount ? @"1" : @"0"),(protocol.statusFlag ? @"1" : @"0"),(protocol.frameType ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *centerBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.advertising ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.temperature ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionThreshold ? @"1" : @"0"),(protocol.fullScale ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@",@"0000000",(protocol.response ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *centerValue = [MKBLEBaseSDKAdopter getHexByBinary:centerBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed01a70400",highValue,centerValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPButtonPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPTagPayload:(id <mk_ck_bxpTagPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.tagID ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionTriggerEventCount ? @"1" : @"0"),(protocol.hallTriggerEventCount ? @"1" : @"0"),(protocol.sensorStatus ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@%@%@",@"00000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a802",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPTagPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPPIRPayload:(id <mk_ck_bxpPIRPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.major ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.sensorDetectionStatus ? @"1" : @"0"),(protocol.sensorSensitivity ? @"1" : @"0"),(protocol.doorStatus ? @"1" : @"0"),(protocol.delayResponseStatus ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"00",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.advName ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.rssi1m ? @"1" : @"0"),(protocol.minor ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01a902",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPPIRPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configMKTofPayload:(id <mk_ck_mkTofPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.rangingDistance ? @"1" : @"0"),(protocol.userData ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.manufacturer ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01aa01",value];
    [self configDataWithTaskID:mk_ck_taskConfigMKTofPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configOtherPayload:(id <mk_ck_otherPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01ab01",value];
    [self configDataWithTaskID:mk_ck_taskConfigOtherPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configOtherBlockPayload:(NSArray <id <mk_ck_otherBlockPayloadProtocol>> *)list
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (!list || ![list isKindOfClass:NSArray.class] || list.count > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *dataContent = @"";
    for (id <mk_ck_otherBlockPayloadProtocol>protocol in list) {
        if (![MKCKSDKDataAdopter isConfirmOtherBlockPayloadProtocol:protocol]) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
        NSString *start = [MKBLEBaseSDKAdopter fetchHexValue:protocol.start byteLen:1];
        NSString *end = [MKBLEBaseSDKAdopter fetchHexValue:protocol.end byteLen:1];
        NSString *content = [NSString stringWithFormat:@"%@%@%@",protocol.dataType,start,end];
        dataContent = [dataContent stringByAppendingString:content];
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(dataContent.length / 2) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01ac",lenString,dataContent];
    [self configDataWithTaskID:mk_ck_taskConfigOtherBlockPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configCommonPayload:(BOOL)beacon
                      sequence:(BOOL)sequence
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *binary = [NSString stringWithFormat:@"%@%@%@",@"000000",(sequence ? @"1" : @"0"),(beacon ? @"1" : @"0")];
    NSString *value = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed01ad01",value];
    [self configDataWithTaskID:mk_ck_taskConfigCommonPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)ck_configBXPSPayload:(id <mk_ck_bxpBXPSPayloadProtocol>)protocol
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.tagID ? @"1" : @"0"),(protocol.voltage ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionTriggerEventCount ? @"1" : @"0"),(protocol.hallTriggerEventCount ? @"1" : @"0"),(protocol.sensorStatus ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0")];
    NSString *highBinary = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.TH ? @"1" : @"0"),(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0")];
    NSString *lowValue = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    NSString *highValue = [MKBLEBaseSDKAdopter getHexByBinary:highBinary];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed01ae02",highValue,lowValue];
    [self configDataWithTaskID:mk_ck_taskConfigBXPSPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)configDataWithTaskID:(mk_ck_taskOperationID)taskID
                        data:(NSString *)data
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.ck_custom commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

+ (BOOL)sendDataToPeripheral:(NSString *)commandString
                      taskID:(mk_ck_taskOperationID)taskID
                   semaphore:(dispatch_semaphore_t)semaphore {
    __block BOOL success = NO;
    [self configDataWithTaskID:taskID data:commandString sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(semaphore);
    } failedBlock:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

@end
