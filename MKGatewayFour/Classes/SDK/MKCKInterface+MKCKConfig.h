//
//  MKCKInterface+MKCKConfig.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKInterface (MKCKConfig)

#pragma mark ************************System************************
/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Status.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configIndicatorStatus:(id <mk_ck_indicatorStatusProtocol>)protocol
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// The ntp server status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNtpServerStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Ntp Sync interval.
/// @param interval 1Hour~720Hour.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNtpSyncInterval:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure NTP server domain name.
/// @param host 0~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNTPServerHost:(NSString *)host
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;



/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Report Interval.
/// @param interval 0s or 30s-86400s.0 meas there will be only one reporting after the device connects to cloud.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configHeartbeatReportInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Report Items.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configHeartbeatReportItems:(id <mk_ck_heartbeatReportItemsProtocol>)protocol
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Power loss notification
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPowerLossNotification:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power notification.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configLowPowerNotification:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power threshold.
/// @param threshold threshold
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configLowPowerThreshold:(mk_ck_lowPowerPrompt)threshold 
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Delete buffer data.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_deleteBufferDataWithSucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************MQTT Params************************
/// Configure the domain name of the MQTT server.
/// @param host 1~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerHost:(NSString *)host
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the port number of the MQTT server.
/// @param port 0~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerPort:(NSInteger)port
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Client ID of the MQTT server.
/// @param clientID 1~64 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configClientID:(NSString *)clientID
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the user name for the device to connect to the server. If the server passes the certificate or does not require any authentication, you do not need to fill in.
/// @param userName 0~256 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerUserName:(NSString *)userName
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the password for the device to connect to the server. If the server passes the certificate or does not require any authentication, you do not need to fill in.
/// @param password 0~256 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerPassword:(NSString *)password
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure clean session of the  MQTT server.
/// @param clean clean
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerCleanSession:(BOOL)clean
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Keep Alive of the MQTT server.
/// @param interval 10s~120s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerKeepAlive:(NSInteger)interval
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Qos of the MQTT server.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configServerQos:(mk_ck_mqttServerQosMode)mode
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the subscription topic of the device.
/// @param subscibeTopic 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configSubscibeTopic:(NSString *)subscibeTopic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the publishing theme of the device.
/// @param publishTopic 1~128 character ascii code.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPublishTopic:(NSString *)publishTopic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the device tcp communication encryption method.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configConnectMode:(mk_ck_connectMode)mode
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the root certificate of the MQTT server.
/// @param caFile caFile
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configCAFile:(NSData *)caFile
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure client certificate.
/// @param cert cert
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configClientCert:(NSData *)cert
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure client private key.
/// @param privateKey privateKey
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configClientPrivateKey:(NSData *)privateKey
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************NB参数***************************

