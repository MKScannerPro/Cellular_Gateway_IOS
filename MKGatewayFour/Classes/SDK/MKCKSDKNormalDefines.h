#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKCKCentralManager

typedef NS_ENUM(NSInteger, mk_ck_centralConnectStatus) {
    mk_ck_centralConnectStatusUnknow,                                           //未知状态
    mk_ck_centralConnectStatusConnecting,                                       //正在连接
    mk_ck_centralConnectStatusConnected,                                        //连接成功
    mk_ck_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_ck_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_ck_centralManagerStatus) {
    mk_ck_centralManagerStatusUnable,                           //不可用
    mk_ck_centralManagerStatusEnable,                           //可用状态
};




typedef NS_ENUM(NSInteger, mk_ck_lowPowerPrompt) {
    mk_ck_lowPowerPrompt_tenPercent,
    mk_ck_lowPowerPrompt_twentyPercent,
    mk_ck_lowPowerPrompt_thirtyPercent,
    mk_ck_lowPowerPrompt_fortyPercent,
    mk_ck_lowPowerPrompt_fiftyPercent,
};


typedef NS_ENUM(NSInteger, mk_ck_txPower) {
    mk_ck_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_ck_txPowerNeg20dBm,   //-20dBm
    mk_ck_txPowerNeg16dBm,   //-16dBm
    mk_ck_txPowerNeg12dBm,   //-12dBm
    mk_ck_txPowerNeg8dBm,    //-8dBm
    mk_ck_txPowerNeg4dBm,    //-4dBm
    mk_ck_txPower0dBm,       //0dBm
    mk_ck_txPower2dBm,       //2dBm
    mk_ck_txPower3dBm,       //3dBm
    mk_ck_txPower4dBm,       //4dBm
    mk_ck_txPower5dBm,       //5dBm
    mk_ck_txPower6dBm,       //6dBm
    mk_ck_txPower7dBm,       //7dBm
    mk_ck_txPower8dBm,       //8dBm
};


typedef NS_ENUM(NSInteger, mk_ck_connectMode) {
    mk_ck_connectMode_TCP,                                          //TCP
    mk_ck_connectMode_CASignedServerCertificate,                    //SSL.Do not verify the server certificate.
    mk_ck_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_ck_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_ck_mqttServerQosMode) {
    mk_ck_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_ck_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_ck_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_ck_scanReportMode) {
    mk_ck_scanReportMode_close,                                //Close
    mk_ck_scanReportMode_realTimeScanAndImmediateReport,       //Real time scan& immediate report
    mk_ck_scanReportMode_realTimeScanAndPeriodicReport,        //real time scan & periodic report
    mk_ck_scanReportMode_periodicScanAndImmediateReport,       //periodic scan& immediate report
    mk_ck_scanReportMode_perodicScanAndPeriodicReport,         //perodic scan & periodic report
};

typedef NS_ENUM(NSInteger, mk_ck_scanReportUploadPriority) {
    mk_ck_scanReportUploadPriority_latestData,
    mk_ck_scanReportUploadPriority_previousData,
};

typedef NS_ENUM(NSInteger, mk_ck_dataRetentionPrority) {
    mk_ck_dataRetentionPrority_nextPeriod,
    mk_ck_dataRetentionPrority_currentPeriod,
};

typedef NS_ENUM(NSInteger, mk_ck_PHYMode) {
    mk_ck_PHYMode_BLE4,                     //1M PHY (BLE 4.2)
    mk_ck_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_ck_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.2 + BLE 5)
    mk_ck_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_ck_filterRelationship) {
    mk_ck_filterRelationship_null,
    mk_ck_filterRelationship_mac,
    mk_ck_filterRelationship_advName,
    mk_ck_filterRelationship_rawData,
    mk_ck_filterRelationship_advNameAndRawData,
    mk_ck_filterRelationship_macAndadvNameAndRawData,
    mk_ck_filterRelationship_advNameOrRawData,
    mk_ck_filterRelationship_advNameAndMac,
};

typedef NS_ENUM(NSInteger, mk_ck_duplicateDataFilter) {
    mk_ck_duplicateDataFilter_none,                     //Null
    mk_ck_duplicateDataFilter_mac,                     //Only MAC
    mk_ck_duplicateDataFilter_macAndDataType,          //MAC+Data type
    mk_ck_duplicateDataFilter_macAndRawData,           //MAC+Raw data
};

typedef NS_ENUM(NSInteger, mk_ck_positionFixMode) {
    mk_ck_positionFixMode_off,                     //Off
    mk_ck_positionFixMode_periodicFix,             //Periodic Fix
    mk_ck_positionFixMode_motionFix,               //Motion Fix
};

typedef NS_ENUM(NSInteger, mk_ck_filterByTLMVersion) {
    mk_ck_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_ck_filterByTLMVersion_1,                //Encrypted TLM data.
    mk_ck_filterByTLMVersion_all,             //All version.
};

