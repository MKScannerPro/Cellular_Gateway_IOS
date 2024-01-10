//
//  MKCKButtonListCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKButtonListCellModel : NSObject

/// 当前cell所在的index
@property (nonatomic, assign)NSInteger index;

/// 左侧显示的msg
@property (nonatomic, copy)NSString *msg;

/// 点击右侧按钮时显示的pickView列表数据源
@property (nonatomic, strong)NSArray *dataList;

/// 当前数据源dataList选中的index,右侧按钮会显示dataList[dataListIndex]
@property (nonatomic, assign)NSInteger dataListIndex;

@end

@protocol MKCKButtonListCellDelegate <NSObject>

/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
- (void)ck_buttonListCellSelected:(NSInteger)index
                    dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKCKButtonListCell : MKBaseCell

@property (nonatomic, weak)id <MKCKButtonListCellDelegate>delegate;

@property (nonatomic, strong)MKCKButtonListCellModel *dataModel;

+ (MKCKButtonListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
