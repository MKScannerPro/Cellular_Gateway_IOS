//
//  MKCKButtonListCell.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/27.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKButtonListCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKCKButtonListCellModel
@end

@interface MKCKButtonListCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *rightButton;

@end

@implementation MKCKButtonListCell

+ (MKCKButtonListCell *)initCellWithTableView:(UITableView *)tableView {
    MKCKButtonListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCKButtonListCellIdenty"];
    if (!cell) {
        cell = [[MKCKButtonListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCKButtonListCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.rightButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(135.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(20.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(35.f);
    }];
}

#pragma mark - event method
- (void)rightButtonPressed {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataModel.dataList.count; i ++) {
        if ([self.rightButton.titleLabel.text isEqualToString:self.dataModel.dataList[i]]) {
            index = i;
            break;
        }
    }
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.dataModel.dataList selectedRow:index block:^(NSInteger currentRow) {
        [self.rightButton setTitle:self.dataModel.dataList[currentRow] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(ck_buttonListCellSelected:dataListIndex:)]) {
            [self.delegate ck_buttonListCellSelected:self.dataModel.index dataListIndex:currentRow];
        }
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCKButtonListCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKButtonListCellModel.class]) {
        return;
    }
    [self.rightButton setTitle:_dataModel.dataList[_dataModel.dataListIndex] forState:UIControlStateNormal];
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(13.f);
    }
    return _msgLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [MKCustomUIAdopter customButtonWithTitle:@""
                                                         target:self
                                                         action:@selector(rightButtonPressed)];
        _rightButton.titleLabel.font = MKFont(12.f);
    }
    return _rightButton;
}

@end
