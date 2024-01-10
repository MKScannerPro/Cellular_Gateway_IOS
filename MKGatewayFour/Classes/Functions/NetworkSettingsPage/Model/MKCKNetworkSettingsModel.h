//
//  MKCKNetworkSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKNetworkSettingsModel : NSObject

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

@property (nonatomic, copy)NSString *timeout;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
