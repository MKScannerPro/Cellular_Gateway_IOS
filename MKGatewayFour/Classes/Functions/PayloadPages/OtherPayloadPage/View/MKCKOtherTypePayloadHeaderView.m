//
//  MKCKOtherTypePayloadHeaderView.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/4.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCKOtherTypePayloadHeaderView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@interface MKCKOtherTypePayloadHeaderView ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *addButton;

@end

@implementation MKCKOtherTypePayloadHeaderView

+ (MKCKOtherTypePayloadHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView {
    MKCKOtherTypePayloadHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MKCKOtherTypePayloadHeaderViewIdenty"];
    if (!headerView) {
        headerView = [[MKCKOtherTypePayloadHeaderView alloc] initWithReuseIdentifier:@"MKCKOtherTypePayloadHeaderViewIdenty"];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.addButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.addButton.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)addButtonPressed {
    if ([self.delegate respondsToSelector:@selector(ck_addBlockOptions)]) {
        [self.delegate ck_addBlockOptions];
    }
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.font = MKFont(14.f);
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.text = @"Data block options";
    }
    return _msgLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:LOADICON(@"MKGatewayFour", @"MKCKOtherTypePayloadHeaderView", @"ck_addIcon.png") forState:UIControlStateNormal];
        [_addButton addTarget:self
                       action:@selector(addButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
