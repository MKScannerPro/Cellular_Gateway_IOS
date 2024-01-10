//
//  MKCKScanInfoCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKCKScanInfoCellModel : NSObject

/**
 当前model所在的row
 */
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)NSInteger rssi;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

/// 是否可连接
@property (nonatomic, assign)BOOL connectable;

@property (nonatomic, copy)NSString *deviceType;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, assign)BOOL needPassword;

@end

@protocol MKCKScanInfoCellDelegate <NSObject>

- (void)ck_connectButtonPressed:(NSInteger)index;

@end

@interface MKCKScanInfoCell : MKBaseCell

@property (nonatomic, strong)MKCKScanInfoCellModel *dataModel;

@property (nonatomic, weak)id <MKCKScanInfoCellDelegate>delegate;

+ (MKCKScanInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
