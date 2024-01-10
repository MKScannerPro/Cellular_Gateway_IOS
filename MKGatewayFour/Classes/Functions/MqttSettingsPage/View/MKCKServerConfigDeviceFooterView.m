//
//  MKCKServerConfigDeviceFooterView.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKCKServerConfigDeviceFooterView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKTextField.h"

#import "MKMQTTGeneralParamsView.h"

#import "MKCKMQTTSSLForDeviceView.h"
#import "MKCKServerConfigDeviceSettingView.h"


@interface MKCKMQTTUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@implementation MKCKMQTTUserCredentialsViewModel
@end

@protocol MKCKMQTTUserCredentialsViewDelegate <NSObject>

- (void)mk_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)mk_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKCKMQTTUserCredentialsView : UIView

@property (nonatomic, strong)MKCKMQTTUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKCKMQTTUserCredentialsViewDelegate>delegate;

@end



@interface MKCKMQTTUserCredentialsView ()

@property (nonatomic, strong)UILabel *userNameLabel;

@property (nonatomic, strong)MKTextField *userNameTextField;

@property (nonatomic, strong)UILabel *passwordLabel;

@property(nonatomic, strong)MKTextField *passwordTextField;

@end

@implementation MKCKMQTTUserCredentialsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.userNameLabel];
        [self addSubview:self.userNameTextField];
        [self addSubview:self.passwordLabel];
        [self addSubview:self.passwordTextField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(120.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(35.f);
    }];
    [self.userNameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.userNameLabel.mas_centerY);
        make.height.mas_equalTo(self.userNameLabel.mas_height);
    }];
    [self.passwordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(120.f);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(35.f);
    }];
    [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.passwordLabel.mas_centerY);
        make.height.mas_equalTo(self.passwordLabel.mas_height);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCKMQTTUserCredentialsViewModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKMQTTUserCredentialsViewModel.class]) {
        return;
    }
    self.userNameTextField.text = _dataModel.userName;
    self.passwordTextField.text = _dataModel.password;
}

#pragma mark - getter
- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = DEFAULT_TEXT_COLOR;
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = MKFont(14.f);
        _userNameLabel.text = @"Username";
    }
    return _userNameLabel;
}

- (UILabel *)passwordLabel {
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc] init];
        _passwordLabel.textColor = DEFAULT_TEXT_COLOR;
        _passwordLabel.textAlignment = NSTextAlignmentLeft;
        _passwordLabel.font = MKFont(14.f);
        _passwordLabel.text = @"Password";
    }
    return _passwordLabel;
}

- (MKTextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [[MKTextField alloc] initWithTextFieldType:mk_normal];
        @weakify(self);
        _userNameTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(mk_mqtt_userCredentials_userNameChanged:)]) {
                [self.delegate mk_mqtt_userCredentials_userNameChanged:text];
            }
        };
        _userNameTextField.maxLength = 256;
        _userNameTextField.placeholder = @"0-256 Characters";
        _userNameTextField.borderStyle = UITextBorderStyleNone;
        _userNameTextField.font = MKFont(13.f);
        _userNameTextField.textColor = DEFAULT_TEXT_COLOR;
        
        _userNameTextField.backgroundColor = COLOR_WHITE_MACROS;
        _userNameTextField.layer.masksToBounds = YES;
        _userNameTextField.layer.borderWidth = CUTTING_LINE_HEIGHT;
        _userNameTextField.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        _userNameTextField.layer.cornerRadius = 6.f;
    }
    return _userNameTextField;
}

- (MKTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[MKTextField alloc] initWithTextFieldType:mk_normal];
        @weakify(self);
        _passwordTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(mk_mqtt_userCredentials_passwordChanged:)]) {
                [self.delegate mk_mqtt_userCredentials_passwordChanged:text];
            }
        };
        _passwordTextField.maxLength = 256;
        _passwordTextField.placeholder = @"0-256 Characters";
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.font = MKFont(13.f);
        _passwordTextField.textColor = DEFAULT_TEXT_COLOR;
        
        _passwordTextField.backgroundColor = COLOR_WHITE_MACROS;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.borderWidth = CUTTING_LINE_HEIGHT;
        _passwordTextField.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        _passwordTextField.layer.cornerRadius = 6.f;
    }
    return _passwordTextField;
}

@end






@implementation MKCKServerConfigDeviceFooterViewModel
@end

