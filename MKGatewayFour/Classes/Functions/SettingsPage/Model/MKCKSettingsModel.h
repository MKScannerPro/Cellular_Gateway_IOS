//
//  MKCKSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/24.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKSettingsModel : NSObject

@property (nonatomic, copy)NSString *battery;

@property (nonatomic, assign)BOOL powerLoss;

/// 0:Every time    1:When battery dead
@property (nonatomic, assign)NSInteger powerOnWhenCharging;

/// V1.0.4
@property (nonatomic, copy)NSString *offlineDataCount;

/// V1.0.4
@property (nonatomic, assign)NSInteger powerOnByMagnet;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
