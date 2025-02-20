//
//  MKCKPayloadItemsV2Model.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/19.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKPayloadItemsV2Model : NSObject

@property (nonatomic, assign)BOOL beaconNumber;

@property (nonatomic, assign)BOOL sequenceNumber;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
