//
//  MKCKServerConfigDeviceFooterView.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKServerConfigDeviceFooterViewModel : NSObject

@property (nonatomic, assign)BOOL cleanSession;

@property (nonatomic, assign)NSInteger qos;

@property (nonatomic, copy)NSString *keepAlive;

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

///  0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientKeyName;

@property (nonatomic, copy)NSString *clientCertName;

@end

@protocol MKCKServerConfigDeviceFooterViewDelegate <NSObject>

/// 用户改变了开关状态
/// @param isOn isOn
/// @param statusID 0:cleanSession   1:ssl
- (void)ck_mqtt_serverForDevice_switchStatusChanged:(BOOL)isOn statusID:(NSInteger)statusID;

/// 输入框内容发生了改变
/// @param text 最新的输入框内容
/// @param textID 0:keepAlive    1:userName     2:password
- (void)ck_mqtt_serverForDevice_textFieldValueChanged:(NSString *)text textID:(NSInteger)textID;

/// Qos发生改变
/// @param qos qos
/// @param qosID 0:qos
- (void)ck_mqtt_serverForDevice_qosChanged:(NSInteger)qos qosID:(NSInteger)qosID;

/// 用户选择了加密方式
/// @param certificate  0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)ck_mqtt_serverForDevice_certificateChanged:(NSInteger)certificate;

/// 用户点击了证书相关按钮
/// @param fileType 0:caFaile   1:cilentKeyFile   2:client cert file
- (void)ck_mqtt_serverForDevice_fileButtonPressed:(NSInteger)fileType;

/// 底部按钮
/// @param index 0:Export Demo File   1:Import Config File  2:Clear All Configurations
- (void)ck_mqtt_serverForDevice_bottomButtonPressed:(NSInteger)index;

@end

@interface MKCKServerConfigDeviceFooterView : UIView

@property (nonatomic, strong)MKCKServerConfigDeviceFooterViewModel *dataModel;

@property (nonatomic, weak)id <MKCKServerConfigDeviceFooterViewDelegate>delegate;

/// 动态刷新高度
/// @param isOn ssl开关是否打开
/// @param caFile 根证书名字
/// @param clientKeyName 客户端私钥名字
/// @param clientCertName 客户端证书
/// @param certificate 当前ssl加密规则
- (CGFloat)fetchHeightWithSSLStatus:(BOOL)isOn
                         CAFileName:(NSString *)caFile
                      clientKeyName:(NSString *)clientKeyName
                     clientCertName:(NSString *)clientCertName
                        certificate:(NSInteger)certificate;

@end

NS_ASSUME_NONNULL_END
