//
//  MKCKSyncDeviceCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKSyncDeviceCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *subscribedTopic;

@property (nonatomic, copy)NSString *publishedTopic;

@end

@protocol MKCKSyncDeviceCellDelegate <NSObject>

- (void)ck_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKCKSyncDeviceCell : MKBaseCell

@property (nonatomic, strong)MKCKSyncDeviceCellModel *dataModel;

@property (nonatomic, weak)id <MKCKSyncDeviceCellDelegate>delegate;

+ (MKCKSyncDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
