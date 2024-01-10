//
//  MKCKGpsFixModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/6.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKGpsFixModel : NSObject

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, copy)NSString *pdop;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
