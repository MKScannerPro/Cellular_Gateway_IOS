//
//  MKCKDebuggerCell.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/9.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKCKDebuggerCellDelegate <NSObject>

- (void)ck_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKCKDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKCKDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKCKDebuggerCellDelegate>delegate;

+ (MKCKDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
