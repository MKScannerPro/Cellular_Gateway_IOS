//
//  MKCKOtherTypePayloadHeaderView.h
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/4.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCKOtherTypePayloadHeaderViewDelegate <NSObject>

- (void)ck_addBlockOptions;

@end

@interface MKCKOtherTypePayloadHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign)id <MKCKOtherTypePayloadHeaderViewDelegate>delegate;

+ (MKCKOtherTypePayloadHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