typedef NS_ENUM(NSInteger, mk_ck_filterByOther) {
    mk_ck_filterByOther_A,                 //Filter by A condition.
    mk_ck_filterByOther_AB,                //Filter by A & B condition.
    mk_ck_filterByOther_AOrB,              //Filter by A | B condition.
    mk_ck_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_ck_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_ck_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_ck_pirFilterDelayResponseStatus) {
    mk_ck_pirFilterDelayResponseStatus_lowDelay,
    mk_ck_pirFilterDelayResponseStatus_mediumDelay,
    mk_ck_pirFilterDelayResponseStatus_highDelay,
    mk_ck_pirFilterDelayResponseStatus_allType
};

typedef NS_ENUM(NSInteger, mk_ck_pirFilterDoorStatus) {
    mk_ck_pirFilterDoorStatus_close,
    mk_ck_pirFilterDoorStatus_open,
    mk_ck_pirFilterDoorStatus_allType,
};

typedef NS_ENUM(NSInteger, mk_ck_pirFilterSensorSensitivity) {
    mk_ck_pirFilterSensorSensitivity_low,
    mk_ck_pirFilterSensorSensitivity_medium,
    mk_ck_pirFilterSensorSensitivity_high,
    mk_ck_pirFilterSensorSensitivity_allType
};

typedef NS_ENUM(NSInteger, mk_ck_pirFilterDetectionStatus) {
    mk_ck_pirFilterDetectionStatus_null,
    mk_ck_pirFilterDetectionStatus_detect,
    mk_ck_pirFilterDetectionStatus_all,
};

typedef NS_ENUM(NSInteger, mk_ck_powerOnByMagnetType) {
    mk_ck_powerOnByMagnetType_detectsThreeTimes,
    mk_ck_powerOnByMagnetType_detectsThreeSeconds,
};

typedef NS_ENUM(NSInteger, mk_ck_powerOnByChargingType) {
    mk_ck_powerOnByChargingTypeEveryTime,
    mk_ck_powerOnByChargingTypeWhenBatteryDead,
};



@protocol mk_ck_heartbeatReportItemsProtocol <NSObject>

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL accelerometer;

@property (nonatomic, assign)BOOL vehicle;

@property (nonatomic, assign)BOOL sequence;

@end


@protocol mk_ck_indicatorStatusProtocol <NSObject>

@property (nonatomic, assign)BOOL power;

@property (nonatomic, assign)BOOL powerOff;

@property (nonatomic, assign)BOOL network;

@property (nonatomic, assign)BOOL gps;

@end



@protocol mk_ck_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end



@protocol mk_ck_networkRegionsBandsProtocol <NSObject>

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



@protocol mk_ck_beaconPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL uuid;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

@property (nonatomic, assign)BOOL rssi1m;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_uidPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL rssi0m;

@property (nonatomic, assign)BOOL namespaceID;

@property (nonatomic, assign)BOOL instanceID;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end


@protocol mk_ck_urlPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL rssi0m;

@property (nonatomic, assign)BOOL url;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end

@protocol mk_ck_tlmPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL tlmVersion;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL advCount;

@property (nonatomic, assign)BOOL secCount;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_bxpDeviceInfoPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL devicePropertyIndicator;

@property (nonatomic, assign)BOOL switchStatusIndicator;

@property (nonatomic, assign)BOOL firmwareVersion;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_bxpACCPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL sampleRate;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL advertising;

@end


@protocol mk_ck_bxpTHPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL humidity;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL advertising;

@end



@protocol mk_ck_bxpButtonPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL frameType;

@property (nonatomic, assign)BOOL statusFlag;

@property (nonatomic, assign)BOOL triggerCount;

@property (nonatomic, assign)BOOL deviceId;

@property (nonatomic, assign)BOOL firmwareType;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_bxpTagPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL sensorStatus;

@property (nonatomic, assign)BOOL hallTriggerEventCount;

@property (nonatomic, assign)BOOL motionTriggerEventCount;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL tagID;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end

@protocol mk_ck_bxpBXPSPayloadProtocol <mk_ck_bxpTagPayloadProtocol>

@property (nonatomic, assign)BOOL TH;

@end



@protocol mk_ck_bxpPIRPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL delayResponseStatus;

@property (nonatomic, assign)BOOL doorStatus;

@property (nonatomic, assign)BOOL sensorSensitivity;

@property (nonatomic, assign)BOOL sensorDetectionStatus;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

@property (nonatomic, assign)BOOL rssi1m;

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advName;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_mkTofPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL manufacturer;

@property (nonatomic, assign)BOOL voltage;

@property (nonatomic, assign)BOOL userData;

@property (nonatomic, assign)BOOL rangingDistance;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end


@protocol mk_ck_otherPayloadProtocol <NSObject>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_ck_otherBlockPayloadProtocol <NSObject>

/// 00-ff
@property (nonatomic, copy)NSString *dataType;

/// 1~29
@property (nonatomic, assign)NSInteger start;

/// 1~29
@property (nonatomic, assign)NSInteger end;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_ck_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-55),
 @"peripheral":peripheral,
 @"deviceName":@"MKCK4-2850",
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"deviceType":@"00",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 @"needPassword":@(YES),
 @"beacon":beacon,
 }
 */
- (void)mk_ck_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_ck_startScan;

/// Stops scanning equipment.
- (void)mk_ck_stopScan;

@end


@protocol mk_ck_centralManagerLogDelegate <NSObject>

- (void)mk_ck_receiveLog:(NSString *)deviceLog;

@end
