//
//  MKCKInterface.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKCKCentralManager.h"
#import "MKCKOperationID.h"
#import "MKCKOperation.h"
#import "CBPeripheral+MKCKAdd.h"
#import "MKCKSDKDataAdopter.h"

#define centralManager [MKCKCentralManager shared]
#define peripheral ([MKCKCentralManager shared].peripheral)

@implementation MKCKInterface

#pragma mark ********************************Device Service Information************************************

+ (void)ck_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ck_taskReadDeviceModelOperation
                           characteristic:peripheral.ck_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ck_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ck_taskReadFirmwareOperation
                           characteristic:peripheral.ck_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ck_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ck_taskReadHardwareOperation
                           characteristic:peripheral.ck_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ck_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ck_taskReadSoftwareOperation
                           characteristic:peripheral.ck_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ck_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ck_taskReadManufacturerOperation
                           characteristic:peripheral.ck_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark *********************System Params************************
+ (void)ck_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadMacAddressOperation
                     cmdFlag:@"06"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readIndicatorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadIndicatorStatusOperation
                     cmdFlag:@"0c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNtpServerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNtpServerStatusOperation
                     cmdFlag:@"0d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNtpSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNtpSyncIntervalOperation
                     cmdFlag:@"0e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNTPServerHostOperation
                     cmdFlag:@"0f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadTimeZoneOperation
                     cmdFlag:@"10"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readHeartbeatReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadHeartbeatReportIntervalOperation
                     cmdFlag:@"11"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readReportItemsWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadReportItemsOperation
                     cmdFlag:@"12"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPowerLossNotificationWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPowerLossNotificationOperation
                     cmdFlag:@"13"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPasswordOperation
                     cmdFlag:@"14"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"15"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readLowPowerNotificationWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadLowPowerNotificationOperation
                     cmdFlag:@"16"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readLowPowerThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadLowPowerThresholdOperation
                     cmdFlag:@"17"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPowerOnWhenChargingStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPowerOnWhenChargingStatusOperation
                     cmdFlag:@"19"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPowerOnByMagnetTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPowerOnByMagnetTypeOperation
                     cmdFlag:@"1a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *********************MQTT Params************************

