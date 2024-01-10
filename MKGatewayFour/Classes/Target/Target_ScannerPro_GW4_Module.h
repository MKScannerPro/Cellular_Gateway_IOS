//
//  Target_ScannerPro_GW4_Module.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_ScannerPro_GW4_Module : NSObject

/// 扫描列表
/// @param params @{}
- (UIViewController *)Action_MKScannerPro_GW4_ScanPage:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
