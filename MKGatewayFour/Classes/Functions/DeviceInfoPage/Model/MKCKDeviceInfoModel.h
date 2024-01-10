//
//  MKCKDeviceInfoModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKDeviceInfoModel : NSObject

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *productMode;

@property (nonatomic, copy)NSString *manu;

@property (nonatomic, copy)NSString *hardware;

@property (nonatomic, copy)NSString *software;

@property (nonatomic, copy)NSString *firmware;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *imei;

@property (nonatomic, copy)NSString *iccid;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
