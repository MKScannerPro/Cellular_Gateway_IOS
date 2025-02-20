//
//  MKCKTabBarController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/24.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKTabBarController.h"

#import "MKMacroDefines.h"
#import "MKBaseNavigationController.h"

#import "MKAlertView.h"

#import "MKCKConnectModel.h"

#import "MKCKNetworkController.h"
#import "MKCKPositionController.h"
#import "MKCKScannerReportController.h"
#import "MKCKSettingsController.h"
#import "MKCKSettingsV2Controller.h"

#import "MKCKCentralManager.h"

@interface MKCKTabBarController ()

/// 当触发
/// 01:表示连接成功后，1分钟内没有通过密码验证（未输入密码，或者连续输入密码错误）认为超时，返回结果， 然后断开连接
/// 02:连续10分钟设备没有数据通信断开，返回结果，断开连接
/// 03:修改密码成功后，返回结果，断开连接

@property (nonatomic, assign)BOOL disconnectType;

/// 产品要求，进入debugger模式之后，设备断开连接也要停留在当前页面，只有退出debugger模式才进行正常模式通信
@property (nonatomic, assign)BOOL isDebugger;

@end

@implementation MKCKTabBarController

- (void)dealloc {
    NSLog(@"MKCKTabBarController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKCKCentralManager shared] disconnect];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_ck_popToRootViewControllerNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dfuUpdateComplete)
                                                 name:@"mk_ck_centralDeallocNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(centralManagerStateChanged)
                                                 name:mk_ck_centralManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:mk_ck_deviceDisconnectTypeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_ck_peripheralConnectStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceEnterDebuggerMode)
                                                 name:@"mk_ck_startDebuggerMode"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceStopDebuggerMode)
                                                 name:@"mk_ck_stopDebuggerMode"
                                               object:nil];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_ck_needResetScanDelegate:)]) {
            [self.delegate mk_ck_needResetScanDelegate:NO];
        }
    }];
}

- (void)dfuUpdateComplete {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_ck_needResetScanDelegate:)]) {
            [self.delegate mk_ck_needResetScanDelegate:YES];
        }
    }];
}

- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    /// 02:连续10分钟设备没有数据通信断开，返回结果，断开连接
    /// 03:修改密码成功后，返回结果，断开连接
    
    self.disconnectType = YES;
    if ([type isEqualToString:@"02"]) {
        [self showAlertWithMsg:@"No data communication for 10 minutes, the device is disconnected." title:@""];
        return;
    }
    if ([type isEqualToString:@"03"]) {
        [self showAlertWithMsg:@"Password changed successfully! Please reconnect the device." title:@"Change Password"];
        return;
    }
    //异常断开
    NSString *msg = [NSString stringWithFormat:@"Device disconnected for unknown reason.(%@)",type];
    [self showAlertWithMsg:msg title:@"Dismiss"];
}

- (void)centralManagerStateChanged{
    if (self.disconnectType) {
        return;
    }
    if ([MKCKCentralManager shared].centralStatus != mk_ck_centralManagerStatusEnable) {
        [self showAlertWithMsg:@"The current system of bluetooth is not available!" title:@"Dismiss"];
    }
}

- (void)deviceConnectStateChanged {
     if (self.disconnectType) {
        return;
    }
    [self showAlertWithMsg:@"The device is disconnected." title:@"Dismiss"];
    return;
}

- (void)deviceEnterDebuggerMode {
    self.isDebugger = YES;
}

- (void)deviceStopDebuggerMode {
    self.isDebugger = NO;
}

#pragma mark - private method
- (void)showAlertWithMsg:(NSString *)msg title:(NSString *)title{
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_ck_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    
    @weakify(self);
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        if (!self.isDebugger) {
            [self gotoScanPage];
        }
    }];
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:title message:msg notificationName:@"mk_ck_needDismissAlert"];
}

- (void)loadSubPages {
    MKCKNetworkController *networkPage = [[MKCKNetworkController alloc] init];
    networkPage.tabBarItem.title = @"Network";
    networkPage.tabBarItem.image = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_network_tabBarUnselected.png");
    networkPage.tabBarItem.selectedImage = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_network_tabBarSelected.png");
    MKBaseNavigationController *networkNav = [[MKBaseNavigationController alloc] initWithRootViewController:networkPage];
    
    MKCKScannerReportController *scanReportPage = [[MKCKScannerReportController alloc] init];
    scanReportPage.tabBarItem.title = @"Scanner";
    scanReportPage.tabBarItem.image = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_scannerReport_tabBarUnselected.png");
    scanReportPage.tabBarItem.selectedImage = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_scannerReport_tabBarSelected.png");
    MKBaseNavigationController *scanReportNav = [[MKBaseNavigationController alloc] initWithRootViewController:scanReportPage];
    
    MKCKPositionController *positionPage = [[MKCKPositionController alloc] init];
    positionPage.tabBarItem.title = @"Position";
    positionPage.tabBarItem.image = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_position_tabBarUnselected.png");
    positionPage.tabBarItem.selectedImage = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_position_tabBarSelected.png");
    MKBaseNavigationController *positionNav = [[MKBaseNavigationController alloc] initWithRootViewController:positionPage];

    UIViewController *settingPage = ([MKCKConnectModel shared].isV104 ? [[MKCKSettingsV2Controller alloc] init] : [[MKCKSettingsController alloc] init]);
    settingPage.tabBarItem.title = @"Settings";
    settingPage.tabBarItem.image = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_setting_tabBarUnselected.png");
    settingPage.tabBarItem.selectedImage = LOADICON(@"MKGatewayFour", @"MKCKTabBarController", @"ck_setting_tabBarSelected.png");
    MKBaseNavigationController *settingNav = [[MKBaseNavigationController alloc] initWithRootViewController:settingPage];
    
    self.viewControllers = @[networkNav,scanReportNav,positionNav,settingNav];
}

@end
