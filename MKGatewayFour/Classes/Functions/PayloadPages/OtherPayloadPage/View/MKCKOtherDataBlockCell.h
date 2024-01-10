//
//  MKCKOtherDataBlockCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/29.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKOtherDataBlockCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *dataType;

@property (nonatomic, copy)NSString *start;

@property (nonatomic, copy)NSString *end;

@end

@protocol MKCKOtherDataBlockCellDelegate <NSObject>

/// 输入框内容改变
/// - Parameters:
///   - index: cell所在index
///   - textID: 0:data type  1:start   2:end
///   - text: 当前输入框内容
- (void)ck_otherDataBlockCell_textFieldChanged:(NSInteger)index textID:(NSInteger)textID text:(NSString *)text;

- (void)ck_otherDataBlockCell_delete:(NSInteger)index;

@end

@interface MKCKOtherDataBlockCell : MKBaseCell

@property (nonatomic, strong)MKCKOtherDataBlockCellModel *dataModel;

@property (nonatomic, weak)id <MKCKOtherDataBlockCellDelegate>delegate;

+ (MKCKOtherDataBlockCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
