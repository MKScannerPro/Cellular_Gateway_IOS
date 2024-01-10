
typedef NS_ENUM(NSInteger, mk_ck_taskOperationID) {
    mk_ck_defaultTaskOperationID,
    
#pragma mark - Read
    mk_ck_taskReadDeviceModelOperation,        //读取产品型号
    mk_ck_taskReadFirmwareOperation,           //读取固件版本
    mk_ck_taskReadHardwareOperation,           //读取硬件类型
    mk_ck_taskReadSoftwareOperation,           //读取软件版本
    mk_ck_taskReadManufacturerOperation,       //读取厂商信息
    mk_ck_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - System Params
    mk_ck_taskReadMacAddressOperation,          //读取MAC地址
    mk_ck_taskReadIndicatorStatusOperation,     //读取指示灯状态
    mk_ck_taskReadNtpServerStatusOperation,     //读取NTP服务器开关
    mk_ck_taskReadNtpSyncIntervalOperation,     //读取NTP服务器同步间隔
    mk_ck_taskReadNTPServerHostOperation,       //读取NTP服务器
    mk_ck_taskReadTimeZoneOperation,            //读取时区
    mk_ck_taskReadHeartbeatReportIntervalOperation,     //读取设备状态上报间隔
    mk_ck_taskReadReportItemsOperation,         //读取设备状态数据选择
    mk_ck_taskReadPowerLossNotificationOperation,   //读取外部断电报警开关
    mk_ck_taskReadPasswordOperation,            //读取连接密码
    mk_ck_taskReadConnectationNeedPasswordOperation,        //读取密码验证开关
    mk_ck_taskReadLowPowerNotificationOperation,            //读取低电报警开关
    mk_ck_taskReadLowPowerThresholdOperation,               //读取低电量阈值
    
#pragma mark - MQTT Params
    mk_ck_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_ck_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_ck_taskReadClientIDOperation,            //读取Client ID
    mk_ck_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_ck_taskReadServerPasswordOperation,      //读取服务器登录密码
    mk_ck_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_ck_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_ck_taskReadServerQosOperation,           //读取MQTT Qos
    mk_ck_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_ck_taskReadPublishTopicOperation,        //读取Publish topic
    mk_ck_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    
#pragma mark - NB参数
    mk_ck_taskReadNetworkPriorityOperation,     //读取网络制式
    mk_ck_taskReadApnOperation,                 //读取APN
    mk_ck_taskReadApnUsernameOperation,         //读取APN用户名
    mk_ck_taskReadApnPasswordOperation,         //读取APN密码
    mk_ck_taskReadNBConnectTimeoutOperation,    //读取NB连接超时时间
#pragma mark - 扫描上报参数
    mk_ck_taskReadScanReportModeOperation,      //读取蓝牙扫描上报模式
    mk_ck_taskReadModeAutomaticSwitchOperation, //读取扫描上报模式自动切换开关
    mk_ck_taskReadRealtimeScanPeriodicReportIntervalOperation,      //读取扫描常开定期上报上报间隔
    mk_ck_taskReadPeriodicScanImmediateReportParamsOperation,       //读取定期扫描立即上报参数
    mk_ck_taskReadPeriodicScanReportParamsOperation,                //读取定期扫描定期上报参数
    mk_ck_taskReadScanReportUploadPriorityOperation,    //读取蓝牙数据上发优先级
    mk_ck_taskReadDataRetentionProrityOperation,        //读取蓝牙数据保留策略
#pragma mark - 蓝牙扫描过滤
    mk_ck_taskReadRssiFilterValueOperation,             //读取RSSI过滤规则
    mk_ck_taskReadScanningPHYTypeOperation,             //读取蓝牙扫描PHY选择
    mk_ck_taskReadFilterRelationshipOperation,          //读取广播内容过滤逻辑
    mk_ck_taskReadFilterByMacPreciseMatchOperation,     //读取精准过滤MAC开关
    mk_ck_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_ck_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_ck_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_ck_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_ck_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_ck_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_ck_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_ck_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_ck_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_ck_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_ck_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_ck_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_ck_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_ck_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_ck_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_ck_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_ck_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_ck_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_ck_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_ck_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-TagID类型开关
    mk_ck_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-TagID类型精准过滤tagID开关
    mk_ck_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-TagID类型反向过滤tagID开关
    mk_ck_taskReadFilterBXPTagIDListOperation,             //读取BXP-TagID过滤规则
    mk_ck_taskReadPirFilterStatusOperation,             //读取PIR过滤开关
    mk_ck_taskReadPirFilterDelayResponseStatusOperation,    //读取PIR过滤delay response status
    mk_ck_taskReadPirFilterDoorStatusOperation,         //读取PIR过滤door status
    mk_ck_taskReadPirFilterSensorSensitivityOperation,  //读取PIR过滤sensor sensitivity
    mk_ck_taskReadPirFilterDetectionStatusOperation,    //读取PIR过滤detection status
    mk_ck_taskReadPirFilterByMajorRangeOperation,       //读取PIR过滤major范围
    mk_ck_taskReadPirFilterByMinorRangeOperation,       //读取PIR过滤minor范围
    mk_ck_taskReadTofFilterStatusOperation,             //读取TOF过滤开关
    mk_ck_taskReadFilterTofListOperation,               //读取TOF过滤MFG_CODE
    mk_ck_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_ck_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_ck_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    mk_ck_taskReadDuplicateDataFilterOperation,         //读取重复数据过滤规则
    
#pragma mark - 广播参数
    mk_ck_taskReadAdvertiseResponsePacketStatusOperation,   //读取回应包开关
    mk_ck_taskReadAdvertiseNameOperation,                   //读取广播名称
    mk_ck_taskReadBeaconMajorOperation,                     //读取Major
    mk_ck_taskReadBeaconMinorOperation,                     //读取Minor
    mk_ck_taskReadBeaconUUIDOperation,                     //读取UUID
    mk_ck_taskReadBeaconRssiOperation,                      //读取RSSI@1m
    mk_ck_taskReadAdvIntervalOperation,                     //读取广播间隔
    mk_ck_taskReadTxPowerOperation,                         //读取Tx Power
    mk_ck_taskReadAdvTimeoutOperation,                      //读取超时广播时长
        
#pragma mark - 定位参数
    mk_ck_taskReadFixModeSelectionOperation,            //读取定位模式
    mk_ck_taskReadPeriodicFixIntervalOperation,         //读取定期定位上报间隔
    mk_ck_taskReadAxisWakeupParamsOperation,            //读取三轴唤醒条件
    mk_ck_taskReadAxisMotionParamsOperation,            //读取运动检测判断
    mk_ck_taskReadFixWhenStartsStatusOperation,         //读取运动开始定位开关
    mk_ck_taskReadFixInTripStatusOperation,             //读取运动过程中定位开关
    mk_ck_taskReadFixInTripReportIntervalOperation,     //读取运动过程中定位上报间隔
    mk_ck_taskReadFixWhenStopsTimeoutOperation,         //读取运动结束持续判断时间
    mk_ck_taskReadFixWhenStopsStatusOperation,          //读取运动结束定位开关
    mk_ck_taskReadFixInStationaryStatusOperation,       //读取静止定位开关
    mk_ck_taskReadFixInStationaryReportIntervalOperation,   //读取静止定位上报间隔
    mk_ck_taskReadGpsFixTimeoutOperation,               //读取GPS定位超时时间
    mk_ck_taskReadGpsPDOPLimitOperation,                //读取PDOP
    
    
#pragma mark - 蓝牙数据上报
    mk_ck_taskReadBeaconPayloadOperation,               //读取iBeacon上报选择
    mk_ck_taskReadUIDPayloadOperation,                  //读取UID上报选择
    mk_ck_taskReadUrlPayloadOperation,                  //读取URL上报选择
    mk_ck_taskReadTlmPayloadOperation,                  //读取TLM上报选择
    mk_ck_taskReadBXPDeviceInfoPayloadOperation,        //读取BXP_devinfo上报选择
    mk_ck_taskReadBXPACCPayloadOperation,               //读取bxp_acc上报选择
    mk_ck_taskReadBXPTHPayloadOperation,                //读取bxp_th上报选择
    mk_ck_taskReadBXPButtonPayloadOperation,            //读取bxp_button上报选择
    mk_ck_taskReadBXPTagPayloadOperation,               //读取bxp_tag上报选择
    mk_ck_taskReadBXPPIRPayloadOperation,               //读取bxp_pir上报选择
    mk_ck_taskReadMKTofPayloadOperation,                //读取TOF上报选择
    mk_ck_taskReadOtherPayloadOperation,                //读取Other上报选择
    mk_ck_taskReadOtherBlockPayloadOperation,           //读取Other数据块上报
    
    
#pragma mark - 设备状态
    mk_ck_taskReadBatteryVoltageOperation,      //读取电池电压
    mk_ck_taskReadNBModuleIMEIOperation,        //读取NB模块IMEI
    mk_ck_taskReadSimICCIDOperation,            //读取SIM卡ICCID
    mk_ck_taskReadNetworkStatusOperation,       //读取NB网络注册状态
    mk_ck_taskReadMQTTConnectStatusOperation,   //读取MQTT连接状态
    
#pragma mark - 密码特征
    mk_ck_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备状态
    
    
#pragma mark - 设备控制参数配置
    mk_ck_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_ck_taskPowerOffOperation,                        //关机
    mk_ck_taskFactoryResetOperation,                    //设备恢复出厂设置
    mk_ck_taskConfigIndicatorStatusOperation,           //配置指示灯状态
    mk_ck_taskConfigNtpServerStatusOperation,           //配置NTP功能开关
    mk_ck_taskConfigNtpSyncIntervalOperation,           //配置NTP同步间隔
    mk_ck_taskConfigNTPServerHostOperation,             //配置NTP服务器
    mk_ck_taskConfigTimeZoneOperation,                  //配置时区
    mk_ck_taskConfigHeartbeatReportIntervalOperation,   //配置设备状态上报间隔
    mk_ck_taskConfigHeartbeatReportItemsOperation,      //配置设备状态数据选择
    mk_ck_taskConfigPowerLossNotificationOperation,     //配置外部断电报警开关
    mk_ck_taskConfigPasswordOperation,                  //配置连接密码
    mk_ck_taskConfigNeedPasswordOperation,              //配置是否需要连接密码
    mk_ck_taskConfigLowPowerNotificationOperation,      //配置低电报警开关
    mk_ck_taskConfigLowPowerThresholdOperation,         //配置低电量阈值
    mk_ck_taskDeleteBufferDataOperation,                //清除离线数据
    
#pragma mark - MQTT Params
    mk_ck_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_ck_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_ck_taskConfigClientIDOperation,              //配置ClientID
    mk_ck_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_ck_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_ck_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_ck_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_ck_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_ck_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_ck_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_ck_taskConfigConnectModeOperation,           //配置MTQQ服务器通信加密方式
    mk_ck_taskConfigCAFileOperation,                //配置CA证书
    mk_ck_taskConfigClientCertOperation,            //配置设备证书
    mk_ck_taskConfigClientPrivateKeyOperation,      //配置私钥
    
#pragma mark - NB参数
    mk_ck_taskConfigNetworkPriorityOperation,           //配置网络制式
    mk_ck_taskConfigApnOperation,                       //配置APN
    mk_ck_taskConfigApnUsernameOperation,               //配置APN用户名
    mk_ck_taskConfigApnPasswordOperation,               //配置APN密码
    mk_ck_taskConfigNBConnectTimeoutOperation,          //配置NB连接超时时间
    
#pragma mark - 扫描上报参数
    mk_ck_taskConfigScanReportModeOperation,            //蓝牙扫描上报模式
    mk_ck_taskConfigModeAutomaticSwitchOperation,       //扫描上报模式自动切换开关
    mk_ck_taskConfigRealtimeScanPeriodicReportIntervalOperation,        //配置扫描常开定期上报上报间隔
    mk_ck_taskConfigPeriodicScanImmediateReportParamsOperation,         //配置定期扫描立即上报参数
    mk_ck_taskConfigPeriodicScanReportScanParamsOperation,              //配置定期扫描定期上报参数
    mk_ck_taskConfigScanReportUploadPriorityOperation,  //蓝牙数据上发优先级
    mk_ck_taskConfigDataRetentionProrityOperation,      //蓝牙数据保留策略
#pragma mark - 扫描过滤参数
    mk_ck_taskConfigRssiFilterValueOperation,           //配置rssi过滤规则
    mk_ck_taskConfigScanningPHYTypeOperation,           //配置蓝牙扫描PHY选择
    mk_ck_taskConfigFilterRelationshipOperation,        //配置广播内容过滤逻辑
    mk_ck_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_ck_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_ck_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_ck_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_ck_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_ck_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_ck_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_ck_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_ck_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_ck_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_ck_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_ck_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_ck_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_ck_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_ck_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_ck_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_ck_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_ck_taskConfigFilterByBXPDeviceInfoStatusOperation,       //配置BXP-DeviceInfo过滤开关
    mk_ck_taskConfigBXPAccFilterStatusOperation,            //配置BeaconX Pro-ACC设备过滤开关
    mk_ck_taskConfigBXPTHFilterStatusOperation,             //配置BeaconX Pro-TH设备过滤开关
    mk_ck_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_ck_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_ck_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-TagID类型过滤开关
    mk_ck_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-TagID类型精准过滤Tag-ID开关
    mk_ck_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-TagID类型反向过滤Tag-ID开关
    mk_ck_taskConfigFilterBXPTagIDListOperation,                //配置BXP-TagID过滤规则
    mk_ck_taskConfigPirFilterStatusOperation,               //配置PIR过滤开关
    mk_ck_taskConfigPirFilterDelayResponseStatusOperation,  //配置PIR过滤delay response status
    mk_ck_taskConfigPirFilterDoorStatusOperation,           //配置PIR过滤door status
    mk_ck_taskConfigPirFilterSensorSensitivityOperation,    //配置PIR过滤sensor sensitivity
    mk_ck_taskConfigPirFilterDetectionStatusOperation,      //配置PIR过滤detection status
    mk_ck_taskConfigPirFilterByMajorRangeOperation,         //配置PIR过滤major范围
    mk_ck_taskConfigPirFilterByMinorRangeOperation,         //配置PIR过滤minor范围
    mk_ck_taskConfigFilterByTofStatusOperation,             //配置TOF过滤开关
    mk_ck_taskConfigFilterTofCodeListOperation,             //配置TOF过滤MFG_CODE
    mk_ck_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_ck_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_ck_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表
    mk_ck_taskConfigDuplicateDataFilterOperation,       //配置重复数据过滤规则
    
#pragma mark - 广播参数
    mk_ck_taskConfigAdvertiseResponsePacketStatusOperation,     //配置回应包开关
    mk_ck_taskConfigDeviceNameOperation,                        //配置广播名称
    mk_ck_taskConfigBeaconMajorOperation,                       //配置iBeacon Major
    mk_ck_taskConfigBeaconMinorOperation,                       //配置iBeacon Minor
    mk_ck_taskConfigBeaconUUIDOperation,                       //配置iBeacon UUID
    mk_ck_taskConfigBeaconRssiOperation,                        //配置Beacon Rssi@1m
    mk_ck_taskConfigAdvIntervalOperation,                       //配置广播间隔
    mk_ck_taskConfigTxPowerOperation,                           //配置Tx Power
    mk_ck_taskConfigAdvTimeoutOperation,                        //配置超时广播时长
    
#pragma mark - 定位参数
    mk_ck_taskConfigFixModeSelectionOperation,          //配置定位参数
    mk_ck_taskConfigPeriodicFixIntervalOperation,       //配置定期定位上报间隔
    mk_ck_taskConfigAxisWakeupParamsOperation,          //配置三轴唤醒条件
    mk_ck_taskConfigAxisMotionParamsOperation,          //配置运动检测判断
    mk_ck_taskConfigFixWhenStartsStatusOperation,       //配置运动开始定位开关
    mk_ck_taskConfigFixInTripStatusOperation,           //配置运动过程中定位开关
    mk_ck_taskConfigFixInTripReportIntervalOperation,   //配置运动过程中定位上报间隔
    mk_ck_taskConfigFixWhenStopsTimeoutOperation,       //配置运动结束持续判断时间
    mk_ck_taskConfigFixWhenStopsStatusOperation,        //配置运动结束定位开关
    mk_ck_taskConfigFixInStationaryStatusOperation,     //配置静止定位开关
    mk_ck_taskConfigFixInStationaryReportIntervalOperation, //配置静止定位上报间隔
    mk_ck_taskConfigGpsFixTimeoutOperation,             //配置GPS定位超时时间
    mk_ck_taskConfigGpsPDOPLimitOperation,              //配置PDOP
    
#pragma mark - 蓝牙数据上报
    mk_ck_taskConfigBeaconPayloadOperation,             //配置iBeacon上报选择
    mk_ck_taskConfigUIDPayloadOperation,                //配置UID上报选择
    mk_ck_taskConfigUrlPayloadOperation,                //配置Url上报选择
    mk_ck_taskConfigTlmPayloadOperation,                //配置TLM上报选择
    mk_ck_taskConfigBXPDeviceInfoPayloadOperation,      //配置BXP_devinfo上报选择
    mk_ck_taskConfigBXPACCPayloadOperation,             //配置bxp_acc上报选择
    mk_ck_taskConfigBXPTHPayloadOperation,              //配置bxp_th上报选择
    mk_ck_taskConfigBXPButtonPayloadOperation,          //配置bxp_button上报选择
    mk_ck_taskConfigBXPTagPayloadOperation,             //配置bxp_tag上报选择
    mk_ck_taskConfigBXPPIRPayloadOperation,             //配置bxp_pir上报选择
    mk_ck_taskConfigMKTofPayloadOperation,              //配置TOF上报选择
    mk_ck_taskConfigOtherPayloadOperation,              //配置Other上报选择
    mk_ck_taskConfigOtherBlockPayloadOperation,         //配置Other block上报选择
};
