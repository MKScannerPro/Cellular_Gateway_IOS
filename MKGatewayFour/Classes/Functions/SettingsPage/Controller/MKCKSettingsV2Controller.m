//
//  MKCKSettingsV2Controller.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/19.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKSettingsV2Controller.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"


#import "MKCKConnectModel.h"

#import "MKCKInterface+MKCKConfig.h"

#import "MKCKSettingsModel.h"


#import "MKCKLedSettingsController.h"
#import "MKCKBleParamsController.h"
#import "MKCKHeartbeatReportController.h"
#import "MKCKSystemTimeController.h"
#import "MKCKBatteryManagementController.h"
#import "MKCKDeviceInfoController.h"
#import "MKCKDebuggerController.h"

@interface MKCKSettingsV2Controller ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKCKSettingsModel *dataModel;

@end

@implementation MKCKSettingsV2Controller

- (void)dealloc {
    NSLog(@"MKCKSettingsV2Controller销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self readDataFromDevice];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3 || section == 4) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //LED settings
        MKCKLedSettingsController *vc = [[MKCKLedSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Bluetooth parameters
        MKCKBleParamsController *vc = [[MKCKBleParamsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Heartbeat report settings
        MKCKHeartbeatReportController *vc = [[MKCKHeartbeatReportController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //System time
        MKCKSystemTimeController *vc = [[MKCKSystemTimeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //Battery management
        MKCKBatteryManagementController *vc = [[MKCKBatteryManagementController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //Delete buffer data
        [self showDeleteBufferDataAlert];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        //Reboot
        [self showRebootAlert];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        //Power Off
        [self showPowerOffAlert];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 2) {
        //Reset
        [self showResetAlert];
        return;
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        //Device information
        MKCKDeviceInfoController *vc = [[MKCKDeviceInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        //Debug Mode
        MKCKDebuggerController *vc = [[MKCKDebuggerController alloc] init];
        vc.macAddress = [MKCKConnectModel shared].macAddress;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        NSLog(@"当前刷新的index:%@",@(indexPath.row));
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section4List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Power loss notification
        [self configPowerLossNotification:isOn];
        return;
    }
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //Power on when charging
        [self configPowerOnWhenCharging:dataListIndex];
        return;
    }
    if (index == 1) {
        //Power on by magnet
        [self configPowerOnByMagnet:dataListIndex];
        return;
    }
}

#pragma mark - Interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        [[MKHudManager share] hide];
        [self updateCellStates];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateCellStates {
    MKNormalTextCellModel *batteryModel = self.section0List[4];
    batteryModel.rightMsg = [self.dataModel.battery stringByAppendingString:@"mV"];
    
    MKNormalTextCellModel *offlineDataModel = self.section0List[5];
    offlineDataModel.rightMsg = SafeStr(self.dataModel.offlineDataCount);
    
    MKTextSwitchCellModel *powerLossModel = self.section1List[0];
    powerLossModel.isOn = self.dataModel.powerLoss;
    
    MKTextButtonCellModel *powerOnModel = self.section2List[0];
    powerOnModel.dataListIndex = self.dataModel.powerOnWhenCharging;
    
    MKTextButtonCellModel *powerOnByMagnetModel = self.section2List[1];
    powerOnByMagnetModel.dataListIndex = self.dataModel.powerOnByMagnet;
    
    [self.tableView reloadData];
}

#pragma mark - Delete buffer data
- (void)showDeleteBufferDataAlert {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self sendDeleteBufferDataToDevice];
    }];
    NSString *msg = @"Please confirm again whether to delete buffer data.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Delete buffer device" message:msg notificationName:@"mk_ck_needDismissAlert"];
}

- (void)sendDeleteBufferDataToDevice{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKCKInterface ck_deleteBufferDataWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup succeed."];
        [self readDataFromDevice];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup failed."];
    }];
}

#pragma mark - Power loss notification
- (void)configPowerLossNotification:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKCKInterface ck_configPowerLossNotification:isOn sucBlock:^{
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        self.dataModel.powerLoss = isOn;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - Power on when charging
- (void)configPowerOnWhenCharging:(NSInteger)type {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKCKInterface ck_configPowerOnWhenChargingStatus:type sucBlock:^{
        [[MKHudManager share] hide];
        MKTextButtonCellModel *cellModel = self.section2List[0];
        cellModel.dataListIndex = type;
        self.dataModel.powerOnWhenCharging = type;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:0 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - Power on by magnet
- (void)configPowerOnByMagnet:(NSInteger)type {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKCKInterface ck_configPowerOnByMagnet:type sucBlock:^{
        [[MKHudManager share] hide];
        MKTextButtonCellModel *cellModel = self.section2List[1];
        cellModel.dataListIndex = type;
        self.dataModel.powerOnByMagnet = type;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadRow:1 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - Reboot
- (void)showRebootAlert {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self sendRebootToDevice];
    }];
    NSString *msg = @"Please confirm again whether to reboot the device.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Reboot device" message:msg notificationName:@"mk_ck_needDismissAlert"];
}

- (void)sendRebootToDevice{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKCKInterface ck_restartDeviceWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup succeed."];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup failed."];
    }];
}

#pragma mark - Power Off
- (void)showPowerOffAlert {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self sendPowerOffToDevice];
    }];
    NSString *msg = @"Please confirm again whether to power off the device.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Power off" message:msg notificationName:@"mk_ck_needDismissAlert"];
}

- (void)sendPowerOffToDevice{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKCKInterface ck_powerOffWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup succeed."];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup failed."];
    }];
}

#pragma mark - Reset
- (void)showResetAlert {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self sendResetToDevice];
    }];
    NSString *msg = @"All parameters will be restored to factory settings, please confirm again.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Reset device" message:msg notificationName:@"mk_ck_needDismissAlert"];
}

- (void)sendResetToDevice{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKCKInterface ck_factoryResetWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup succeed."];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"setup failed."];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    
    for (NSInteger i = 0; i < 5; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"LED settings";
    cellModel1.showRightIcon = YES;
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Bluetooth parameters";
    cellModel2.showRightIcon = YES;
    [self.section0List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Heartbeat report settings";
    cellModel3.showRightIcon = YES;
    [self.section0List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"System time";
    cellModel4.showRightIcon = YES;
    [self.section0List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"Battery management";
    cellModel5.showRightIcon = YES;
    [self.section0List addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.leftMsg = @"Delete buffer data";
    cellModel6.showRightIcon = YES;
    [self.section0List addObject:cellModel6];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Power loss notification";
    cellModel1.isOn = YES;
    [self.section1List addObject:cellModel1];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Power on when charging";
    cellModel1.dataList = @[@"Every time",@"When battery dead"];
    cellModel1.buttonLabelFont = MKFont(12.f);
    [self.section2List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Power on by magnet";
    cellModel2.dataList = @[@"Detects three times",@"Detects three seconds"];
    cellModel2.buttonLabelFont = MKFont(12.f);
    [self.section2List addObject:cellModel2];
}

- (void)loadSection3Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Reboot";
    cellModel1.showRightIcon = YES;
    [self.section3List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Power off";
    cellModel2.showRightIcon = YES;
    [self.section3List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Reset";
    cellModel3.showRightIcon = YES;
    [self.section3List addObject:cellModel3];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Device information";
    cellModel1.showRightIcon = YES;
    [self.section4List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Debug mode";
    cellModel2.showRightIcon = YES;
    [self.section4List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Settings";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-49.f);
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

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKCKSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
