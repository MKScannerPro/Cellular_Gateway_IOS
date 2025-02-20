//
//  MKCKRegionsBandsView.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/18.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKRegionsBandsView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@interface MKCKRegionsBandsSubView : UIControl

@property (nonatomic, strong)UIImageView *leftIcon;

@property (nonatomic, strong)UILabel *regionLabel;

@end

@implementation MKCKRegionsBandsSubView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftIcon];
        [self addSubview:self.regionLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(15.f);
    }];
    [self.regionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIcon.mas_right).mas_offset(2.f);
        make.right.mas_equalTo(-1.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - getter
- (UIImageView *)leftIcon {
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsSubView", @"ck_regionUnselectedIcon.png");
    }
    return _leftIcon;
}

- (UILabel *)regionLabel {
    if (!_regionLabel) {
        _regionLabel = [[UILabel alloc] init];
        _regionLabel.textAlignment = NSTextAlignmentLeft;
        _regionLabel.textColor = DEFAULT_TEXT_COLOR;
        _regionLabel.font = MKFont(13.f);
    }
    return _regionLabel;
}

@end

@interface MKCKRegionsBandsView ()

@property (nonatomic, strong)UILabel *regionLabel;

@property (nonatomic, strong)MKCKRegionsBandsSubView *usButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *europeButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *koreaButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *australiaButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *middleEstButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *japanButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *chinaButton;

@property (nonatomic, strong)MKCKRegionsBandsSubView *allButton;

@property (nonatomic, strong)NSMutableArray <MKCKRegionsBandsSubView *>*selectedBtnList;

@end

