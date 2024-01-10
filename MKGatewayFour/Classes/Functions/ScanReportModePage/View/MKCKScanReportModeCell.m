//
//  MKCKScanReportModeCell.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/26.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKScanReportModeCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKCKScanReportModeCellModel
@end

@interface MKCKScanReportModeCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *rightButton;

@property (nonatomic, strong)NSArray *modeList;

@end

@implementation MKCKScanReportModeCell

+ (MKCKScanReportModeCell *)initCellWithTableView:(UITableView *)tableView {
    MKCKScanReportModeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCKScanReportModeCellIdenty"];
    if (!cell) {
        cell = [[MKCKScanReportModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCKScanReportModeCellIdenty"];
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
        make.width.mas_equalTo(120.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
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
    for (NSInteger i = 0; i < self.modeList.count; i ++) {
        if ([self.rightButton.titleLabel.text isEqualToString:self.modeList[i]]) {
            index = i;
            break;
        }
    }
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.modeList selectedRow:index block:^(NSInteger currentRow) {
        [self.rightButton setTitle:self.modeList[currentRow] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(ck_scanReportModeChanged:)]) {
            [self.delegate ck_scanReportModeChanged:currentRow];
        }
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCKScanReportModeCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKScanReportModeCellModel.class]) {
        return;
    }
    [self.rightButton setTitle:self.modeList[_dataModel.mode] forState:UIControlStateNormal];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Mode selection";
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

- (NSArray *)modeList {
    if (!_modeList) {
        _modeList = @[@"turn off scan",@"Real time scan&immediate report",@"real time scan&periodic report",@"periodic scan&immediate report",@"perodic scan&periodic report"];
    }
    return _modeList;
}

@end