static CGFloat const buttonHeight = 30.f;
static CGFloat const settingViewHeight = 130.f;
static CGFloat const defaultScrollViewHeight = 450.f;

@interface MKCKServerConfigDeviceFooterView ()<UIScrollViewDelegate,
MKMQTTGeneralParamsViewDelegate,
MKCKMQTTUserCredentialsViewDelegate,
MKCKMQTTSSLForDeviceViewDelegate,
MKCKServerConfigDeviceSettingViewDelegate>

@property (nonatomic, strong)UIView *topLineView;

@property (nonatomic, strong)UIButton *generalButton;

@property (nonatomic, strong)UIButton *credentialsButton;

@property (nonatomic, strong)UIButton *sslButton;

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIView *containerView;

@property (nonatomic, strong)MKMQTTGeneralParamsView *generalView;

@property (nonatomic, strong)MKCKMQTTUserCredentialsView *credentialsView;

@property (nonatomic, strong)MKCKMQTTSSLForDeviceView *sslView;

@property (nonatomic, strong)MKCKServerConfigDeviceSettingView *settingView;

@property (nonatomic, assign)NSInteger index;

@end

@implementation MKCKServerConfigDeviceFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40.f);
    }];
    CGFloat buttonWidth = (self.frame.size.width - 4 * 10.f) / 3;
    [self.generalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.topLineView.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.credentialsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.generalButton.mas_right).mas_offset(10.f);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.generalButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.sslButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.credentialsButton.mas_right).mas_offset(10.f);
        make.width.mas_equalTo(buttonWidth);
        make.centerY.mas_equalTo(self.generalButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topLineView.mas_bottom).mas_offset(10.f);
        make.bottom.mas_equalTo(self.settingView.mas_top);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(self.scrollView);       //水平滚动高度固定
    }];
    [self.generalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.containerView);
        make.width.equalTo(self.scrollView);
        make.left.mas_equalTo(0);
    }];
    [self.credentialsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.containerView);
        make.width.equalTo(self.scrollView);
        make.left.mas_equalTo(self.generalView.mas_right);
    }];
    [self.sslView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.containerView);
        make.width.equalTo(self.scrollView);
        make.left.mas_equalTo(self.credentialsView.mas_right);
    }];
    
    // 设置过渡视图的右距（此设置将影响到scrollView的contentSize）这个也是关键的一步
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sslView.mas_right);
    }];
    [self.settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(settingViewHeight);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.index = scrollView.contentOffset.x / kViewWidth;
    [self loadButtonUI];
}

#pragma mark - MKMQTTGeneralParamsViewDelegate
- (void)mk_mqtt_generalParams_cleanSessionStatusChanged:(BOOL)isOn {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_switchStatusChanged:statusID:)]) {
        [self.delegate ck_mqtt_serverForDevice_switchStatusChanged:isOn statusID:0];
    }
}

- (void)mk_mqtt_generalParams_qosChanged:(NSInteger)qos {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_qosChanged:qosID:)]) {
        [self.delegate ck_mqtt_serverForDevice_qosChanged:qos qosID:0];
    }
}

- (void)mk_mqtt_generalParams_KeepAliveChanged:(NSString *)keepAlive {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_textFieldValueChanged:textID:)]) {
        [self.delegate ck_mqtt_serverForDevice_textFieldValueChanged:keepAlive textID:0];
    }
}

#pragma mark - MKCKMQTTUserCredentialsViewDelegate
- (void)mk_mqtt_userCredentials_userNameChanged:(NSString *)userName {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_textFieldValueChanged:textID:)]) {
        [self.delegate ck_mqtt_serverForDevice_textFieldValueChanged:userName textID:1];
    }
}

- (void)mk_mqtt_userCredentials_passwordChanged:(NSString *)password {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_textFieldValueChanged:textID:)]) {
        [self.delegate ck_mqtt_serverForDevice_textFieldValueChanged:password textID:2];
    }
}

#pragma mark - MKCKMQTTSSLForDeviceViewDelegate
- (void)ck_mqtt_sslParams_device_sslStatusChanged:(BOOL)isOn {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_switchStatusChanged:statusID:)]) {
        [self.delegate ck_mqtt_serverForDevice_switchStatusChanged:isOn statusID:1];
    }
}

