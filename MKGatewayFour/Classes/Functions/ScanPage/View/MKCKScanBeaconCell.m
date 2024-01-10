//
//  MKCKScanBeaconCell.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/23.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKScanBeaconCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#define msgFont MKFont(12.f)

@implementation MKCKScanBeaconCellModel
@end

@interface MKCKScanBeaconCell ()

@property (nonatomic, strong)UILabel *uuidLabel;

@property (nonatomic, strong)UILabel *uuidIDLabel;

@property (nonatomic, strong)UILabel *majorLabel;

@property (nonatomic, strong)UILabel *majorIDLabel;

@property (nonatomic, strong)UILabel *minorLabel;

@property (nonatomic, strong)UILabel *minorIDLabel;

/**
 RSSI@1m
 */
@property (nonatomic, strong)UILabel *rssiLabel;

@property (nonatomic, strong)UILabel *rssiValueLabel;

@property (nonatomic, strong)UILabel *txPowerLabel;

@property (nonatomic, strong)UILabel *txPowerValueLabel;

@end

@implementation MKCKScanBeaconCell

+ (MKCKScanBeaconCell *)initCellWithTableView:(UITableView *)tableView {
    MKCKScanBeaconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCKScanBeaconCellIdenty"];
    if (!cell) {
        cell = [[MKCKScanBeaconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCKScanBeaconCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.uuidLabel];
        [self.contentView addSubview:self.uuidIDLabel];
        [self.contentView addSubview:self.majorLabel];
        [self.contentView addSubview:self.majorIDLabel];
        [self.contentView addSubview:self.minorLabel];
        [self.contentView addSubview:self.minorIDLabel];
        [self.contentView addSubview:self.rssiLabel];
        [self.contentView addSubview:self.rssiValueLabel];
        [self.contentView addSubview:self.txPowerLabel];
        [self.contentView addSubview:self.txPowerValueLabel];
    }
    return self;
}

#pragma mark - 父类方法
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat uuidWidth = 100.f;
    [self.uuidLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(uuidWidth);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    CGSize uuidIDSize = [NSString sizeWithText:self.uuidIDLabel.text
                                       andFont:self.uuidIDLabel.font
                                    andMaxSize:CGSizeMake(self.contentView.frame.size.width - 3 * 15.f - uuidWidth, MAXFLOAT)];
    [self.uuidIDLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.uuidLabel.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.uuidLabel.mas_top);
        make.height.mas_equalTo(uuidIDSize.height);
    }];
    
    [self.majorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.uuidLabel.mas_left);
        make.width.mas_equalTo(self.uuidLabel.mas_width);
        make.top.mas_equalTo(self.uuidIDLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    [self.majorIDLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.majorLabel.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.majorLabel.mas_centerY);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    
    [self.minorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.uuidLabel.mas_left);
        make.width.mas_equalTo(self.uuidLabel.mas_width);
        make.top.mas_equalTo(self.majorLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    [self.minorIDLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minorLabel.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.minorLabel.mas_centerY);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    
    [self.rssiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.uuidLabel.mas_left);
        make.width.mas_equalTo(self.uuidLabel.mas_width);
        make.top.mas_equalTo(self.minorLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    [self.rssiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rssiLabel.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.rssiLabel.mas_centerY);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    
    [self.txPowerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.uuidLabel.mas_left);
        make.width.mas_equalTo(self.uuidLabel.mas_width);
        make.top.mas_equalTo(self.rssiLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
    [self.txPowerValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.txPowerLabel.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.txPowerLabel.mas_centerY);
        make.height.mas_equalTo(msgFont.lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCKScanBeaconCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKScanBeaconCellModel.class]) {
        return;
    }
    self.uuidIDLabel.text = SafeStr(_dataModel.uuid);
    self.majorIDLabel.text = SafeStr(_dataModel.major);
    self.minorIDLabel.text = SafeStr(_dataModel.minor);
    self.rssiValueLabel.text = [NSString stringWithFormat:@"%@%@",SafeStr(_dataModel.rssi1M),@"dBm"];
    self.txPowerValueLabel.text = [NSString stringWithFormat:@"%@%@",SafeStr(_dataModel.txPower),@"dBm"];
    [self setNeedsLayout];
}

#pragma mark - public method

+ (CGFloat)getCellHeightWithUUID:(NSString *)uuid {
    CGSize uuidIDSize = [NSString sizeWithText:uuid
                                       andFont:MKFont(16.f)
                                    andMaxSize:CGSizeMake(kViewWidth - 3 * 15.f - 100.f, MAXFLOAT)];
    return 70.f + uuidIDSize.height;
}

#pragma mark - getter
- (UILabel *)uuidLabel{
    if (!_uuidLabel) {
        _uuidLabel = [self createLabelWithFont:msgFont];
        _uuidLabel.text = @"UUID";
    }
    return _uuidLabel;
}

- (UILabel *)uuidIDLabel{
    if (!_uuidIDLabel) {
        _uuidIDLabel = [self createLabelWithFont:msgFont];
        _uuidIDLabel.numberOfLines = 0;
    }
    return _uuidIDLabel;
}

- (UILabel *)majorLabel{
    if (!_majorLabel) {
        _majorLabel = [self createLabelWithFont:msgFont];
        _majorLabel.text = @"Major";
    }
    return _majorLabel;
}

- (UILabel *)majorIDLabel{
    if (!_majorIDLabel) {
        _majorIDLabel = [self createLabelWithFont:msgFont];
    }
    return _majorIDLabel;
}

- (UILabel *)minorLabel{
    if (!_minorLabel) {
        _minorLabel = [self createLabelWithFont:msgFont];
        _minorLabel.text = @"Minor";
    }
    return _minorLabel;
}

- (UILabel *)minorIDLabel{
    if (!_minorIDLabel) {
        _minorIDLabel = [self createLabelWithFont:msgFont];
    }
    return _minorIDLabel;
}

- (UILabel *)rssiLabel{
    if (!_rssiLabel) {
        _rssiLabel = [self createLabelWithFont:msgFont];
        _rssiLabel.text = @"RSSI@1m";
    }
    return _rssiLabel;
}

- (UILabel *)rssiValueLabel {
    if (!_rssiValueLabel) {
        _rssiValueLabel = [self  createLabelWithFont:msgFont];
    }
    return _rssiValueLabel;
}

- (UILabel *)txPowerLabel{
    if (!_txPowerLabel) {
        _txPowerLabel = [self createLabelWithFont:msgFont];
        _txPowerLabel.text = @"Tx power";
    }
    return _txPowerLabel;
}

- (UILabel *)txPowerValueLabel {
    if (!_txPowerValueLabel) {
        _txPowerValueLabel = [self createLabelWithFont:msgFont];
    }
    return _txPowerValueLabel;
}

#pragma mark - Private method

- (UILabel *)createLabelWithFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = RGBCOLOR(184, 184, 184);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = font;
    return label;
}

@end
