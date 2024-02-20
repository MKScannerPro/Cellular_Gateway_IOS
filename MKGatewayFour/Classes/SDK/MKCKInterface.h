//
//  MKCKInterface.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKInterface : NSObject

#pragma mark ********************Device Service Information******************************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************System Params************************
/// Read the mac address of the device.
/*
    @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Status.
/*
 @{
    @"power":@(YES),
    @"powerOff":@(YES),
    @"gps":@(YES),
    @"network":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readIndicatorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the ntp server status.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNtpServerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Ntp Sync interval.
/*
 @{
    @"interval":@"24",      //Unit:Hour
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNtpSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read NTP server domain name.
/*
    @{
    @"host":@"47.104.81.55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNTPServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Report Interval.
/*
 @{
    @"interval":@"60",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readHeartbeatReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Report Items.
/*
 @{
    @"battery":@(YES),
    @"accelerometer":@(YES),
    @"vehicle":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readReportItemsWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Power loss notification.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPowerLossNotificationWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power notification.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readLowPowerNotificationWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power threshold.
/*
 @{
 @"threshold":@"0",     //@"0":10%  @"1":20%    @"2":30%    @"3""40%    @"4":50%
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readLowPowerThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Power on when charging.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPowerOnWhenChargingStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark *********************MQTT Params************************

/// Read the domain name of the MQTT server.
/*
 @{
    @"host":@"47.104.81.55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerHostWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the port number of the MQTT server.
/*
    @{
    @"port":@"1883"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerPortWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Client ID of the MQTT server.
/*
    @{
    @"clientID":@"appToDevice_mk_110"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readClientIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read User Name of the MQTT server.
/*
    @{
    @"username":@"mokoTest"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerUserNameWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Password of the MQTT server.
/*
    @{
    @"password":@"Moko4321"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read clean session status of the  MQTT server.
/*
    @{
    @"clean":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerCleanSessionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Keep Alive of the MQTT server.
/*
    @{
    @"keepAlive":@"60",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerKeepAliveWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Qos of the MQTT server.
/*
    @{
    @"qos":@"0",        //@"0":At most once. The message sender to find ways to send messages, but an accident and will not try again.   @"1":At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.     @"2":Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readServerQosWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the subscription topic of the device.
/*
    @{
    @"topic":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readSubscibeTopicWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the publishing theme of the device.
/*
    @{
    @"topic":@"xxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPublishTopicWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the device tcp communication encryption method.
/*
 @{
 @"mode":@"0"
 }
 @"0":TCP
 @"1":SSL.Do not verify the server certificate.
 @"2":SSL.Verify the server's certificate.
 @"3":SSL.Two-way authentication
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readConnectModeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *********************NB参数***************************
/// Network priority.
/*
    @{
    @"priority":@"0",
 }
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
+ (void)ck_readNetworkPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError * error))failedBlock;

/// APN.
/*
    @{
    @"apn":@"xxxx",
 }

*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readApnWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError * error))failedBlock;

/// APN Username.
/*
    @{
    @"username":@"xxxx",
 }

*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readApnUsernameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock;

/// APN Password.
/*
    @{
    @"password":@"xxxx",
 }

*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readApnPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Connect timeout of NB module.
/*
    @{
    @"timeout":@"180",      //Unit:s
 }

*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNBConnectTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

#pragma mark *********************扫描上报参数***************************
/// Scan & Report mode.
/*
    @{
    @"mode":@"0",
 }
 0:@"turn off scan",
 1:@"Real time scan & immediate report",
 2:@"real time scan & periodic report",
 3:@"periodic scan & immediate report",
 4:@"perodic scan & periodic report",
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readScanReportModeWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Mode automatic switch.
/*
    @{
    @"isOn":@(YES),
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readModeAutomaticSwitchWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError * error))failedBlock;

/// Report interval of Real time scan& periodic report.
/*
    @{
    @"interval":@"600",     //Unit:s
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readRealtimeScanPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock;

/// Params of Periodic scan& immediate report.
/*
    @{
    @"duration":@"5",       //Unit:s
    @"interval":@"600",     //Unit:s
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPeriodicScanImmediateReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock;

/// Params of Perodic scan & periodic report.
/*
    @{
    @"scanDuration":@"5",       //Unit:s
    @"scanInterval":@"600",     //Unit:s
    @"reportInterval":@"600",   //Unit:s
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPeriodicScanReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Data upload priority.
/*
    @{
    @"priority":@"0",   //@"0":Latest data @"1":previous data    
 }
 
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readScanReportUploadPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Data retention prority.
/*
    @{
    @"priority":@"0",   //@"0":Next period  @"1":Current period
 }
 
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readDataRetentionProrityWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock;

#pragma mark *********************扫描过滤参数***************************
/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Scanning Type/PHY.
/*
 @{
    @"phyType":@"0",            //0：1M PHY(V4.2) 1：1M PHY(V5.0) 2：1M PHY(V4.2) & 1M PHY(V5.0) 3：Coded PHY(V5.0)

 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":MAC
 @"2":ADV Name
 @"3":Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 @"7":ADV Name & MAC
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read switch status of filtered device types.
/*
 @{
     @"iBeacon":@(YES),
     @"uid":@(YES),
     @"url":@(YES),
     @"tlm":@(YES),
     @"bxp_deviceInfo":@(YES),
     @"bxp_acc":@(YES),
     @"bxp_th":@(YES),
     @"bxp_button":@(YES),
     @"bxp_tag":@(YES),
     @"bxp_pir":@(YES),
     @"bxp_tof":@(YES),
     @"other":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",         
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/*
 @{
 @"namespaceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/*
 @{
 @"instanceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/*
 @{
 @"url":@"moko.com"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/*
 @{
 @"version":@"0",           //@"0":Null(Do not filter data)   @"1":Unencrypted TLM data. @"2":Encrypted TLM data.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Button Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Alarm Filter status of the BXP Button Info.
/*
 @{
     @"singlePresse":@(YES),
     @"doublePresse":@(YES),
     @"longPresse":@(YES),
     @"abnormal":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-TagID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID addresses.
/*
 @{
 @"tagIDList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Presence status.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Delay response status.
/*
 @{
 @"status":@"0",        //@"0"：low delay @"1"：medium delay @"2"：high delay @"3"：all type
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Door status.
/*
 @{
 @"status":@"0",        //@"0"：close @"1"：open @"2"：all type
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Sensor sensitivity.
/*
 @{
 @"sensitivity":@"0",        //@"0"：low sensitivity @"1"：medium sensitivity @"2"：high sensitivity   @"3":all type
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Filter of Detection status.
/*
 @{
 @"status":@"0",        //@"0"：no effective motion detected @"1"：effective motion detected @"2"：all type
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of Pir Filter.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterByMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of Pir Filter.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPirFilterByMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Filter status of MK TOF.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readTofFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of MK TOF.
/*
 @{
 @"codeList":@[
    @"aabb",
 @"ccdd",
 @"ddee"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterTofListWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/*
 @{
 @"relationship":@"0",
 }
  0:A
  1:A & B
  2:A | B
  3:A & B & C
  4:(A & B) | C
  5:A | B | C
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter.
/*
 @{
    @"conditionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
                @"data":@"001122"
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
                @"data":@"0011"
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Duplicate Data Filter.
/*
 @{
    @"filterType":@"0",            //0：None；1：MAC；2：MAC+Data type；3：MAC+RAW Data；

 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ********************广播参数****************************
/// Advertise response packet status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAdvertiseResponsePacketStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Advertise Name.
/*
 @{
    @"advName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAdvertiseNameWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon Major.
/*
 @{
    @"major":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon Minor.
/*
 @{
    @"minor":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon UUID.
/*
 @{
    @"uuid":@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// iBeacon RSSI@1m.
/*
 @{
    @"rssi":@"-50",     //Unit:dBm
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBeaconRssiWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// ADV interval.
/*
 @{
    @"interval":@"10",     //Unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0"
 }
 0:-40dBm，
 1:-20dBm，
 2:-16dBm，
 3:-12dBm，
 4:-8dBm，
 5:-4dBm，
 6:0dBm，
 7:2dBm，
 8:3dBm，
 9:4dBm，
 10:5dBm，
 11:6dBm，
 12:7dBm，
 13:8dBm
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// ADV timeout.
/*
 @{
    @"timeout":@"0",     //Unit:minute
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAdvTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ********************定位参数****************************
/// Fix mode selection.
/*
 @{
    @"mode":@"0",            //0:@"OFF" 1:@"Periodic fix" 2:@"Motion fix" 
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixModeSelectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic fix interval.
/*
 @{
    @"interval":@"60",            //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readPeriodicFixIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 3-Axis wakeup parameters.
/*
 @{
    @"threshold":@"1",            //Unit:16mg
    @"duration":@"1",            //Unit:10ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAxisWakeupParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// 3-Axis Motion parameters.
/*
 @{
    @"threshold":@"1",            //Unit:2mg
    @"duration":@"1",            //Unit:5ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readAxisMotionParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when starts(Motion fix).
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixWhenStartsStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in trip(Motion fix).
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixInTripStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in trip report interval(Motion fix).
/*
 @{
    @"interval":@"10",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixInTripReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when stops report interval(Motion fix).
/*
 @{
    @"timeout":@"10",      //Unit:10s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixWhenStopsTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix when stops(Motion fix).
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixWhenStopsStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in stationary(Motion fix).
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixInStationaryStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix in stationary report interval(Motion fix).
/*
 @{
    @"interval":@"10",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readFixInStationaryReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// GPS fix timeout.
/*
 @{
    @"timeout":@"60",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readGpsFixTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS PDOP Limit.
/*
    @{
    @"pdop":@"25",      //Unit:0.1
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readGpsPDOPLimitWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ********************蓝牙数据上报****************************
/// iBeacon payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
    @"uuid":@(YES),
    @"major":@(YES),
    @"minor":@(YES),
    @"rssi1m":@(YES),
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBeaconPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-UID payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"rssi0m":@(YES),
    @"namespaceID":@(YES),
    @"instanceID":@(YES),
    
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readUIDPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-URL payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"rssi0m":@(YES),
    @"url":@(YES),
    
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readUrlPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Eddystone-TLM payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"tlmVersion":@(YES),
    @"voltage":@(YES),
    @"temperature":@(YES),
    @"advCount":@(YES),
    @"secCount":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readTLMPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Device Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"txPower":@(YES),
    @"rangingData":@(YES),
    @"advInterval":@(YES),
    @"voltage":@(YES),
    @"devicePropertyIndicator":@(YES),
    @"switchStatusIndicator":@(YES),
    @"firmwareVersion":@(YES),
    @"deviceName":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPDeviceInfoPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-ACC Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"txPower":@(YES),
    @"rangingData":@(YES),
    @"advInterval":@(YES),
    @"sampleRate":@(YES),
    @"fullScale":@(YES),
    @"motionThreshold":@(YES),
    @"axisData":@(YES),
    @"voltage":@(YES),
 
    @"advertising":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPACCPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-T&H Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"txPower":@(YES),
    @"rangingData":@(YES),
    @"advInterval":@(YES),
    @"temperature":@(YES),
    @"humidity":@(YES),
    @"voltage":@(YES),
 
    @"advertising":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPTHPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"frameType":@(YES),
    @"statusFlag":@(YES),
    @"triggerCount":@(YES),
    @"deviceId":@(YES),
    @"firmwareType":@(YES),
    @"deviceName":@(YES),
    @"fullScale":@(YES),
    @"motionThreshold":@(YES),
    @"axisData":@(YES),
    @"temperature":@(YES),
    @"rangingData":@(YES),
    @"voltage":@(YES),
    @"txPower":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPButtonPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Tag Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"sensorStatus":@(YES),
    @"hallTriggerEventCount":@(YES),
    @"motionTriggerEventCount":@(YES),
    @"axisData":@(YES),
    @"voltage":@(YES),
    @"tagID":@(YES),
    @"deviceName":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPTagPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-PIR Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"delayResponseStatus":@(YES),
    @"doorStatus":@(YES),
    @"sensorSensitivity":@(YES),
    @"sensorDetectionStatus":@(YES),
    @"voltage":@(YES),
    @"major":@(YES),
    @"minor":@(YES),
    @"rssi1m":@(YES),
    @"txPower":@(YES),
    @"advName":@(advName),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBXPPIRPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// MK-TOF Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"manufacturer":@(YES),
    @"voltage":@(YES),
    @"userData":@(YES),
    @"rangingDistance":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readMKTofPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Other Info payload.
/*
 @{
    @"rssi":@(YES),
    @"timestamp":@(YES),
 
    @"advertising":@(YES),
    @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readOtherPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Other block payload.
/*
    @[
    @{@"dataType":@"00",@"start":@"1",@"end":@"4"},
    @{@"dataType":@"00",@"start":@"1",@"end":@"4"},
    @{@"dataType":@"00",@"start":@"1",@"end":@"4"},
    @{@"dataType":@"00",@"start":@"1",@"end":@"4"},
 ]
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readOtherBlockPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ********************设备状态****************************
/// Read battery voltage.
/*
 @{
 @"voltage":@"3000",        //Unit:mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// The IMEI of the NB  Module .
/*
    @{
    @"imei":@"xxxx",
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNBModuleIMEIWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock;

/// The ICCID of the SIM Card.
/*
    @{
    @"iccid":@"xxxxxx",
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readSimICCIDWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Network Status.
/*
    @{
    @"status":@"0",  //@"0":Sleep state     @"1":Register network       @"2":Network registration successful
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// MQTT Connect Status.
/*
    @{
    @"status":@"0",  //@"0":Unconnected     @"1":Connected
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ck_readMQTTStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;


@end

NS_ASSUME_NONNULL_END
