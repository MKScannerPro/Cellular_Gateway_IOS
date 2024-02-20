//
//  MKCKFilterByTLMModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKFilterByTLMModel : NSObject

@property (nonatomic, assign)BOOL isOn;

/// 0:过滤非加密类型TLM 1:过滤加密类型TLM 2:过滤所有TLM  
@property (nonatomic, assign)NSInteger tlm;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
