//
//  MKCKSDKDataAdopter.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKSDKDataAdopter : NSObject

+ (NSString *)fetchTxPower:(mk_ck_txPower)txPower;

+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSString *)fetchAsciiCode:(NSString *)value;
+ (NSString *)fetchConnectModeString:(mk_ck_connectMode)mode;
+ (NSString *)fetchMqttServerQosMode:(mk_ck_mqttServerQosMode)mode;
/// 过滤的mac列表
/// @param content content
+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content;

/// 过滤的Adv Name列表
/// @param contentList contentList
+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList;

/// 过滤的url
/// @param contentList contentList
+ (NSString *)parseFilterUrlContent:(NSArray <NSData *>*)contentList;

/// 将协议中的数值对应到原型中去
/// @param other 协议中的数值
+ (NSString *)parseOtherRelationship:(NSString *)other;

/// 解析Other当前过滤条件列表
/// @param content content
+ (NSArray *)parseOtherFilterConditionList:(NSString *)content;

+ (NSString *)parseOtherRelationshipToCmd:(mk_ck_filterByOther)relationship;

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_ck_BLEFilterRawDataProtocol>)protocol;

+ (BOOL)isConfirmOtherBlockPayloadProtocol:(id <mk_ck_otherBlockPayloadProtocol>)protocol;

+ (NSString *)fetchRegionCmdString:(id <mk_ck_networkRegionsBandsProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
