//
//  CBPeripheral+MKCKAdd.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKCKAdd.h"

#import <objc/runtime.h>

static const char *ck_manufacturerKey = "ck_manufacturerKey";
static const char *ck_deviceModelKey = "ck_deviceModelKey";
static const char *ck_hardwareKey = "ck_hardwareKey";
static const char *ck_softwareKey = "ck_softwareKey";
static const char *ck_firmwareKey = "ck_firmwareKey";

static const char *ck_passwordKey = "ck_passwordKey";
static const char *ck_disconnectTypeKey = "ck_disconnectTypeKey";
static const char *ck_customKey = "ck_customKey";
static const char *ck_logKey = "ck_logKey";

static const char *ck_passwordNotifySuccessKey = "ck_passwordNotifySuccessKey";
static const char *ck_disconnectTypeNotifySuccessKey = "ck_disconnectTypeNotifySuccessKey";
static const char *ck_customNotifySuccessKey = "ck_customNotifySuccessKey";

@implementation CBPeripheral (MKCKAdd)

- (void)ck_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &ck_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &ck_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &ck_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &ck_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &ck_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &ck_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &ck_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &ck_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &ck_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)ck_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &ck_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &ck_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &ck_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)ck_connectSuccess {
    if (![objc_getAssociatedObject(self, &ck_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ck_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ck_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.ck_manufacturer || !self.ck_deviceModel || !self.ck_hardware || !self.ck_software || !self.ck_firmware) {
        return NO;
    }
    if (!self.ck_password || !self.ck_disconnectType || !self.ck_custom || !self.ck_log) {
        return NO;
    }
    return YES;
}

- (void)ck_setNil {
    objc_setAssociatedObject(self, &ck_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ck_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ck_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ck_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)ck_manufacturer {
    return objc_getAssociatedObject(self, &ck_manufacturerKey);
}

- (CBCharacteristic *)ck_deviceModel {
    return objc_getAssociatedObject(self, &ck_deviceModelKey);
}

- (CBCharacteristic *)ck_hardware {
    return objc_getAssociatedObject(self, &ck_hardwareKey);
}

- (CBCharacteristic *)ck_software {
    return objc_getAssociatedObject(self, &ck_softwareKey);
}

- (CBCharacteristic *)ck_firmware {
    return objc_getAssociatedObject(self, &ck_firmwareKey);
}

- (CBCharacteristic *)ck_password {
    return objc_getAssociatedObject(self, &ck_passwordKey);
}

- (CBCharacteristic *)ck_disconnectType {
    return objc_getAssociatedObject(self, &ck_disconnectTypeKey);
}

- (CBCharacteristic *)ck_custom {
    return objc_getAssociatedObject(self, &ck_customKey);
}

- (CBCharacteristic *)ck_log {
    return objc_getAssociatedObject(self, &ck_logKey);
}

@end
