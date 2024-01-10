//
//  MKCKOtherPayloadModel.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCKSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCKOtherBlockPayloadModel : NSObject<mk_ck_otherBlockPayloadProtocol>

/// 00-ff
@property (nonatomic, copy)NSString *dataType;

/// 1~29
@property (nonatomic, assign)NSInteger start;

/// 1~29
@property (nonatomic, assign)NSInteger end;

@end




@interface MKCKOtherPayloadModel : NSObject<mk_ck_otherPayloadProtocol>

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@property (nonatomic, strong)NSArray *dataList;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithList:(NSArray <MKCKOtherBlockPayloadModel *>*)list
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
