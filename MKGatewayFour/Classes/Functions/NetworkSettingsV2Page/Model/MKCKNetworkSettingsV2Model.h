//
//  MKCKNetworkSettingsV2Model.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/18.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKNetworkSettingsV2Model : NSObject

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
@property (nonatomic, assign)NSInteger priority;

@property (nonatomic, copy)NSString *apn;

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@property (nonatomic, copy)NSString *pin;

@property (nonatomic, copy)NSString *timeout;

/*
 Bit0:US
 BIT1:EU
 BIT2:KR
 BIT3:AU
 BIT4:ME
 BIT5:JP
 BIT6:CN
 BIT7:全世界
 Bit0~bit6同时只能配置2个区域，如果选择了bit7则只能配置为bit7
 默认为0X80

 */
@property (nonatomic, assign)NSInteger regionsBands;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