@implementation MKCKRegionsBandsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.regionLabel];
        [self addSubview:self.usButton];
        [self addSubview:self.europeButton];
        [self addSubview:self.koreaButton];
        [self addSubview:self.australiaButton];
        [self addSubview:self.middleEstButton];
        [self addSubview:self.japanButton];
        [self addSubview:self.chinaButton];
        [self addSubview:self.allButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.regionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    CGFloat buttonWidth = (kViewWidth - 2 * 15.f - 2 * 10.f) / 3;
    CGFloat buttonHeight = 30.f;
    [self.usButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(buttonWidth);
        make.top.mas_equalTo(self.regionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.europeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.usButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.koreaButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.usButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.australiaButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(buttonWidth);
        make.top.mas_equalTo(self.usButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.middleEstButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.australiaButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.japanButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.australiaButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.chinaButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(buttonWidth);
        make.top.mas_equalTo(self.australiaButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.allButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.chinaButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
}

#pragma mark - event method
- (void)regionBtnPressed:(MKCKRegionsBandsSubView *)btn {
    if (btn.isSelected) {
        //当前已经是选中状态
        if ([self.selectedBtnList containsObject:btn]) {
            [self.selectedBtnList removeObject:btn];
        }
        btn.selected = NO;
        [self updateBtnStates];
        return;
    }
    //当前是未选中状态
    btn.selected = YES;
    if (btn == self.allButton) {
        //用户选择了全部
        for (MKCKRegionsBandsSubView *btn in self.selectedBtnList) {
            btn.selected = NO;
        }
        [self.selectedBtnList removeAllObjects];
        [self.selectedBtnList addObject:btn];
        
        [self updateBtnStates];
        return;
    }
    //用户选择了全部之外的选项，则最多两个被选中
    if (self.allButton.selected) {
        self.allButton.selected = NO;
        if ([self.selectedBtnList containsObject:self.allButton]) {
            [self.selectedBtnList removeObject:self.allButton];
        }
    }
    if (self.selectedBtnList.count >= 2) {
        [self.selectedBtnList removeObjectAtIndex:0];
    }
    [self.selectedBtnList addObject:btn];
    [self updateBtnStates];
}

#pragma mark - setter
- (void)setRegionsBands:(NSInteger)regionsBands {
    _regionsBands = regionsBands;
    [self.selectedBtnList removeAllObjects];
    if (_regionsBands == 0x80) {
        self.allButton.selected = YES;
        [self.selectedBtnList addObject:self.allButton];
    }else {
        self.usButton.selected = (_regionsBands & (1 << 0)) != 0;
        if (self.usButton.selected) {
            [self.selectedBtnList addObject:self.usButton];
        }
        self.europeButton.selected = (_regionsBands & (1 << 1)) != 0;
        if (self.europeButton.selected) {
            [self.selectedBtnList addObject:self.europeButton];
        }
        self.koreaButton.selected = (_regionsBands & (1 << 2)) != 0;
        if (self.koreaButton.selected) {
            if (self.selectedBtnList.count >= 2) {
                [self.selectedBtnList removeObjectAtIndex:0];
            }
            [self.selectedBtnList addObject:self.koreaButton];
        }
        self.australiaButton.selected = (_regionsBands & (1 << 3)) != 0;
        if (self.australiaButton.selected) {
            if (self.selectedBtnList.count >= 2) {
                [self.selectedBtnList removeObjectAtIndex:0];
            }
            [self.selectedBtnList addObject:self.australiaButton];
        }
        self.middleEstButton.selected = (_regionsBands & (1 << 4)) != 0;
        if (self.middleEstButton.selected) {
            if (self.selectedBtnList.count >= 2) {
                [self.selectedBtnList removeObjectAtIndex:0];
            }
            [self.selectedBtnList addObject:self.middleEstButton];
        }
        self.japanButton.selected = (_regionsBands & (1 << 5)) != 0;
        if (self.japanButton.selected) {
            if (self.selectedBtnList.count >= 2) {
                [self.selectedBtnList removeObjectAtIndex:0];
            }
            [self.selectedBtnList addObject:self.japanButton];
        }
        self.chinaButton.selected = (_regionsBands & (1 << 6)) != 0;
        if (self.chinaButton.selected) {
            if (self.selectedBtnList.count >= 2) {
                [self.selectedBtnList removeObjectAtIndex:0];
            }
            [self.selectedBtnList addObject:self.chinaButton];
        }
    }
    [self updateBtnStates];
}

- (NSInteger)fetchCurrentRegion {
    NSInteger tempRegion = 0;
    // 根据选中的按钮更新 regionsBands
    for (MKCKRegionsBandsSubView *btn in self.selectedBtnList) {
        if (btn == self.allButton) {
            return 0x80;
        }
        if (btn == self.usButton) {
            tempRegion |= (1 << 0);
        }else if (btn == self.europeButton) {
            tempRegion |= (1 << 1);
        }else if (btn == self.koreaButton) {
            tempRegion |= (1 << 2);
        }else if (btn == self.australiaButton) {
            tempRegion |= (1 << 3);
        }else if (btn == self.middleEstButton) {
            tempRegion |= (1 << 4);
        }else if (btn == self.japanButton) {
            tempRegion |= (1 << 5);
        }else if (btn == self.chinaButton) {
            tempRegion |= (1 << 6);
        }
    }
    return tempRegion;
}

#pragma mark - private method
- (void)updateBtnStates {
    self.usButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.europeButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.koreaButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.australiaButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.middleEstButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.japanButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.chinaButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    self.allButton.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionUnselectedIcon.png");
    for (MKCKRegionsBandsSubView *btn in self.selectedBtnList) {
        btn.leftIcon.image = LOADICON(@"MKGatewayFour", @"MKCKRegionsBandsView", @"ck_regionSelectedIcon.png");
    }
}

#pragma mark - getter
- (UILabel *)regionLabel {
    if (!_regionLabel) {
        _regionLabel = [[UILabel alloc] init];
        _regionLabel.textColor = DEFAULT_TEXT_COLOR;
        _regionLabel.textAlignment = NSTextAlignmentLeft;
        _regionLabel.font = MKFont(15.f);
        _regionLabel.text = @"Regions & Bands";
    }
    return _regionLabel;
}

- (MKCKRegionsBandsSubView *)usButton {
    if (!_usButton) {
        _usButton = [[MKCKRegionsBandsSubView alloc] init];
        _usButton.regionLabel.text = @"US";
        [_usButton addTarget:self
                      action:@selector(regionBtnPressed:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _usButton;
}

- (MKCKRegionsBandsSubView *)europeButton {
    if (!_europeButton) {
        _europeButton = [[MKCKRegionsBandsSubView alloc] init];
        _europeButton.regionLabel.text = @"Europe";
        [_europeButton addTarget:self
                          action:@selector(regionBtnPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _europeButton;
}

- (MKCKRegionsBandsSubView *)koreaButton {
    if (!_koreaButton) {
        _koreaButton = [[MKCKRegionsBandsSubView alloc] init];
        _koreaButton.regionLabel.text = @"Korea";
        [_koreaButton addTarget:self
                         action:@selector(regionBtnPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _koreaButton;
}

- (MKCKRegionsBandsSubView *)australiaButton {
    if (!_australiaButton) {
        _australiaButton = [[MKCKRegionsBandsSubView alloc] init];
        _australiaButton.regionLabel.text = @"Australia";
        [_australiaButton addTarget:self
                             action:@selector(regionBtnPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return _australiaButton;
}

- (MKCKRegionsBandsSubView *)middleEstButton {
    if (!_middleEstButton) {
        _middleEstButton = [[MKCKRegionsBandsSubView alloc] init];
        _middleEstButton.regionLabel.text = @"The Middle Est";
        [_middleEstButton addTarget:self
                             action:@selector(regionBtnPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleEstButton;
}

- (MKCKRegionsBandsSubView *)japanButton {
    if (!_japanButton) {
        _japanButton = [[MKCKRegionsBandsSubView alloc] init];
        _japanButton.regionLabel.text = @"Japan";
        [_japanButton addTarget:self
                         action:@selector(regionBtnPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _japanButton;
}

- (MKCKRegionsBandsSubView *)chinaButton {
    if (!_chinaButton) {
        _chinaButton = [[MKCKRegionsBandsSubView alloc] init];
        _chinaButton.regionLabel.text = @"China";
        [_chinaButton addTarget:self
                         action:@selector(regionBtnPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _chinaButton;
}

- (MKCKRegionsBandsSubView *)allButton {
    if (!_allButton) {
        _allButton = [[MKCKRegionsBandsSubView alloc] init];
        _allButton.regionLabel.text = @"All of them";
        [_allButton addTarget:self
                       action:@selector(regionBtnPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

- (NSMutableArray<MKCKRegionsBandsSubView *> *)selectedBtnList {
    if (!_selectedBtnList) {
        _selectedBtnList = [NSMutableArray array];
    }
    return _selectedBtnList;
}

@end
