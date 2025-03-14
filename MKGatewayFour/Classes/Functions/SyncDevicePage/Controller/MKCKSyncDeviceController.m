//
//  MKCKSyncDeviceController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKCKSyncDeviceController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"

#import "MKIoTCloudExitAccountAlert.h"

#import "MKCKConnectModel.h"

#import "MKCKUserLoginManager.h"
#import "MKCKNetworkService.h"

#import "MKCKSyncDeviceCell.h"

#import "MKCKSyncDeviceModel.h"

@interface MKCKSyncDeviceController ()<UITableViewDelegate,
UITableViewDataSource,
MKCKSyncDeviceCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKCKSyncDeviceModel *dataModel;

@end

@implementation MKCKSyncDeviceController

- (void)dealloc {
    NSLog(@"MKCKSyncDeviceController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    MKIoTCloudExitAccountAlert *alert = [[MKIoTCloudExitAccountAlert alloc] init];
    [alert showWithAccount:[MKCKUserLoginManager shared].username completeBlock:^{
        [[MKCKUserLoginManager shared] syncLoginDataWithHome:[MKCKUserLoginManager shared].isHome username:[MKCKUserLoginManager shared].username password:@""];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKCKSyncDeviceCell *cell = [MKCKSyncDeviceCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKCKSyncDeviceCellDelegate
- (void)ck_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index {
    MKCKSyncDeviceCellModel *cellModel = self.dataList[index];
    cellModel.selected = selected;
}

#pragma mark - event method
- (void)syncButtonPressed {
    NSMutableArray *uploadList = [NSMutableArray array];
    for (MKCKSyncDeviceCellModel *cellModel in self.dataList) {
        if (cellModel.selected) {
            MKCKCreatScannerProDeviceModel *uploadModel = [[MKCKCreatScannerProDeviceModel alloc] init];
            uploadModel.macAddress = cellModel.macAddress;
            uploadModel.macName = cellModel.deviceName;
            uploadModel.lastWillTopic = @"";
            uploadModel.publishTopic = cellModel.publishedTopic;
            uploadModel.subscribeTopic = cellModel.subscribedTopic;
            [uploadList addObject:uploadModel];
        }
    }
    if (uploadList.count == 0) {
        [self.view showCentralToast:@"Add devices first"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Loading..." inView:self.view isPenetration:NO];
    [[MKCKNetworkService share] addScannerProDevicesToCloud:uploadList isHome:[MKCKUserLoginManager shared].isHome token:self.token sucBlock:^(id returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Sync success"];
    } failBlock:^(NSError *error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadDataSections];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadDataSections {
    MKCKSyncDeviceCellModel *cellModel = [[MKCKSyncDeviceCellModel alloc] init];
    cellModel.index = 0;
    NSString *mac = [[MKCKConnectModel shared].macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    cellModel.deviceName = [@"MKGW4-" stringByAppendingString:[mac substringFromIndex:mac.length - 4]];
    cellModel.macAddress = [mac lowercaseString];
    cellModel.lwtTopic = self.dataModel.publishTopic;
    cellModel.subscribedTopic = self.dataModel.subscribeTopic;
    cellModel.publishedTopic = self.dataModel.publishTopic;
    [self.dataList addObject:cellModel];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"MKGW4";
    [self.rightButton setImage:LOADICON(@"MKGatewayFour", @"MKCKSyncDeviceController", @"ck_authorIcon.png") forState:UIControlStateNormal];
    UIView *footView = [self footerView];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(100.f);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(footView.mas_top);
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

- (MKCKSyncDeviceModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKSyncDeviceModel alloc] init];
    }
    return _dataModel;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UIButton *syncButton = [MKCustomUIAdopter customButtonWithTitle:@"Sync devices to cloud"
                                                             target:self
                                                             action:@selector(syncButtonPressed)];
    [footerView addSubview:syncButton];
    [syncButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.centerY.mas_equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(40.f);
    }];
    
    return footerView;
}

@end
