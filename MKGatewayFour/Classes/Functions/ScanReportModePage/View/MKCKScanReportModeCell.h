//
//  MKCKScanReportModeCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/26.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKScanReportModeCellModel : NSObject

@property (nonatomic, assign)NSInteger mode;

@end

@protocol MKCKScanReportModeCellDelegate <NSObject>

- (void)ck_scanReportModeChanged:(NSInteger)mode;

@end

@interface MKCKScanReportModeCell : MKBaseCell

@property (nonatomic, weak)id <MKCKScanReportModeCellDelegate>delegate;

@property (nonatomic, strong)MKCKScanReportModeCellModel *dataModel;

+ (MKCKScanReportModeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
