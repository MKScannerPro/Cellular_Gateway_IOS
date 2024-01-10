//
//  MKCKPeriodicScanReportModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/26.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKPeriodicScanReportModel : NSObject

@property (nonatomic, assign)NSString *scanDuration;

@property (nonatomic, assign)NSString *scanInterval;

@property (nonatomic, assign)NSString *reportInterval;

/// @"0":Next period  @"1":Current period
@property (nonatomic, assign)NSInteger priority;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
