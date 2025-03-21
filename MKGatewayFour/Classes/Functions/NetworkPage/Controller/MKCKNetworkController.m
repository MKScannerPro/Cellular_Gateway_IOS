//
//  MKCKNetworkController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/24.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKNetworkController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKCustomUIAdopter.h"

#import "MKIoTCloudAccountLoginAlertView.h"
#import "MKIoTLoginService.h"

#import "MKCKConnectModel.h"

#import "MKCKNetworkModel.h"

#import "MKCKUserLoginManager.h"

#import "MKCKNetworkSettingsController.h"
#import "MKCKNetworkSettingsV2Controller.h"
#import "MKCKMqttSettingsController.h"
#import "MKCKSyncDeviceController.h"

@interface MKCKNetworkController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)dispatch_source_t refreshTimer;

@property (nonatomic, strong)MKCKNetworkModel *dataModel;

@property (nonatomic, strong)UIView *footerView;

@end

@implementation MKCKNetworkController

- (void)dealloc {
    NSLog(@"MKCKNetworkController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addRefreshTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.refreshTimer) {
        dispatch_cancel(self.refreshTimer);
        self.refreshTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_ck_popToRootViewControllerNotification" object:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Network Settings
        if ([MKCKConnectModel shared].isV104) {
            //V2
            MKCKNetworkSettingsV2Controller *vc = [[MKCKNetworkSettingsV2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        MKCKNetworkSettingsController *vc = [[MKCKNetworkSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //MQTT settings
        MKCKMqttSettingsController *vc = [[MKCKMqttSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self updateCellValues];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - event method
- (void)syncButtonPressed {
    if (self.dataList.count == 0) {
        [self.view showCentralToast:@"Add devices first"];
        return;
    }
    if (ValidStr([MKCKUserLoginManager shared].password)) {
        //已经登陆过
        [self login:[MKCKUserLoginManager shared].isHome username:[MKCKUserLoginManager shared].username password:[MKCKUserLoginManager shared].password];
        return;
    }
    MKIoTCloudAccountLoginAlertViewModel *viewModel = [[MKIoTCloudAccountLoginAlertViewModel alloc] init];
    viewModel.account = [MKCKUserLoginManager shared].username;
    viewModel.isHome = [MKCKUserLoginManager shared].isHome;
    viewModel.password = [MKCKUserLoginManager shared].password;
    MKIoTCloudAccountLoginAlertView *alertView = [[MKIoTCloudAccountLoginAlertView alloc] init];
    [alertView showViewWithModel:viewModel completeBlock:^(NSString * _Nonnull account, NSString * _Nonnull password, BOOL isHome) {
        [self login:isHome username:account password:password];
    }];
}

#pragma mark - private method
- (void)addRefreshTimer {
    self.refreshTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.refreshTimer, dispatch_time(DISPATCH_TIME_NOW, 0),  3 * NSEC_PER_SEC, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.refreshTimer, ^{
        @strongify(self);
        moko_dispatch_main_safe(^{
            [self readDataFromDevice];
        });
    });
    dispatch_resume(self.refreshTimer);
}

- (void)updateCellValues {
    MKNormalTextCellModel *cellModel1 = self.dataList[0];
    cellModel1.rightMsg = self.dataModel.networkStatus;
    
    MKNormalTextCellModel *cellModel2 = self.dataList[1];
    cellModel2.rightMsg = self.dataModel.mqttStatus;
    
    self.footerView.hidden = !([self.dataModel.networkStatus isEqualToString:@"Connected"] && [self.dataModel.mqttStatus isEqualToString:@"Connected"]);
    
    [self.tableView reloadData];
}

- (void)login:(BOOL)isHome username:(NSString *)username password:(NSString *)password {
    [[MKHudManager share] showHUDWithTitle:@"Login..." inView:self.view isPenetration:NO];
    [[MKIoTLoginService share] loginWithUsername:username password:password isHome:isHome sucBlock:^(id returnData) {
        [[MKHudManager share] hide];
        [[MKCKUserLoginManager shared] syncLoginDataWithHome:isHome username:username password:password];
        MKCKSyncDeviceController *vc = [[MKCKSyncDeviceController alloc] init];
        vc.token = SafeStr(returnData[@"data"][@"access_token"]);
        [self.navigationController pushViewController:vc animated:YES];
    } failBlock:^(NSError *error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Network settings";
    cellModel1.showRightIcon = YES;
    [self.dataList addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"MQTT settings";
    cellModel2.showRightIcon = YES;
    [self.dataList addObject:cellModel2];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKCKConnectModel shared].deviceName;
    [self.view addSubview:self.footerView];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-49.f);
        make.height.mas_equalTo(60.f);
    }];
    
    UIButton *syncButton = [MKCustomUIAdopter customButtonWithTitle:@"Sync devices to cloud"
                                                             target:self
                                                             action:@selector(syncButtonPressed)];
    [self.footerView addSubview:syncButton];
    [syncButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.centerY.mas_equalTo(self.footerView.mas_centerY);
        make.height.mas_equalTo(40.f);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.footerView.mas_top);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKCKNetworkModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKNetworkModel alloc] init];
    }
    return _dataModel;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = COLOR_WHITE_MACROS;
    }
    return _footerView;
}

@end
