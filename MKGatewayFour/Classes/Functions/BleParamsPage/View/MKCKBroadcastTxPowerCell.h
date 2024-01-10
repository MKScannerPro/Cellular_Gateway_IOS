//
//  MKCKBroadcastTxPowerCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKBroadcastTxPowerCellModel : NSObject

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
@property (nonatomic, assign)NSInteger txPowerValue;

@end

@protocol MKCKBroadcastTxPowerCellDelegate <NSObject>

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 */
- (void)ck_txPowerValueChanged:(NSInteger)txPower;

@end

@interface MKCKBroadcastTxPowerCell : MKBaseCell

@property (nonatomic, weak)id <MKCKBroadcastTxPowerCellDelegate>delegate;

@property (nonatomic, strong)MKCKBroadcastTxPowerCellModel *dataModel;

+ (MKCKBroadcastTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