/// 用户选择了加密方式
/// @param certificate 0:CA certificate     1:Self signed certificates
- (void)ck_mqtt_sslParams_device_certificateChanged:(NSInteger)certificate {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_certificateChanged:)]) {
        [self.delegate ck_mqtt_serverForDevice_certificateChanged:certificate];
    }
}

/// 用户点击选择了caFaile按钮
- (void)ck_mqtt_sslParams_device_caFilePressed {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_fileButtonPressed:)]) {
        [self.delegate ck_mqtt_serverForDevice_fileButtonPressed:0];
    }
}

/// 用户点击选择了Client Key按钮
- (void)ck_mqtt_sslParams_device_clientKeyPressed {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_fileButtonPressed:)]) {
        [self.delegate ck_mqtt_serverForDevice_fileButtonPressed:1];
    }
}

/// 用户点击了Client Cert File按钮
- (void)ck_mqtt_sslParams_device_clientCertPressed {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_fileButtonPressed:)]) {
        [self.delegate ck_mqtt_serverForDevice_fileButtonPressed:2];
    }
}

#pragma mark - MKCKServerConfigDeviceSettingViewDelegate

/// 底部按钮
/// @param index 0:Export Demo File   1:Import Config File
- (void)ck_mqtt_deviecSetting_fileButtonPressed:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(ck_mqtt_serverForDevice_bottomButtonPressed:)]) {
        [self.delegate ck_mqtt_serverForDevice_bottomButtonPressed:index];
    }
}

#pragma mark - event method
- (void)generalButtonPressed {
    if (self.index == 0) {
        return;
    }
    self.index = 0;
    [self loadButtonUI];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)credentialsButtonPressed {
    if (self.index == 1) {
        return;
    }
    self.index = 1;
    [self loadButtonUI];
    [self.scrollView setContentOffset:CGPointMake(kViewWidth, 0) animated:YES];
}

- (void)sslButtonPressed {
    if (self.index == 2) {
        return;
    }
    self.index = 2;
    [self loadButtonUI];
    [self.scrollView setContentOffset:CGPointMake(2 * kViewWidth, 0) animated:YES];
}

#pragma mark - public method
- (CGFloat)fetchHeightWithSSLStatus:(BOOL)isOn
                         CAFileName:(NSString *)caFile
                      clientKeyName:(NSString *)clientKeyName
                     clientCertName:(NSString *)clientCertName
                        certificate:(NSInteger)certificate {
    if (!isOn || certificate == 0) {
        //ssl关闭或者不需要证书
        return defaultScrollViewHeight + settingViewHeight;
    }
    CGSize caSize = [NSString sizeWithText:caFile
                                   andFont:MKFont(13.f)
                                andMaxSize:CGSizeMake(self.frame.size.width - 2 * 15.f - 120.f -  2 * 10.f - 40.f, MAXFLOAT)];
    if (certificate == 1) {
        //CA 证书
        return defaultScrollViewHeight + settingViewHeight + caSize.height;
    }
    if (certificate == 2) {
        //CA证书和client key证书、client cert证书
        CGSize clientKeySize = [NSString sizeWithText:clientKeyName
                                              andFont:MKFont(13.f)
                                           andMaxSize:CGSizeMake(self.frame.size.width - 2 * 15.f - 120.f -  2 * 10.f - 40.f, MAXFLOAT)];
        CGSize clientCertSize = [NSString sizeWithText:clientCertName
                                               andFont:MKFont(13.f)
                                            andMaxSize:CGSizeMake(self.frame.size.width - 2 * 15.f - 120.f -  2 * 10.f - 40.f, MAXFLOAT)];
        return defaultScrollViewHeight + settingViewHeight + caSize.height + clientKeySize.height + clientCertSize.height;
    }
    return defaultScrollViewHeight + settingViewHeight;
}

