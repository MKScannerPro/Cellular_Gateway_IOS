//
//  MKCKOtherDataBlockCell.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/29.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKOtherDataBlockCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKTextField.h"
#import "MKCustomUIAdopter.h"

@implementation MKCKOtherDataBlockCellModel
@end

@interface MKCKOtherDataBlockCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *dataTypeField;

@property (nonatomic, strong)MKTextField *startField;

@property (nonatomic, strong)UILabel *centerLine;

@property (nonatomic, strong)MKTextField *endField;

@property (nonatomic, strong)UILabel *byteLabel;

@property (nonatomic, strong)UIButton *deleteButton;

@end

@implementation MKCKOtherDataBlockCell

+ (MKCKOtherDataBlockCell *)initCellWithTableView:(UITableView *)tableView {
    MKCKOtherDataBlockCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCKOtherDataBlockCellIdenty"];
    if (!cell) {
        cell = [[MKCKOtherDataBlockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCKOtherDataBlockCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.dataTypeField];
        [self.contentView addSubview:self.startField];
        [self.contentView addSubview:self.centerLine];
        [self.contentView addSubview:self.endField];
        [self.contentView addSubview:self.byteLabel];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(85.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.dataTypeField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.startField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dataTypeField.mas_right).mas_offset(15.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.centerLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startField.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.endField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.centerLine.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.byteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.endField.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(50.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)deleteButtonPressed {
    if ([self.delegate respondsToSelector:@selector(ck_otherDataBlockCell_delete:)]) {
        [self.delegate ck_otherDataBlockCell_delete:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKCKOtherDataBlockCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKOtherDataBlockCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.dataTypeField.text = SafeStr(_dataModel.dataType);
    self.startField.text = SafeStr(_dataModel.start);
    self.endField.text = SafeStr(_dataModel.end);
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

- (MKTextField *)dataTypeField {
    if (!_dataTypeField) {
        _dataTypeField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                              placeHolder:@"Data type"
                                                                 textType:mk_hexCharOnly];
        _dataTypeField.font = MKFont(12.f);
        _dataTypeField.maxLength = 2;
        @weakify(self);
        _dataTypeField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(ck_otherDataBlockCell_textFieldChanged:textID:text:)]) {
                [self.delegate ck_otherDataBlockCell_textFieldChanged:self.dataModel.index textID:0 text:text];
            }
        };
    }
    return _dataTypeField;
}

- (MKTextField *)startField {
    if (!_startField) {
        _startField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                           placeHolder:@"1~29"
                                                              textType:mk_realNumberOnly];
        _startField.font = MKFont(12.f);
        _startField.maxLength = 2;
        @weakify(self);
        _startField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(ck_otherDataBlockCell_textFieldChanged:textID:text:)]) {
                [self.delegate ck_otherDataBlockCell_textFieldChanged:self.dataModel.index textID:1 text:text];
            }
        };
    }
    return _startField;
}

- (UILabel *)centerLine {
    if (!_centerLine) {
        _centerLine = [[UILabel alloc] init];
        _centerLine.textColor = DEFAULT_TEXT_COLOR;
        _centerLine.textAlignment = NSTextAlignmentCenter;
        _centerLine.font = MKFont(12.f);
        _centerLine.text = @"~";
    }
    return _centerLine;
}

- (MKTextField *)endField {
    if (!_endField) {
        _endField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                         placeHolder:@"1~29"
                                                            textType:mk_realNumberOnly];
        _endField.font = MKFont(12.f);
        _endField.maxLength = 2;
        @weakify(self);
        _endField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(ck_otherDataBlockCell_textFieldChanged:textID:text:)]) {
                [self.delegate ck_otherDataBlockCell_textFieldChanged:self.dataModel.index textID:2 text:text];
            }
        };
    }
    return _endField;
}

- (UILabel *)byteLabel {
    if (!_byteLabel) {
        _byteLabel = [[UILabel alloc] init];
        _byteLabel.textColor = DEFAULT_TEXT_COLOR;
        _byteLabel.textAlignment = NSTextAlignmentCenter;
        _byteLabel.font = MKFont(13.f);
        _byteLabel.text = @"Byte";
    }
    return _byteLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:LOADICON(@"MKGatewayFour", @"MKCKOtherDataBlockCell", @"ck_subIcon.png") forState:UIControlStateNormal];
        [_deleteButton addTarget:self
                          action:@selector(deleteButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
