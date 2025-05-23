#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CTMediator+MKCKAdd.h"
#import "MKCKConnectModel.h"
#import "MKCKLogDatabaseManager.h"
#import "MKCKExcelDataManager.h"
#import "MKCKExcelProtocol.h"
#import "MKCKImportServerController.h"
#import "MKCKButtonListCell.h"
#import "MKCKAxisSettingsController.h"
#import "MKCKAxisSettingsModel.h"
#import "MKCKBatteryManagementController.h"
#import "MKCKBatteryManagementModel.h"
#import "MKCKBleParamsController.h"
#import "MKCKBleParamsModel.h"
#import "MKCKBroadcastTxPowerCell.h"
#import "MKCKDebuggerController.h"
#import "MKCKDebuggerButton.h"
#import "MKCKDebuggerCell.h"
#import "MKCKDeviceInfoController.h"
#import "MKCKDeviceInfoModel.h"
#import "MKCKFilterByAdvNameController.h"
#import "MKCKFilterByAdvNameModel.h"
#import "MKCKFilterByBXPButtonController.h"
#import "MKCKFilterByBXPButtonModel.h"
#import "MKCKFilterByBXPSController.h"
#import "MKCKFilterByBXPSModel.h"
#import "MKCKFilterByBXPTagController.h"
#import "MKCKFilterByBXPTagModel.h"
#import "MKCKFilterByBeaconController.h"
#import "MKCKFilterByBeaconDefines.h"
#import "MKCKFilterByBeaconModel.h"
#import "MKCKFilterByMacController.h"
#import "MKCKFilterByMacModel.h"
#import "MKCKFilterByOtherController.h"
#import "MKCKFilterByOtherModel.h"
#import "MKCKFilterByPirController.h"
#import "MKCKFilterByPirModel.h"
#import "MKCKFilterByRawDataController.h"
#import "MKCKFilterByRawDataModel.h"
#import "MKCKFilterByTLMController.h"
#import "MKCKFilterByTLMModel.h"
#import "MKCKFilterByTofController.h"
#import "MKCKFilterByTofModel.h"
#import "MKCKFilterByUIDController.h"
#import "MKCKFilterByUIDModel.h"
#import "MKCKFilterByURLController.h"
#import "MKCKFilterByURLModel.h"
#import "MKCKScanFilterSettingsController.h"
#import "MKCKScanFilterSettingsModel.h"
#import "MKCKFixModeController.h"
#import "MKCKFixModeModel.h"
#import "MKCKGpsFixController.h"
#import "MKCKGpsFixModel.h"
#import "MKCKHeartbeatReportController.h"
#import "MKCKHeartbeatReportModel.h"
#import "MKCKLedSettingsController.h"
#import "MKCKLedSettingsModel.h"
#import "MKCKMotionFixController.h"
#import "MKCKMotionFixModel.h"
#import "MKCKMqttSettingsController.h"
#import "MKCKMqttSettingsModel.h"
#import "MKCKMQTTSSLForDeviceView.h"
#import "MKCKServerConfigDeviceFooterView.h"
#import "MKCKServerConfigDeviceSettingView.h"
#import "MKCKNetworkController.h"
#import "MKCKNetworkModel.h"
#import "MKCKNetworkSettingsController.h"
#import "MKCKNetworkSettingsModel.h"
#import "MKCKNetworkSettingsV2Controller.h"
#import "MKCKNetworkSettingsV2Model.h"
#import "MKCKRegionsBandsView.h"
#import "MKCKPayloadItemsController.h"
#import "MKCKPayloadItemsV2Controller.h"
#import "MKCKPayloadItemsV2Model.h"
#import "MKCKAccPayloadController.h"
#import "MKCKAccPayloadModel.h"
#import "MKCKBXPSPayloadController.h"
#import "MKCKBXPSPayloadModel.h"
#import "MKCKBeaconPayloadController.h"
#import "MKCKBeaconPayloadModel.h"
#import "MKCKButtonPayloadController.h"
#import "MKCKButtonPayloadModel.h"
#import "MKCKInfoPayloadController.h"
#import "MKCKInfoPayloadModel.h"
#import "MKCKOtherPayloadController.h"
#import "MKCKOtherPayloadModel.h"
#import "MKCKOtherDataBlockCell.h"
#import "MKCKOtherTypePayloadHeaderView.h"
#import "MKCKPirPayloadController.h"
#import "MKCKPirPayloadModel.h"
#import "MKCKTagPayloadController.h"
#import "MKCKTagPayloadModel.h"
#import "MKCKThPayloadController.h"
#import "MKCKThPayloadModel.h"
#import "MKCKTlmPayloadController.h"
#import "MKCKTlmPayloadModel.h"
#import "MKCKTofPayloadController.h"
#import "MKCKTofPayloadModel.h"
#import "MKCKUidPayloadController.h"
#import "MKCKUidPayloadModel.h"
#import "MKCKUrlPayloadController.h"
#import "MKCKUrlPayloadModel.h"
#import "MKCKPeriodicFixController.h"
#import "MKCKPeriodicFixModel.h"
#import "MKCKPeriodicScanController.h"
#import "MKCKPeriodicScanModel.h"
#import "MKCKPeriodicScanReportController.h"
#import "MKCKPeriodicScanReportModel.h"
#import "MKCKPositionController.h"
#import "MKCKRealtimeScanController.h"
#import "MKCKRealtimeScanModel.h"
#import "MKCKScanController.h"
#import "MKCKScanBeaconCell.h"
#import "MKCKScanInfoCell.h"
#import "MKCKScanReportModeController.h"
#import "MKCKScanReportModeModel.h"
#import "MKCKScanReportModeCell.h"
#import "MKCKScannerReportController.h"
#import "MKCKScannerReportModel.h"
#import "MKCKSettingsController.h"
#import "MKCKSettingsV2Controller.h"
#import "MKCKSettingsModel.h"
#import "MKCKSyncDeviceController.h"
#import "MKCKSyncDeviceModel.h"
#import "MKCKSyncDeviceCell.h"
#import "MKCKSyncTimeController.h"
#import "MKCKSyncTimeModel.h"
#import "MKCKSystemTimeController.h"
#import "MKCKSystemTimeModel.h"
#import "MKCKTabBarController.h"
#import "MKCKUpdateController.h"
#import "MKCKDFUModule.h"
#import "MKCKUploadPayloadSettingsController.h"
#import "MKCKUploadPayloadSettingsModel.h"
#import "MKCKNetworkService.h"
#import "MKCKUserLoginManager.h"
#import "CBPeripheral+MKCKAdd.h"
#import "MKCKCentralManager.h"
#import "MKCKInterface+MKCKConfig.h"
#import "MKCKInterface.h"
#import "MKCKOperation.h"
#import "MKCKOperationID.h"
#import "MKCKPeripheral.h"
#import "MKCKSDK.h"
#import "MKCKSDKDataAdopter.h"
#import "MKCKSDKNormalDefines.h"
#import "MKCKTaskAdopter.h"
#import "Target_ScannerPro_GW4_Module.h"

FOUNDATION_EXPORT double MKGatewayFourVersionNumber;
FOUNDATION_EXPORT const unsigned char MKGatewayFourVersionString[];

