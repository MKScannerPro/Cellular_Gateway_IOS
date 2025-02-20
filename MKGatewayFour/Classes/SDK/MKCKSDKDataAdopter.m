//
//  MKCKSDKDataAdopter.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKCKSDKDataAdopter

+ (NSString *)fetchTxPower:(mk_ck_txPower)txPower {
    switch (txPower) {
        case mk_ck_txPower8dBm:
            return @"08";
        case mk_ck_txPower7dBm:
            return @"07";
        case mk_ck_txPower6dBm:
            return @"06";
        case mk_ck_txPower5dBm:
            return @"05";
        case mk_ck_txPower4dBm:
            return @"04";
        case mk_ck_txPower3dBm:
            return @"03";
        case mk_ck_txPower2dBm:
            return @"02";
        case mk_ck_txPower0dBm:
            return @"00";
        case mk_ck_txPowerNeg4dBm:
            return @"fc";
        case mk_ck_txPowerNeg8dBm:
            return @"f8";
        case mk_ck_txPowerNeg12dBm:
            return @"f4";
        case mk_ck_txPowerNeg16dBm:
            return @"f0";
        case mk_ck_txPowerNeg20dBm:
            return @"ec";
        case mk_ck_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"08"]) {
        return @"8dBm";
    }
    if ([content isEqualToString:@"07"]) {
        return @"7dBm";
    }
    if ([content isEqualToString:@"06"]) {
        return @"6dBm";
    }
    if ([content isEqualToString:@"05"]) {
        return @"5dBm";
    }
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"02"]) {
        return @"2dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

+ (NSString *)fetchAsciiCode:(NSString *)value {
    if (!MKValidStr(value)) {
        return @"";
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < value.length; i ++) {
        int asciiCode = [value characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    return tempString;
}

+ (NSString *)fetchConnectModeString:(mk_ck_connectMode)mode {
    switch (mode) {
        case mk_ck_connectMode_TCP:
            return @"00";
        case mk_ck_connectMode_CASignedServerCertificate:
            return @"01";
        case mk_ck_connectMode_CACertificate:
            return @"02";
        case mk_ck_connectMode_SelfSignedCertificates:
            return @"03";
    }
}

+ (NSString *)fetchMqttServerQosMode:(mk_ck_mqttServerQosMode)mode {
    switch (mode) {
        case mk_ck_mqttQosLevelAtMostOnce:
            return @"00";
        case mk_ck_mqttQosLevelAtLeastOnce:
            return @"01";
        case mk_ck_mqttQosLevelExactlyOnce:
            return @"02";
    }
}

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        index += subLen * 2;
        [dataList addObject:subContent];
    }
    return dataList;
}

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @[];
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *advNameList = [NSMutableArray array];
    for (NSInteger i = 0; i < contentData.length; i ++) {
        if (index >= contentData.length) {
            break;
        }
        NSData *lenData = [contentData subdataWithRange:NSMakeRange(index, 1)];
        NSString *lenString = [MKBLEBaseSDKAdopter hexStringFromData:lenData];
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:lenString range:NSMakeRange(0, lenString.length)];
        NSData *subData = [contentData subdataWithRange:NSMakeRange(index + 1, subLen)];
        NSString *advName = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
        if (advName) {
            [advNameList addObject:advName];
        }
        index += (subLen + 1);
    }
    return advNameList;
}

+ (NSString *)parseFilterUrlContent:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @"";
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @"";
    }
    NSString *url = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return (MKValidStr(url) ? url : @"");
}

+ (NSString *)parseOtherRelationship:(NSString *)other {
    if (!MKValidStr(other)) {
        return @"0";
    }
    if ([other isEqualToString:@"00"]) {
        //A
        return @"0";
    }
    if ([other isEqualToString:@"01"]) {
        //A&B
        return @"1";
    }
    if ([other isEqualToString:@"02"]) {
        //A|B
        return @"2";
    }
    if ([other isEqualToString:@"03"]) {
        //A & B & C
        return @"3";
    }
    if ([other isEqualToString:@"04"]) {
        //(A & B) | C
        return @"4";
    }
    if ([other isEqualToString:@"05"]) {
        //A | B | C
        return @"5";
    }
    return @"0";
}

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        
        NSString *type = [subContent substringWithRange:NSMakeRange(0, 2)];
        NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(2, 2)];
        NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(4, 2)];
        NSString *data = [subContent substringFromIndex:6];
        
        NSDictionary *dataDic = @{
            @"type":type,
            @"start":start,
            @"end":end,
            @"data":(data ? data : @""),
        };
        
        index += subLen * 2;
        [dataList addObject:dataDic];
    }
    return dataList;
}

+ (NSString *)parseOtherRelationshipToCmd:(mk_ck_filterByOther)relationship {
    switch (relationship) {
        case mk_ck_filterByOther_A:
            return @"00";
        case mk_ck_filterByOther_AB:
            return @"01";
        case mk_ck_filterByOther_AOrB:
            return @"02";
        case mk_ck_filterByOther_ABC:
            return @"03";
        case mk_ck_filterByOther_ABOrC:
            return @"04";
        case mk_ck_filterByOther_AOrBOrC:
            return @"05";
    }
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_ck_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_ck_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    if ([protocol.dataType isEqualToString:@"00"]) {
        protocol.minIndex = 0;
        protocol.maxIndex = 0;
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}



+ (BOOL)isConfirmOtherBlockPayloadProtocol:(id <mk_ck_otherBlockPayloadProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_ck_otherBlockPayloadProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    
    if (![MKBLEBaseSDKAdopter asciiString:protocol.dataType] || protocol.dataType.length != 2) {
        return NO;
    }
    
    if (protocol.start < 1 || protocol.start > 29 || protocol.end < 1 || protocol.end > 29) {
        return NO;
    }
    if (protocol.start > protocol.end) {
        return NO;
    }
    
    return YES;
}

+ (NSString *)fetchRegionCmdString:(id <mk_ck_networkRegionsBandsProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_ck_networkRegionsBandsProtocol)]) {
        return @"";
    }
    if (protocol.allOfThem) {
        return @"80";
    }
    // 计算选择的区域数量
    NSUInteger count = 0;
    NSUInteger result = 0;

    // 检查每个区域的选择状态
    if (protocol.us) { count++; result |= (1 << 0); }
    if (protocol.europe) { count++; result |= (1 << 1); }
    if (protocol.korea) { count++; result |= (1 << 2); }
    if (protocol.australia) { count++; result |= (1 << 3); }
    if (protocol.middleEst) { count++; result |= (1 << 4); }
    if (protocol.japan) { count++; result |= (1 << 5); }
    if (protocol.china) { count++; result |= (1 << 6); }

    // 只能选择两个区域
    if (count > 2) {
        return @""; // 超过两个区域，返回默认值
    }

    // 返回十六进制字符串
    return [NSString stringWithFormat:@"%02lx", (unsigned long)result];
}

@end
