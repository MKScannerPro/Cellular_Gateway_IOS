//
//  MKCKFilterByBXPButtonModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKFilterByBXPButtonModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL singlePress;

@property (nonatomic, assign)BOOL doublePress;

@property (nonatomic, assign)BOOL longPress;

@property (nonatomic, assign)BOOL abnormal;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
