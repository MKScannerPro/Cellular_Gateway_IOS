//
//  MKCKAxisSettingsModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/6.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKAxisSettingsModel : NSObject

@property (nonatomic, copy)NSString *wakeupThreshold;

@property (nonatomic, copy)NSString *wakeupDuration;

@property (nonatomic, copy)NSString *motionThreshold;

@property (nonatomic, copy)NSString *motionDuration;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