+ (void)ck_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadServerHostOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadServerPortOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadClientIDOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee002300";
    [centralManager addTaskWithTaskID:mk_ck_taskReadServerUserNameOperation characteristic:peripheral.ck_custom commandData:commandString successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *usernameData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [usernameData appendData:tempData];
        }
        NSString *username = [[NSString alloc] initWithData:usernameData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"username":(MKValidStr(username) ? username : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

+ (void)ck_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee002400";
    [centralManager addTaskWithTaskID:mk_ck_taskReadServerPasswordOperation characteristic:peripheral.ck_custom commandData:commandString successBlock:^(id  _Nonnull returnData) {
        NSArray *tempList = returnData[@"result"];
        NSMutableData *passwordData = [NSMutableData data];
        for (NSInteger i = 0; i < tempList.count; i ++) {
            NSData *tempData = tempList[i];
            [passwordData appendData:tempData];
        }
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"password":(MKValidStr(password) ? password : @""),
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
    } failureBlock:failedBlock];
}

+ (void)ck_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadServerCleanSessionOperation
                     cmdFlag:@"25"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadServerKeepAliveOperation
                     cmdFlag:@"26"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadServerQosOperation
                     cmdFlag:@"27"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadSubscibeTopicOperation
                     cmdFlag:@"28"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPublishTopicOperation
                     cmdFlag:@"29"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadConnectModeOperation
                     cmdFlag:@"2a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************NB参数************************************************

+ (void)ck_readNetworkPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNetworkPriorityOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readApnWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadApnOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readApnUsernameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadApnUsernameOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readApnPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadApnPasswordOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNBConnectTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNBConnectTimeoutOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNBPinWithSucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNBPinOperation
                     cmdFlag:@"35"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNBRegionWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNBRegionOperation
                     cmdFlag:@"36"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *********************扫描上报参数***************************
+ (void)ck_readScanReportModeWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadScanReportModeOperation
                     cmdFlag:@"40"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readModeAutomaticSwitchWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadModeAutomaticSwitchOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readRealtimeScanPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadRealtimeScanPeriodicReportIntervalOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPeriodicScanImmediateReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPeriodicScanImmediateReportParamsOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPeriodicScanReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPeriodicScanReportParamsOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readScanReportUploadPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadScanReportUploadPriorityOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readDataRetentionProrityWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadDataRetentionProrityOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *********************扫描过滤参数***************************

+ (void)ck_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadRssiFilterValueOperation
                     cmdFlag:@"50"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadScanningPHYTypeOperation
                     cmdFlag:@"51"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterRelationshipOperation
                     cmdFlag:@"52"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"53"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"54"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterMACAddressListOperation
                     cmdFlag:@"55"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"56"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"57"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee005800";
    [centralManager addTaskWithTaskID:mk_ck_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.ck_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKCKSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}

+ (void)ck_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterTypeStatusOperation
                     cmdFlag:@"59"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"5a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"5b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"5c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"5d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"5e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"5f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"60"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByURLStatusOperation
                     cmdFlag:@"61"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByURLContentOperation
                     cmdFlag:@"62"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"63"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"64"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"68"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"69"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"6a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"6b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"6c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"6d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterStatusOperation
                     cmdFlag:@"6e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterDelayResponseStatusOperation
                     cmdFlag:@"6f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterDoorStatusOperation
                     cmdFlag:@"70"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterSensorSensitivityOperation
                     cmdFlag:@"71"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterDetectionStatusOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterByMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterByMajorRangeOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPirFilterByMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPirFilterByMinorRangeOperation
                     cmdFlag:@"74"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readTofFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadTofFilterStatusOperation
                     cmdFlag:@"75"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterTofListWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterTofListOperation
                     cmdFlag:@"76"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"77"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"78"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"79"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadDuplicateDataFilterOperation
                     cmdFlag:@"7a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterByBXPSIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterByBXPSIDStatusOperation
                     cmdFlag:@"7b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPreciseMatchBXPSTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPreciseMatchBXPSTagIDStatusOperation
                     cmdFlag:@"7c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readReverseFilterBXPSTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadReverseFilterBXPSTagIDStatusOperation
                     cmdFlag:@"7d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFilterBXPSTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFilterBXPSTagIDListOperation
                     cmdFlag:@"7e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ********************广播参数****************************
+ (void)ck_readAdvertiseResponsePacketStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAdvertiseResponsePacketStatusOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readAdvertiseNameWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAdvertiseNameOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBeaconMajorOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBeaconMinorOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBeaconUUIDOperation
                     cmdFlag:@"84"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBeaconRssiWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBeaconRssiOperation
                     cmdFlag:@"85"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAdvIntervalOperation
                     cmdFlag:@"86"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadTxPowerOperation
                     cmdFlag:@"87"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readAdvTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAdvTimeoutOperation
                     cmdFlag:@"88"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ********************定位参数****************************
+ (void)ck_readFixModeSelectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixModeSelectionOperation
                     cmdFlag:@"90"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPeriodicFixIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPeriodicFixIntervalOperation
                     cmdFlag:@"91"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readAxisWakeupParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAxisWakeupParamsOperation
                     cmdFlag:@"92"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readAxisMotionParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadAxisMotionParamsOperation
                     cmdFlag:@"93"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixWhenStartsStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixWhenStartsStatusOperation
                     cmdFlag:@"94"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixInTripStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixInTripStatusOperation
                     cmdFlag:@"95"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixInTripReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixInTripReportIntervalOperation
                     cmdFlag:@"96"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixWhenStopsTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixWhenStopsTimeoutOperation
                     cmdFlag:@"97"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixWhenStopsStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixWhenStopsStatusOperation
                     cmdFlag:@"98"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixInStationaryStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixInStationaryStatusOperation
                     cmdFlag:@"99"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readFixInStationaryReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadFixInStationaryReportIntervalOperation
                     cmdFlag:@"9a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readGpsFixTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadGpsFixTimeoutOperation
                     cmdFlag:@"9b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readGpsPDOPLimitWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadGpsPDOPLimitOperation
                     cmdFlag:@"9c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readPositionUploadPayloadSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadPositionUploadPayloadSettingsOperation
                     cmdFlag:@"9d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ********************蓝牙数据上报****************************

+ (void)ck_readBeaconPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBeaconPayloadOperation
                     cmdFlag:@"a0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readUIDPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadUIDPayloadOperation
                     cmdFlag:@"a1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readUrlPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadUrlPayloadOperation
                     cmdFlag:@"a2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readTLMPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadTlmPayloadOperation
                     cmdFlag:@"a3"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPDeviceInfoPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPDeviceInfoPayloadOperation
                     cmdFlag:@"a4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPACCPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPACCPayloadOperation
                     cmdFlag:@"a5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPTHPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPTHPayloadOperation
                     cmdFlag:@"a6"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPButtonPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPButtonPayloadOperation
                     cmdFlag:@"a7"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPTagPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPTagPayloadOperation
                     cmdFlag:@"a8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPPIRPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPPIRPayloadOperation
                     cmdFlag:@"a9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readMKTofPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadMKTofPayloadOperation
                     cmdFlag:@"aa"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readOtherPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadOtherPayloadOperation
                     cmdFlag:@"ab"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readOtherBlockPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadOtherBlockPayloadOperation
                     cmdFlag:@"ac"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readCommonPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadCommonPayloadOperation
                     cmdFlag:@"ad"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readBXPSPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBXPSPayloadOperation
                     cmdFlag:@"ae"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ************************设备状态************************
+ (void)ck_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadBatteryVoltageOperation
                     cmdFlag:@"c0"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNBModuleIMEIWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNBModuleIMEIOperation
                     cmdFlag:@"c1"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readSimICCIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadSimICCIDOperation
                     cmdFlag:@"c2"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadNetworkStatusOperation
                     cmdFlag:@"c4"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readMQTTStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadMQTTConnectStatusOperation
                     cmdFlag:@"c5"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readCellularModeWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadCellularModeOperation
                     cmdFlag:@"c7"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readOfflineDataCountWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadOfflineDataCountOperation
                     cmdFlag:@"c8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ck_readCellularVersionWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ck_taskReadCellularVersionOperation
                     cmdFlag:@"c9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_ck_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.ck_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
