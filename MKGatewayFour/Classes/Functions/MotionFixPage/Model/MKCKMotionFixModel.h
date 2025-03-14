//
//  MKCKMotionFixModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/4.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKMotionFixModel : NSObject

@property (nonatomic, assign)BOOL fixWhenStart;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, copy)NSString *fixInTripInterval;

@property (nonatomic, assign)BOOL fixWhenStop;

@property (nonatomic, copy)NSString *fixWhenStopTimeout;

@property (nonatomic, assign)BOOL fixInStationary;

@property (nonatomic, copy)NSString *fixInStationaryInterval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
