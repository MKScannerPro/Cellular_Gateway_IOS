//
//  MKCKScanBeaconCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKScanBeaconCellModel : NSObject

//RSSI@1m
@property (nonatomic, copy)NSString *rssi1M;
@property (nonatomic, copy)NSString *txPower;
//Advetising Interval
@property (nonatomic, copy) NSString *interval;

@property (nonatomic, copy)NSString *major;

@property (nonatomic, copy)NSString *minor;

@property (nonatomic, copy)NSString *uuid;

@end

@interface MKCKScanBeaconCell : MKBaseCell

@property (nonatomic, strong)MKCKScanBeaconCellModel *dataModel;

+ (MKCKScanBeaconCell *)initCellWithTableView:(UITableView *)tableView;

+ (CGFloat)getCellHeightWithUUID:(NSString *)uuid;

@end

NS_ASSUME_NONNULL_END
