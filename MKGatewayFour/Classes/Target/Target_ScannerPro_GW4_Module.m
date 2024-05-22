//
//  Target_ScannerPro_GW4_Module.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_GW4_Module.h"

#import "MKCKScanController.h"


@implementation Target_ScannerPro_GW4_Module

- (UIViewController *)Action_MKScannerPro_GW4_ScanPage:(NSDictionary *)params {
    return [[MKCKScanController alloc] init];
}

@end