#pragma mark - setter
- (void)setDataModel:(MKCKServerConfigDeviceFooterViewModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCKServerConfigDeviceFooterViewModel.class]) {
        return;
    }
    MKMQTTGeneralParamsViewModel *generalModel = [[MKMQTTGeneralParamsViewModel alloc] init];
    generalModel.clean = _dataModel.cleanSession;
    generalModel.qos = _dataModel.qos;
    generalModel.keepAlive = _dataModel.keepAlive;
    self.generalView.dataModel = generalModel;
    
    MKCKMQTTUserCredentialsViewModel *credentialsViewModel = [[MKCKMQTTUserCredentialsViewModel alloc] init];
    credentialsViewModel.userName = _dataModel.userName;
    credentialsViewModel.password = _dataModel.password;
    self.credentialsView.dataModel = credentialsViewModel;
    
    MKCKMQTTSSLForDeviceViewModel *sslModel = [[MKCKMQTTSSLForDeviceViewModel alloc] init];
    sslModel.sslIsOn = _dataModel.sslIsOn;
    sslModel.certificate = _dataModel.certificate;
    sslModel.caFileName = _dataModel.caFileName;
    sslModel.clientKeyName = _dataModel.clientKeyName;
    sslModel.clientCertName = _dataModel.clientCertName;
    self.sslView.dataModel = sslModel;
    
    [self loadSubViews];
    [self setNeedsLayout];
}

#pragma mark - private method
- (void)loadButtonUI {
    if (self.index == 0) {
        [self.generalButton setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
        [self.credentialsButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        [self.sslButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        return;
    }
    if (self.index == 1) {
        [self.generalButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        [self.credentialsButton setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
        [self.sslButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        return;
    }
    if (self.index == 2) {
        [self.generalButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        [self.credentialsButton setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
        [self.sslButton setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
        return;
    }
}

- (void)loadSubViews {
    if (self.topLineView.superview) {
        [self.topLineView removeFromSuperview];
    }
    if (self.generalButton.superview) {
        [self.generalButton removeFromSuperview];
    }
    if (self.credentialsButton.superview) {
        [self.credentialsButton removeFromSuperview];
    }
    if (self.sslButton.superview) {
        [self.sslButton removeFromSuperview];
    }
    if (self.scrollView.superview) {
        [self.scrollView removeFromSuperview];
    }
    if (self.containerView.superview) {
        [self.containerView removeFromSuperview];
    }
    if (self.generalView.superview) {
        [self.generalView removeFromSuperview];
    }
    if (self.credentialsView.superview) {
        [self.credentialsView removeFromSuperview];
    }
    if (self.sslView.superview) {
        [self.sslView removeFromSuperview];
    }
    if (self.settingView.superview) {
        [self.settingView removeFromSuperview];
    }
    
    [self addSubview:self.topLineView];
    [self.topLineView addSubview:self.generalButton];
    [self.topLineView addSubview:self.credentialsButton];
    [self.topLineView addSubview:self.sslButton];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.generalView];
    [self.containerView addSubview:self.credentialsView];
    [self.containerView addSubview:self.sslView];
    [self addSubview:self.settingView];
}

#pragma mark - getter
- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    return _topLineView;
}

- (UIButton *)generalButton {
    if (!_generalButton) {
        _generalButton = [self loadButtonWithTitle:@"General" action:@selector(generalButtonPressed)];
        [_generalButton setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
    }
    return _generalButton;
}

- (MKMQTTGeneralParamsView *)generalView {
    if (!_generalView) {
        _generalView = [[MKMQTTGeneralParamsView alloc] init];
        _generalView.delegate = self;
    }
    return _generalView;
}

- (UIButton *)credentialsButton {
    if (!_credentialsButton) {
        _credentialsButton = [self loadButtonWithTitle:@"Credentials" action:@selector(credentialsButtonPressed)];
    }
    return _credentialsButton;
}

- (MKCKMQTTUserCredentialsView *)credentialsView {
    if (!_credentialsView) {
        _credentialsView = [[MKCKMQTTUserCredentialsView alloc] init];
        _credentialsView.delegate = self;
    }
    return _credentialsView;
}

- (UIButton *)sslButton {
    if (!_sslButton) {
        _sslButton = [self loadButtonWithTitle:@"SSL/TLS" action:@selector(sslButtonPressed)];
    }
    return _sslButton;
}

- (MKCKMQTTSSLForDeviceView *)sslView {
    if (!_sslView) {
        _sslView = [[MKCKMQTTSSLForDeviceView alloc] init];
        _sslView.delegate = self;
    }
    return _sslView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (MKCKServerConfigDeviceSettingView *)settingView {
    if (!_settingView) {
        _settingView = [[MKCKServerConfigDeviceSettingView alloc] init];
        _settingView.delegate = self;
    }
    return _settingView;
}

- (UIButton *)loadButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:DEFAULT_TEXT_COLOR forState:UIControlStateNormal];
    [button.titleLabel setFont:MKFont(12.f)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