/// Network priority.
/// @param priority 0~10
/*
 0:@"eMTC->NB-IOT->GSM",
 1:@"eMTC->GSM->NB-IOT",
 2:@"NB-IOT->GSM->eMTC",
 3:@"NB-IOT->eMTC->GSM",
 4:@"GSM->NB-IOT->eMTC",
 5:@"GSM->eMTC->NB-IOT",
 6:@"eMTC->NB-IOT",
 7:@"NB-IOT-> eMTC",
 8:@"GSM",
 9:@"NB-IOT",
 10:@"eMTC"
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNetworkPriority:(NSInteger)priority
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// APN.
/// @param apn 0-100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configApn:(NSString *)apn
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// APN Username.
/// @param username 0-100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configApnUsername:(NSString *)username
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// APN Password.
/// @param password 0-100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configApnPassword:(NSString *)password
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Connect timeout of NB module.
/// @param timeout 30s~600s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configNBConnectTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************扫描上报参数***************************

/// Scan & Report mode.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configScanReportMode:(mk_ck_scanReportMode)mode
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Mode automatic switch.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configModeAutomaticSwitch:(BOOL)isOn 
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Report interval of Real time scan& periodic report.
/// @param interval 600s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configRealtimeScanPeriodicReportInterval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Params of Periodic scan& immediate report.
/// @param duration Scan duration,3s~3600s.
/// @param interval Scan interval,600s~86400s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPeriodicScanImmediateReportDuratin:(NSInteger)duration 
                                           interval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Params of Perodic scan & periodic report.
/// @param scanDuration Scan duration,3s~3600s.
/// @param scanInterval Scan interval,600s~86400s.
/// @param reportInterval Report interval,600s~86400s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPeriodicScanReportScanDuratin:(NSInteger)scanDuration
                                  scanInterval:(NSInteger)scanInterval
                                reportInterval:(NSInteger)reportInterval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Data upload priority.
/// @param priority priority
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configScanReportUploadPriority:(mk_ck_scanReportUploadPriority)priority 
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Data retention prority.
/// @param priority priority
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configDataRetentionPrority:(mk_ck_dataRetentionPrority)priority
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************蓝牙扫描过滤参数***************************
/// The device will uplink valid ADV data with RSSI no less than rssi dBm.
/// @param rssi -127 dBm ~ 0 dBm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Scanning Type/PHY.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configScanningPHYType:(mk_ck_PHYMode)mode
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterRelationship:(mk_ck_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByMacPreciseMatch:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByMacReverseFilter:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByAdvNamePreciseMatch:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByAdvNameReverseFilter:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of Adv Name.
/// @param nameList You can set up to 10 filters.1-20 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBeaconStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBeaconMajor:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBeaconMinor:(NSInteger)minValue
                            maxValue:(NSInteger)maxValue
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBeaconUUID:(NSString *)uuid
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByUIDStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/// @param namespaceID 0~10 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByUIDNamespaceID:(NSString *)namespaceID
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/// @param instanceID 0~6 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByUIDInstanceID:(NSString *)instanceID
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByURLStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/// @param content 0~100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByURLContent:(NSString *)content
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByTLMStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/// @param version version
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByTLMVersion:(mk_ck_filterByTLMVersion)version
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Device Info.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBXPDeviceInfoStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-ACC device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPAccFilterStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-T&H device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPTHFilterStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBXPButtonStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button type filter content.
/// @param singlePress Filter Single Press alarm message switch.
/// @param doublePress Filter Double Press alarm message switch
/// @param longPress Filter Long Press alarm message switch
/// @param abnormalInactivity Abnormal Inactivity
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBXPButtonAlarmStatus:(BOOL)singlePress
                                  doublePress:(BOOL)doublePress
                                    longPress:(BOOL)longPress
                           abnormalInactivity:(BOOL)abnormalInactivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-TagID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByBXPTagIDStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPreciseMatchTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configReverseFilterTagIDStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterBXPTagIDList:(NSArray <NSString *>*)tagIDList
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Presence status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Delay response status.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterDelayResponseStatus:(mk_ck_pirFilterDelayResponseStatus)status
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Door status.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterDoorStatus:(mk_ck_pirFilterDoorStatus)status
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Sensor sensitivity.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterSensorSensitivity:(mk_ck_pirFilterSensorSensitivity)sensitivity
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Detection status.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterDetectionStatus:(mk_ck_pirFilterDetectionStatus)status
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of Pir Filter.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterByMajorRange:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of Pir Filter.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configPirFilterByMinorRange:(NSInteger)minValue
                              maxValue:(NSInteger)maxValue
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK TOF..
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByTofStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of TOF List.
/// @param codeList You can set up to 10 filters.2 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterTofCodeList:(NSArray <NSString *>*)codeList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByOtherStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByOtherRelationship:(mk_ck_filterByOther)relationship
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter conditions.
/// @param conditions conditions
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configFilterByOtherConditions:(NSArray <mk_ck_BLEFilterRawDataProtocol>*)conditions
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Duplicate Data Filter.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configDuplicateDataFilter:(mk_ck_duplicateDataFilter)type
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************蓝牙广播参数************************

/// Advertise response packet status.
/// - Parameters:
///   - isOn: isOn.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAdvertiseResponsePacketStatus:(BOOL)isOn
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Advertise Name.
/// - Parameters:
///   - deviceName: 1~10 character ascii code.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAdvertiseName:(NSString *)deviceName
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon Major.
/// - Parameters:
///   - major: 0~65535
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configBeaconMajor:(NSInteger)major
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon Minor.
/// - Parameters:
///   - minor: 0~65535
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configBeaconMinor:(NSInteger)minor
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon UUID.
/// - Parameters:
///   - uuid: 16 Bytes.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configBeaconUUID:(NSString *)uuid
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon Rssi@1m.
/// - Parameters:
///   - rssi: -100dBm~0dBm.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configBeaconRssi:(NSInteger)rssi
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Advertise Interval.
/// - Parameters:
///   - interval: 1x100ms~100x100ms.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

+ (void)ck_configTxPower:(mk_ck_txPower)txPower 
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Advertise timeout.
/// - Parameters:
///   - timeout: 0~60 minute.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAdvTimeout:(NSInteger)timeout
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************定位参数************************

/// Fix mode selection.
/// - Parameters:
///   - mode: mode
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixModeSelection:(mk_ck_positionFixMode)mode
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic fix interval.
/// - Parameters:
///   - interval: 60s~86400s.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configPeriodicFixInterval:(NSInteger)interval 
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// 3-Axis wakeup parameters.
/// - Parameters:
///   - threshold: 1x16mg ~ 20x16mg
///   - duration: 1x10ms~10x10ms
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAxisWakeupParams:(NSInteger)threshold
                         duration:(NSInteger)duration
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// 3-Axis Motion parameters.
/// - Parameters:
///   - threshold: 10x2mg ~ 250x2mg
///   - duration: 1x5ms~15x5ms
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configAxisMotionParams:(NSInteger)threshold
                         duration:(NSInteger)duration
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when starts(Motion fix).
/// - Parameters:
///   - isOn: isOn
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixWhenStartsStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in trip(Motion fix).
/// - Parameters:
///   - isOn: isOn
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixInTripStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in trip report interval(Motion fix).
/// - Parameters:
///   - interval: 10s~86400s.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixInTripReportInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when stops report interval(Motion fix).
/// - Parameters:
///   - timeout: 3 * 10s ~ 180 * 10s
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixWhenStopsTimeout:(NSInteger)timeout
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when stops(Motion fix).
/// - Parameters:
///   - isOn: isOn
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixWhenStopsStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in stationary(Motion fix).
/// - Parameters:
///   - isOn: isOn
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixInStationaryStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in stationary report interval(Motion fix).
/// - Parameters:
///   - interval: 1Min~1440Mins.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configFixInStationaryReportInterval:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// GPS fix timeout.
/// - Parameters:
///   - timeout: 60s~600s.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ck_configGpsFixTimeout:(NSInteger)timeout
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS PDOP Limit.
/// @param pdop 25 * 0.1~100 * 0.1
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configGpsPDOPLimit:(NSInteger)pdop
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;
 
#pragma mark *********************蓝牙数据上报************************

/// iBeacon payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBeaconPayload:(id <mk_ck_beaconPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-UID payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configUIDPayload:(id <mk_ck_uidPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-Url payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configUrlPayload:(id <mk_ck_urlPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-TLM payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configTLMPayload:(id <mk_ck_tlmPayloadProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-DeviceInfo payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPDeviceInfoPayload:(id <mk_ck_bxpDeviceInfoPayloadProtocol>)protocol
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-ACC payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPACCPayload:(id <mk_ck_bxpACCPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-TH payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPTHPayload:(id <mk_ck_bxpTHPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPButtonPayload:(id <mk_ck_bxpButtonPayloadProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Tag payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPTagPayload:(id <mk_ck_bxpTagPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-PIR payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configBXPPIRPayload:(id <mk_ck_bxpPIRPayloadProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// MK TOF payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configMKTofPayload:(id <mk_ck_mkTofPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Other payload.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configOtherPayload:(id <mk_ck_otherPayloadProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Other block payload.
/// @param list list
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_configOtherBlockPayload:(NSArray <id <mk_ck_otherPayloadProtocol>> *)list
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
