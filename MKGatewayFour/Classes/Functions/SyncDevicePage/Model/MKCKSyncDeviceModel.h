//
//  MKCKSyncDeviceModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/3/11.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKSyncDeviceModel : NSObject

@property (nonatomic, copy)NSString *subscribeTopic;

@property (nonatomic, copy)NSString *publishTopic;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
