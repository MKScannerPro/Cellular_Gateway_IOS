//
//  MKCKScanReportModeModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/26.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKScanReportModeModel : NSObject

/*
 0:@"turn off scan",
 1:@"Real time scan & immediate report",
 2:@"real time scan & periodic report",
 3:@"periodic scan & immediate report",
 4:@"perodic scan & periodic report",
 */
@property (nonatomic, assign)NSInteger mode;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
