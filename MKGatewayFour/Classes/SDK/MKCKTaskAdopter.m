//
//  MKCKTaskAdopter.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKCKOperationID.h"
#import "MKCKSDKDataAdopter.h"

NSString *const mk_ck_totalNumKey = @"mk_ck_totalNumKey";
NSString *const mk_ck_totalIndexKey = @"mk_ck_totalIndexKey";
NSString *const mk_ck_contentKey = @"mk_ck_contentKey";

@implementation MKCKTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_ck_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_ck_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_ck_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_ck_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_ck_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_ck_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(6, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(10, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_ck_taskOperationID operationID = mk_ck_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(6, len)];
        NSDictionary *resultDic= @{
            mk_ck_totalNumKey:totalNum,
            mk_ck_totalIndexKey:index,
            mk_ck_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"23"]) {
            //读取服务器登录名字
            operationID = mk_ck_taskReadServerUserNameOperation;
        }else if ([cmd isEqualToString:@"24"]) {
            //读取服务器登录密码
            operationID = mk_ck_taskReadServerPasswordOperation;
        }else if ([cmd isEqualToString:@"58"]) {
            //读取Adv Name过滤规则
            operationID = mk_ck_taskReadFilterAdvNameListOperation;
        }
        
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_ck_taskOperationID operationID = mk_ck_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"23"]) {
            //配置MQTT服务器用户名
            operationID = mk_ck_taskConfigServerUserNameOperation;
        }else if ([cmd isEqualToString:@"24"]) {
            //配置MQTT服务器密码
            operationID = mk_ck_taskConfigServerPasswordOperation;
        }else if ([cmd isEqualToString:@"2b"]) {
            //配置根证书
            operationID = mk_ck_taskConfigCAFileOperation;
        }else if ([cmd isEqualToString:@"2c"]) {
            //配置客户端证书
            operationID = mk_ck_taskConfigClientCertOperation;
        }else if ([cmd isEqualToString:@"2d"]) {
            //配置客户端秘钥
            operationID = mk_ck_taskConfigClientPrivateKeyOperation;
        }else if ([cmd isEqualToString:@"58"]) {
            //配置客户端秘钥
            operationID = mk_ck_taskConfigFilterAdvNameListOperation;
        }
        
        
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_ck_taskOperationID operationID = mk_ck_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        
    }else if ([cmd isEqualToString:@"06"]) {
        //读取MAC
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_ck_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //读取指示灯状态
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL power = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL powerOff = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL network = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL gps = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"power":@(power),
            @"powerOff":@(powerOff),
            @"network":@(network),
            @"gps":@(gps),
        };
        operationID = mk_ck_taskReadIndicatorStatusOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取NTP服务器开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadNtpServerStatusOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取NTP服务器同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadNtpSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //读取NTP服务器域名
        NSString *host = @"";
        if (data.length > 4) {
            NSData *hostData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            host = [[NSString alloc] initWithData:hostData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"host":(MKValidStr(host) ? host : @""),
        };
        operationID = mk_ck_taskReadNTPServerHostOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_ck_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //读取设备状态上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadHeartbeatReportIntervalOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //读取设备状态数据选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL battery = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL accelerometer = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL vehicle = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL sequence = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"battery":@(battery),
            @"accelerometer":@(accelerometer),
            @"vehicle":@(vehicle),
            @"sequence":@(sequence),
        };
        operationID = mk_ck_taskReadReportItemsOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //读取密码开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadPowerLossNotificationOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_ck_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_ck_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //读取低电报警开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadLowPowerNotificationOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //读取低电量阈值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadLowPowerThresholdOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //读取低电关机充电是否开机
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadPowerOnWhenChargingStatusOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //读取开关机方式
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPowerOnByMagnetTypeOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //读取MQTT服务器域名
        NSString *host = @"";
        if (data.length > 4) {
            NSData *hostData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            host = [[NSString alloc] initWithData:hostData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"host":(MKValidStr(host) ? host : @""),
        };
        operationID = mk_ck_taskReadServerHostOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //读取MQTT服务器端口
        NSString *port = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"port":port};
        operationID = mk_ck_taskReadServerPortOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //读取ClientID
        NSString *clientID = @"";
        if (data.length > 4) {
            NSData *clientIDData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            clientID = [[NSString alloc] initWithData:clientIDData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"clientID":(MKValidStr(clientID) ? clientID : @""),
        };
        operationID = mk_ck_taskReadClientIDOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //读取MQTT Clean Session
        BOOL clean = ([content isEqualToString:@"01"]);
        resultDic = @{@"clean":@(clean)};
        operationID = mk_ck_taskReadServerCleanSessionOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //读取MQTT KeepAlive
        NSString *keepAlive = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"keepAlive":keepAlive};
        operationID = mk_ck_taskReadServerKeepAliveOperation;
    }else if ([cmd isEqualToString:@"27"]) {
        //读取MQTT Qos
        NSString *qos = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"qos":qos};
        operationID = mk_ck_taskReadServerQosOperation;
    }else if ([cmd isEqualToString:@"28"]) {
        //读取Subscribe topic
        NSString *topic = @"";
        if (data.length > 4) {
            NSData *topicData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            topic = [[NSString alloc] initWithData:topicData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"topic":(MKValidStr(topic) ? topic : @""),
        };
        operationID = mk_ck_taskReadSubscibeTopicOperation;
    }else if ([cmd isEqualToString:@"29"]) {
        //读取Publish topic
        NSString *topic = @"";
        if (data.length > 4) {
            NSData *topicData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            topic = [[NSString alloc] initWithData:topicData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"topic":(MKValidStr(topic) ? topic : @""),
        };
        operationID = mk_ck_taskReadPublishTopicOperation;
    }else if ([cmd isEqualToString:@"2a"]) {
        //读取MTQQ服务器通信加密方式
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"mode":mode};
        operationID = mk_ck_taskReadConnectModeOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取网络制式
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadNetworkPriorityOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取APN
        NSString *apn = @"";
        if (data.length > 4) {
            NSData *apnData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            apn = [[NSString alloc] initWithData:apnData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"apn":(MKValidStr(apn) ? apn : @""),
        };
        operationID = mk_ck_taskReadApnOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取APN用户名
        NSString *username = @"";
        if (data.length > 4) {
            NSData *usernameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            username = [[NSString alloc] initWithData:usernameData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"username":(MKValidStr(username) ? username : @""),
        };
        operationID = mk_ck_taskReadApnUsernameOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取APN密码
        NSString *password = @"";
        if (data.length > 4) {
            NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_ck_taskReadApnPasswordOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取NB连接超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadNBConnectTimeoutOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //读取Pin
        NSString *pin = @"";
        if (data.length > 4) {
            NSData *pinData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            pin = [[NSString alloc] initWithData:pinData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"pin":(MKValidStr(pin) ? pin : @""),
        };
        operationID = mk_ck_taskReadNBPinOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //读取Region
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadNBRegionOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取蓝牙扫描上报模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadScanReportModeOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取扫描上报模式自动切换开关
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ck_taskReadModeAutomaticSwitchOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取扫描常开定期上报上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadRealtimeScanPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取定期扫描立即上报参数
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 8)];
        resultDic = @{
            @"duration":duration,
            @"interval":interval,
        };
        operationID = mk_ck_taskReadPeriodicScanImmediateReportParamsOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取定期扫描定期上报参数
        NSString *scanDuration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *scanInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 8)];
        NSString *reportInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(12, 8)];
        resultDic = @{
            @"scanDuration":scanDuration,
            @"scanInterval":scanInterval,
            @"reportInterval":reportInterval,
        };
        operationID = mk_ck_taskReadPeriodicScanReportParamsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取蓝牙数据上发优先级
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadScanReportUploadPriorityOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取蓝牙数据保留策略
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadDataRetentionProrityOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%@",[MKBLEBaseSDKAdopter signedHexTurnString:content]],
        };
        operationID = mk_ck_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取蓝牙扫描phy选择
        NSString *phyType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{@"phyType":phyType};
        operationID = mk_ck_taskReadScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKCKSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_ck_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"59"]) {
        //读取过滤设备类型开关
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL iBeacon = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL uid = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL url = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL tlm = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL bxp_deviceInfo = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL bxp_acc = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL bxp_th = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL bxp_button = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        BOOL bxp_tag = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL pir = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL tof = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL other = ([[highBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL bxps = ([[highBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"pir":@(pir),
            @"bxp_deviceInfo":@(bxp_deviceInfo),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"bxp_button":@(bxp_button),
            @"bxp_tag":@(bxp_tag),
            @"other":@(other),
            @"tof":@(tof),
            @"bxps":@(bxps),
        };
        operationID = mk_ck_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //读取iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ck_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //读取iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ck_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"5d"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_ck_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"5e"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_ck_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_ck_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //读取URL类型过滤内容
        NSString *url = @"";
        if (content.length > 0) {
            NSData *urlData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            url = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"url":(MKValidStr(url) ? url : @""),
        };
        operationID = mk_ck_taskReadFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_ck_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取BXP-Button过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadBXPButtonFilterStatusOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //读取BXP-Button报警过滤开关
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL singlePresse = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL doublePresse = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL longPresse = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL abnormal = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"singlePresse":@(singlePresse),
            @"doublePresse":@(doublePresse),
            @"longPresse":@(longPresse),
            @"abnormal":@(abnormal),
        };
        operationID = mk_ck_taskReadBXPButtonAlarmFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //读取BXP-TagID类型开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //读取BXP-TagID类型精准过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //读取读取BXP-TagID类型反向过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //读取BXP-TagID过滤规则
        NSArray *tagIDList = [MKCKSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_ck_taskReadFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //读取PIR过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadPirFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //读取PIR过滤delay response status
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPirFilterDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //读取PIR过滤door status
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPirFilterDoorStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //读取PIR过滤sensor sensitivity
        resultDic = @{
            @"sensitivity":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPirFilterSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //读取PIR过滤detection status
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPirFilterDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //读取PIR过滤major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ck_taskReadPirFilterByMajorRangeOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //读取PIR过滤minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ck_taskReadPirFilterByMinorRangeOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //读取TOF过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadTofFilterStatusOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //读取TOF过滤MFG_CODE
        NSMutableArray *codeList = [NSMutableArray array];
        NSInteger count = content.length / 4;
        for (NSInteger i = 0; i < count; i ++) {
            NSString *code = [content substringWithRange:NSMakeRange(i * 4, 4)];
            [codeList addObject:code];
        }
        
        resultDic = @{
            @"codeList":codeList
        };
        operationID = mk_ck_taskReadFilterTofListOperation;
    }else if ([cmd isEqualToString:@"77"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"78"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKCKSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_ck_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKCKSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_ck_taskReadFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //读取重复数据过滤规则
        resultDic = @{
            @"filterType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //读取BXP-S过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFilterByBXPSIDStatusOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //读取BXP-S tagID精准过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadPreciseMatchBXPSTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //读取BXP-S tagID反向过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadReverseFilterBXPSTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //读取BXP-S tagID列表
        NSArray *tagIDList = [MKCKSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_ck_taskReadFilterBXPSTagIDListOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //读取回应包开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadAdvertiseResponsePacketStatusOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //读取广播名称
        NSString *advName = @"";
        if (data.length > 4) {
            NSData *advData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            advName = [[NSString alloc] initWithData:advData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"advName":advName,
        };
        operationID = mk_ck_taskReadAdvertiseNameOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //读取Major
        resultDic = @{
            @"major":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //读取Minor
        resultDic = @{
            @"minor":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //读取UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_ck_taskReadBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //读取RSSI@1m
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%@",[MKBLEBaseSDKAdopter signedHexTurnString:content]],
        };
        operationID = mk_ck_taskReadBeaconRssiOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //读取Tx Power
        NSString *txPower = [MKCKSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_ck_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //读取超时广播时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadAdvTimeoutOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //读取定位模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadFixModeSelectionOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //读取定期定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadPeriodicFixIntervalOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //读取三轴唤醒条件
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration
        };
        operationID = mk_ck_taskReadAxisWakeupParamsOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //读取运动检测判断
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration
        };
        operationID = mk_ck_taskReadAxisMotionParamsOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //读取运动开始定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFixWhenStartsStatusOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //读取运动过程中定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFixInTripStatusOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //读取运动过程中定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadFixInTripReportIntervalOperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //读取运动结束定位开关
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadFixWhenStopsTimeoutOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //读取运动结束持续判断时间
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFixWhenStopsStatusOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //读取静止定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ck_taskReadFixInStationaryStatusOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //读取静止定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadFixInStationaryReportIntervalOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //读取GPS定位超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadGpsFixTimeoutOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //读取PDOP
        resultDic = @{
            @"pdop":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadGpsPDOPLimitOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //读取定位数据上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL hdop = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL sequence = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"hdop":@(hdop),
            @"sequence":@(sequence),
        };
        operationID = mk_ck_taskReadPositionUploadPayloadSettingsOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //读取iBeacon上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL rssi = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL uuid = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL major = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL minor = ([[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL rssi1m = ([[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL response = ([[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"uuid":@(uuid),
            @"major":@(major),
            @"minor":@(minor),
            @"rssi1m":@(rssi1m),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadBeaconPayloadOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //读取UID上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL rssi = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL rssi0m = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL namespaceID = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL instanceID = ([[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL response = ([[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"rssi0m":@(rssi0m),
            @"namespaceID":@(namespaceID),
            @"instanceID":@(instanceID),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadUIDPayloadOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //读取Url上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL rssi = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL rssi0m = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL url = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL response = ([[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"rssi0m":@(rssi0m),
            @"url":@(url),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadUrlPayloadOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //读取TLM上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL tlmVersion = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL temperature = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL advCount = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL secCount = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"tlmVersion":@(tlmVersion),
            @"voltage":@(voltage),
            @"temperature":@(temperature),
            @"advCount":@(advCount),
            @"secCount":@(secCount),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadTlmPayloadOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //读取BXP_devinfo上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL txPower = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL rangingData = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL advInterval = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL devicePropertyIndicator = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL switchStatusIndicator = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL firmwareVersion = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL deviceName = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"voltage":@(voltage),
            @"devicePropertyIndicator":@(devicePropertyIndicator),
            @"switchStatusIndicator":@(switchStatusIndicator),
            @"firmwareVersion":@(firmwareVersion),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadBXPDeviceInfoPayloadOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //读取BXP_ACC上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL txPower = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL rangingData = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL advInterval = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL sampleRate = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL fullScale = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL motionThreshold = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL axisData = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"sampleRate":@(sampleRate),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"voltage":@(voltage),
            @"advertising":@(advertising),
        };
        operationID = mk_ck_taskReadBXPACCPayloadOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //读取BXP_TH上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL txPower = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL rangingData = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL advInterval = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL temperature = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL humidity = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"temperature":@(temperature),
            @"humidity":@(humidity),
            @"voltage":@(voltage),
            @"advertising":@(advertising),
        };
        operationID = mk_ck_taskReadBXPTHPayloadOperation;
    }else if ([cmd isEqualToString:@"a7"]) {
        //读取BXP_Button上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        NSString *centerBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(4, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(6, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL frameType = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL statusFlag = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL triggerCount = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL deviceId = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL firmwareType = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL deviceName = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL fullScale = ([[centerBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL motionThreshold = ([[centerBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL axisData = ([[centerBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL temperature = ([[centerBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL rangingData = ([[centerBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[centerBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL txPower = ([[centerBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[centerBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"frameType":@(frameType),
            @"statusFlag":@(statusFlag),
            @"triggerCount":@(triggerCount),
            @"deviceId":@(deviceId),
            @"firmwareType":@(firmwareType),
            @"deviceName":@(deviceName),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"temperature":@(temperature),
            @"rangingData":@(rangingData),
            @"voltage":@(voltage),
            @"txPower":@(txPower),
            @"advertising":@(advertising),
            @"response":@(response),
        };
        operationID = mk_ck_taskReadBXPButtonPayloadOperation;
    }else if ([cmd isEqualToString:@"a8"]) {
        //读取BXP_Tag上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL sensorStatus = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL hallTriggerEventCount = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL motionTriggerEventCount = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL axisData = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL tagID = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL deviceName = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"sensorStatus":@(sensorStatus),
            @"hallTriggerEventCount":@(hallTriggerEventCount),
            @"motionTriggerEventCount":@(motionTriggerEventCount),
            @"axisData":@(axisData),
            @"voltage":@(voltage),
            @"tagID":@(tagID),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
        };
        operationID = mk_ck_taskReadBXPTagPayloadOperation;
    }else if ([cmd isEqualToString:@"a9"]) {
        //读取BXP_Tag上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL delayResponseStatus = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL doorStatus = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL sensorSensitivity = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL sensorDetectionStatus = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL major = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL minor = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL rssi1m = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL txPower = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL advName = ([[highBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"delayResponseStatus":@(delayResponseStatus),
            @"doorStatus":@(doorStatus),
            @"sensorSensitivity":@(sensorSensitivity),
            @"sensorDetectionStatus":@(sensorDetectionStatus),
            @"voltage":@(voltage),
            @"major":@(major),
            @"minor":@(minor),
            @"rssi1m":@(rssi1m),
            @"txPower":@(txPower),
            @"advName":@(advName),
            @"advertising":@(advertising),
            @"response":@(response),
        };
        operationID = mk_ck_taskReadBXPPIRPayloadOperation;
    }else if ([cmd isEqualToString:@"aa"]) {
        //读取MK TOF上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL rssi = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL manufacturer = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL userData = ([[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL rangingDistance = ([[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL response = ([[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"manufacturer":@(manufacturer),
            @"voltage":@(voltage),
            @"userData":@(userData),
            @"rangingDistance":@(rangingDistance),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadMKTofPayloadOperation;
    }else if ([cmd isEqualToString:@"ab"]) {
        //读取Other上报选择
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL rssi = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL response = ([[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"advertising":@(advertising),
            @"response":@(response)
        };
        operationID = mk_ck_taskReadOtherPayloadOperation;
    }else if ([cmd isEqualToString:@"ac"]) {
        //读取Other Block上报选择
        NSMutableArray *list = [NSMutableArray array];
        NSInteger count = content.length / 6;
        for (NSInteger i = 0; i < count; i ++) {
            NSString *tempContent = [content substringWithRange:NSMakeRange(i * 6, 6)];
            NSString *dataType = [tempContent substringWithRange:NSMakeRange(0, 2)];
            NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:tempContent range:NSMakeRange(2, 2)];
            NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:tempContent range:NSMakeRange(4, 2)];
            NSDictionary *dic = @{
                @"dataType":dataType,
                @"start":start,
                @"end":end,
            };
            [list addObject:dic];
        }
        resultDic = @{
            @"list":list
        };
        operationID = mk_ck_taskReadOtherBlockPayloadOperation;
    }else if ([cmd isEqualToString:@"ad"]) {
        //读取扫描上报包参数
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL beacon = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL sequence = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"beacon":@(beacon),
            @"sequence":@(sequence),
        };
        operationID = mk_ck_taskReadCommonPayloadOperation;
    }else if ([cmd isEqualToString:@"ae"]) {
        //读取BXP_S上报选择
        NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        BOOL rssi = ([[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL timestamp = ([[lowBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL sensorStatus = ([[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL hallTriggerEventCount = ([[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        BOOL motionTriggerEventCount = ([[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]);
        BOOL axisData = ([[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]);
        BOOL voltage = ([[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]);
        BOOL tagID = ([[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]);
        
        BOOL deviceName = ([[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL advertising = ([[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL response = ([[highBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        BOOL TH = ([[highBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"sensorStatus":@(sensorStatus),
            @"hallTriggerEventCount":@(hallTriggerEventCount),
            @"motionTriggerEventCount":@(motionTriggerEventCount),
            @"axisData":@(axisData),
            @"voltage":@(voltage),
            @"tagID":@(tagID),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
            @"TH":@(TH),
        };
        operationID = mk_ck_taskReadBXPSPayloadOperation;
    }else if ([cmd isEqualToString:@"c0"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"c1"]) {
        //读取NB模块IMEI
        NSString *imei = @"";
        if (data.length > 4) {
            NSData *imeiData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            imei = [[NSString alloc] initWithData:imeiData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"imei":(MKValidStr(imei) ? imei : @""),
        };
        operationID = mk_ck_taskReadNBModuleIMEIOperation;
    }else if ([cmd isEqualToString:@"c2"]) {
        //读取SIM卡ICCID
        NSString *iccid = @"";
        if (data.length > 4) {
            NSData *iccidData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            iccid = [[NSString alloc] initWithData:iccidData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"iccid":(MKValidStr(iccid) ? iccid : @""),
        };
        operationID = mk_ck_taskReadSimICCIDOperation;
    }else if ([cmd isEqualToString:@"c4"]) {
        //读取NB网络注册状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"c5"]) {
        //读取MQTT连接状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadMQTTConnectStatusOperation;
    }else if ([cmd isEqualToString:@"c7"]) {
        //读取Cellular模块类型
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadCellularModeOperation;
    }else if ([cmd isEqualToString:@"c8"]) {
        //读取离线数据条数
        resultDic = @{
            @"count":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ck_taskReadOfflineDataCountOperation;
    }else if ([cmd isEqualToString:@"c9"]) {
        //读取Cellular模块版本
        NSString *version = @"";
        if (data.length > 4) {
            NSData *versionData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
            version = [[NSString alloc] initWithData:versionData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"version":(MKValidStr(version) ? version : @""),
        };
        operationID = mk_ck_taskReadCellularVersionOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_ck_taskOperationID operationID = mk_ck_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //设备重启
        operationID = mk_ck_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //关机
        operationID = mk_ck_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //恢复出厂设置
        operationID = mk_ck_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //配置指示灯状态
        operationID = mk_ck_taskConfigIndicatorStatusOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //配置NTP功能开关
        operationID = mk_ck_taskConfigNtpServerStatusOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置NTP同步间隔
        operationID = mk_ck_taskConfigNtpSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //配置NTP服务器
        operationID = mk_ck_taskConfigNTPServerHostOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //配置时区
        operationID = mk_ck_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置设备状态上报间隔
        operationID = mk_ck_taskConfigHeartbeatReportIntervalOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //配置设备状态数据选择
        operationID = mk_ck_taskConfigHeartbeatReportItemsOperation;
    }else if ([cmd isEqualToString:@"13"]) {
        //配置外部断电报警开关
        operationID = mk_ck_taskConfigPowerLossNotificationOperation;
    }else if ([cmd isEqualToString:@"14"]) {
        //配置连接密码
        operationID = mk_ck_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"15"]) {
        //配置是否需要连接密码
        operationID = mk_ck_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"16"]) {
        //配置低电报警开关
        operationID = mk_ck_taskConfigLowPowerNotificationOperation;
    }else if ([cmd isEqualToString:@"17"]) {
        //配置低电量阈值
        operationID = mk_ck_taskConfigLowPowerThresholdOperation;
    }else if ([cmd isEqualToString:@"18"]) {
        //清除离线数据
        operationID = mk_ck_taskDeleteBufferDataOperation;
    }else if ([cmd isEqualToString:@"19"]) {
        //配置低电关机充电是否开机
        operationID = mk_ck_taskConfigPowerOnWhenChargingStatusOperation;
    }else if ([cmd isEqualToString:@"1a"]) {
        //配置开关机方式
        operationID = mk_ck_taskConfigPowerOnByMagnetOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //配置MQTT服务器域名
        operationID = mk_ck_taskConfigServerHostOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //配置MQTT服务器端口
        operationID = mk_ck_taskConfigServerPortOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //配置ClientID
        operationID = mk_ck_taskConfigClientIDOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //配置MQTT Clean Session
        operationID = mk_ck_taskConfigServerCleanSessionOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //配置MQTT KeepAlive
        operationID = mk_ck_taskConfigServerKeepAliveOperation;
    }else if ([cmd isEqualToString:@"27"]) {
        //配置MQTT Qos
        operationID = mk_ck_taskConfigServerQosOperation;
    }else if ([cmd isEqualToString:@"28"]) {
        //配置Subscribe topic
        operationID = mk_ck_taskConfigSubscibeTopicOperation;
    }else if ([cmd isEqualToString:@"29"]) {
        //配置Publish topic
        operationID = mk_ck_taskConfigPublishTopicOperation;
    }else if ([cmd isEqualToString:@"2a"]) {
        //配置MTQQ服务器通信加密方式
        operationID = mk_ck_taskConfigConnectModeOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //配置网络制式
        operationID = mk_ck_taskConfigNetworkPriorityOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //配置APN
        operationID = mk_ck_taskConfigApnOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //配置APN用户名
        operationID = mk_ck_taskConfigApnUsernameOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //配置APN密码
        operationID = mk_ck_taskConfigApnPasswordOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置NB连接超时时间
        operationID = mk_ck_taskConfigNBConnectTimeoutOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //配置Pin
        operationID = mk_ck_taskConfigNBPinOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //配置Region
        operationID = mk_ck_taskConfigNBRegionOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //蓝牙扫描上报模式
        operationID = mk_ck_taskConfigScanReportModeOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //扫描上报模式自动切换开关
        operationID = mk_ck_taskConfigModeAutomaticSwitchOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //配置扫描常开定期上报上报间隔
        operationID = mk_ck_taskConfigRealtimeScanPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //配置定期扫描立即上报参数
        operationID = mk_ck_taskConfigPeriodicScanImmediateReportParamsOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //配置定期扫描定期上报参数
        operationID = mk_ck_taskConfigPeriodicScanReportScanParamsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //蓝牙数据上发优先级
        operationID = mk_ck_taskConfigScanReportUploadPriorityOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //蓝牙数据保留策略
        operationID = mk_ck_taskConfigDataRetentionProrityOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置rssi过滤规则
        operationID = mk_ck_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置蓝牙扫描PHY选择
        operationID = mk_ck_taskConfigScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置广播内容过滤逻辑
        operationID = mk_ck_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置精准过滤MAC开关
        operationID = mk_ck_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //配置反向过滤MAC开关
        operationID = mk_ck_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"55"]) {
        //配置MAC过滤规则
        operationID = mk_ck_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_ck_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_ck_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"5a"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_ck_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"5b"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_ck_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_ck_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"5d"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_ck_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"5e"]) {
        //配置UID类型过滤开关
        operationID = mk_ck_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"5f"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_ck_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_ck_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //配置URL类型过滤开关
        operationID = mk_ck_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //配置URL类型过滤的内容
        operationID = mk_ck_taskConfigFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //配置TLM类型开关
        operationID = mk_ck_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //配置TLM过滤数据类型
        operationID = mk_ck_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //配置BXP-DeviceInfo过滤开关
        operationID = mk_ck_taskConfigFilterByBXPDeviceInfoStatusOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //配置BeaconX Pro-ACC设备过滤开关
        operationID = mk_ck_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //配置BeaconX Pro-TH设备过滤开关
        operationID = mk_ck_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //配置BXP-Button过滤开关
        operationID = mk_ck_taskConfigFilterByBXPButtonStatusOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //配置BXP-Button类型过滤内容
        operationID = mk_ck_taskConfigFilterByBXPButtonAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //配置BXP-TagID类型过滤开关
        operationID = mk_ck_taskConfigFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //配置BXP-TagID类型精准过滤Tag-ID开关
        operationID = mk_ck_taskConfigPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //配置BXP-TagID类型反向过滤Tag-ID开关
        operationID = mk_ck_taskConfigReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //配置BXP-TagID过滤规则
        operationID = mk_ck_taskConfigFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //配置PIR过滤开关
        operationID = mk_ck_taskConfigPirFilterStatusOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //配置PIR过滤delay response status
        operationID = mk_ck_taskConfigPirFilterDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"70"]) {
        //配置PIR过滤door status
        operationID = mk_ck_taskConfigPirFilterDoorStatusOperation;
    }else if ([cmd isEqualToString:@"71"]) {
        //配置PIR过滤sensor sensitivity
        operationID = mk_ck_taskConfigPirFilterSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"72"]) {
        //配置PIR过滤detection status
        operationID = mk_ck_taskConfigPirFilterDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"73"]) {
        //配置PIR过滤major范围
        operationID = mk_ck_taskConfigPirFilterByMajorRangeOperation;
    }else if ([cmd isEqualToString:@"74"]) {
        //配置PIR过滤minor范围
        operationID = mk_ck_taskConfigPirFilterByMinorRangeOperation;
    }else if ([cmd isEqualToString:@"75"]) {
        //配置TOF过滤开关
        operationID = mk_ck_taskConfigFilterByTofStatusOperation;
    }else if ([cmd isEqualToString:@"76"]) {
        //配置TOF过滤MFG_CODE
        operationID = mk_ck_taskConfigFilterTofCodeListOperation;
    }else if ([cmd isEqualToString:@"77"]) {
        //配置Other过滤关系开关
        operationID = mk_ck_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"78"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_ck_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"79"]) {
        //配置Other过滤条件列表
        operationID = mk_ck_taskConfigFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"7a"]) {
        //配置重复数据过滤规则
        operationID = mk_ck_taskConfigDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"7b"]) {
        //配置BXP-S过滤开关
        operationID = mk_ck_taskConfigFilterByBXPSTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"7c"]) {
        //配置BXP-S TagID精准过滤
        operationID = mk_ck_taskConfigPreciseMatchBXPSTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"7d"]) {
        //配置BXP-S TagID反向过滤
        operationID = mk_ck_taskConfigReverseFilterBXPSTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"7e"]) {
        //配置BXP-S TagID列表
        operationID = mk_ck_taskConfigFilterBXPSTagIDListOperation;
    }else if ([cmd isEqualToString:@"80"]) {
        //配置回应包开关
        operationID = mk_ck_taskConfigAdvertiseResponsePacketStatusOperation;
    }else if ([cmd isEqualToString:@"81"]) {
        //配置广播名称
        operationID = mk_ck_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"82"]) {
        //配置iBeacon Major
        operationID = mk_ck_taskConfigBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"83"]) {
        //配置iBeacon Minor
        operationID = mk_ck_taskConfigBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"84"]) {
        //配置iBeacon UUID
        operationID = mk_ck_taskConfigBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"85"]) {
        //配置Beacon Rssi@1m
        operationID = mk_ck_taskConfigBeaconRssiOperation;
    }else if ([cmd isEqualToString:@"86"]) {
        //配置广播间隔
        operationID = mk_ck_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"87"]) {
        //配置Tx Power
        operationID = mk_ck_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"88"]) {
        //配置超时广播时长
        operationID = mk_ck_taskConfigAdvTimeoutOperation;
    }else if ([cmd isEqualToString:@"90"]) {
        //配置定位参数
        operationID = mk_ck_taskConfigFixModeSelectionOperation;
    }else if ([cmd isEqualToString:@"91"]) {
        //配置定期定位上报间隔
        operationID = mk_ck_taskConfigPeriodicFixIntervalOperation;
    }else if ([cmd isEqualToString:@"92"]) {
        //配置三轴唤醒条件
        operationID = mk_ck_taskConfigAxisWakeupParamsOperation;
    }else if ([cmd isEqualToString:@"93"]) {
        //配置运动检测判断
        operationID = mk_ck_taskConfigAxisMotionParamsOperation;
    }else if ([cmd isEqualToString:@"94"]) {
        //配置运动开始定位开关
        operationID = mk_ck_taskConfigFixWhenStartsStatusOperation;
    }else if ([cmd isEqualToString:@"95"]) {
        //配置运动过程中定位开关
        operationID = mk_ck_taskConfigFixInTripStatusOperation;
    }else if ([cmd isEqualToString:@"96"]) {
        //配置运动过程中定位上报间隔
        operationID = mk_ck_taskConfigFixInTripReportIntervalOperation;
    }else if ([cmd isEqualToString:@"97"]) {
        //配置运动结束持续判断时间
        operationID = mk_ck_taskConfigFixWhenStopsTimeoutOperation;
    }else if ([cmd isEqualToString:@"98"]) {
        //配置运动结束定位开关
        operationID = mk_ck_taskConfigFixWhenStopsStatusOperation;
    }else if ([cmd isEqualToString:@"99"]) {
        //配置静止定位开关
        operationID = mk_ck_taskConfigFixInStationaryStatusOperation;
    }else if ([cmd isEqualToString:@"9a"]) {
        //配置静止定位上报间隔
        operationID = mk_ck_taskConfigFixInStationaryReportIntervalOperation;
    }else if ([cmd isEqualToString:@"9b"]) {
        //配置GPS定位超时时间
        operationID = mk_ck_taskConfigGpsFixTimeoutOperation;
    }else if ([cmd isEqualToString:@"9c"]) {
        //配置PDOP
        operationID = mk_ck_taskConfigGpsPDOPLimitOperation;
    }else if ([cmd isEqualToString:@"9d"]) {
        //配置定位数据上报选择
        operationID = mk_ck_taskConfigPositionUploadPayloadOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //配置iBeacon上报选择
        operationID = mk_ck_taskConfigBeaconPayloadOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //配置UID上报选择
        operationID = mk_ck_taskConfigUIDPayloadOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //配置Url上报选择
        operationID = mk_ck_taskConfigUrlPayloadOperation;
    }else if ([cmd isEqualToString:@"a3"]) {
        //配置TLM上报选择
        operationID = mk_ck_taskConfigTlmPayloadOperation;
    }else if ([cmd isEqualToString:@"a4"]) {
        //配置BXP_devinfo上报选择
        operationID = mk_ck_taskConfigBXPDeviceInfoPayloadOperation;
    }else if ([cmd isEqualToString:@"a5"]) {
        //配置bxp_acc上报选择
        operationID = mk_ck_taskConfigBXPACCPayloadOperation;
    }else if ([cmd isEqualToString:@"a6"]) {
        //配置bxp_th上报选择
        operationID = mk_ck_taskConfigBXPTHPayloadOperation;
    }else if ([cmd isEqualToString:@"a7"]) {
        //配置bxp_button上报选择
        operationID = mk_ck_taskConfigBXPButtonPayloadOperation;
    }else if ([cmd isEqualToString:@"a8"]) {
        //配置bxp_tag上报选择
        operationID = mk_ck_taskConfigBXPTagPayloadOperation;
    }else if ([cmd isEqualToString:@"a9"]) {
        //配置bxp_pir上报选择
        operationID = mk_ck_taskConfigBXPPIRPayloadOperation;
    }else if ([cmd isEqualToString:@"aa"]) {
        //配置TOF上报选择
        operationID = mk_ck_taskConfigMKTofPayloadOperation;
    }else if ([cmd isEqualToString:@"ab"]) {
        //配置Other上报选择
        operationID = mk_ck_taskConfigOtherPayloadOperation;
    }else if ([cmd isEqualToString:@"ac"]) {
        //配置Other block上报选择
        operationID = mk_ck_taskConfigOtherBlockPayloadOperation;
    }else if ([cmd isEqualToString:@"ad"]) {
        //配置扫描上报包参数
        operationID = mk_ck_taskConfigCommonPayloadOperation;
    }else if ([cmd isEqualToString:@"ae"]) {
        //配置bxp_s上报选择
        operationID = mk_ck_taskConfigBXPSPayloadOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_ck_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
