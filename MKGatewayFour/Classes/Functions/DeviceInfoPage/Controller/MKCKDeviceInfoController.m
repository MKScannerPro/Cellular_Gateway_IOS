//
//  MKCKDeviceInfoController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2024/1/8.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCKDeviceInfoController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKDeviceInfoCell.h"
#import "MKDeviceInfoDfuCell.h"

#import "MKCKConnectModel.h"

#import "MKCKDeviceInfoModel.h"

#import "MKCKUpdateController.h"

@interface MKCKDeviceInfoController ()<UITableViewDelegate,
UITableViewDataSource,
MKDeviceInfoDfuCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKCKDeviceInfoModel *dataModel;

@end

@implementation MKCKDeviceInfoController

- (void)dealloc {
    NSLog(@"MKCKDeviceInfoController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKDeviceInfoCell *cell = [MKDeviceInfoCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKDeviceInfoDfuCell *cell = [MKDeviceInfoDfuCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKDeviceInfoCell *cell = [MKDeviceInfoCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - MKDeviceInfoDfuCellDelegate
/// 用户点击了右侧按钮
/// @param index cell所在序列号
- (void)mk_textButtonCell_buttonAction:(NSInteger)index {
    MKCKUpdateController *vc = [[MKCKUpdateController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKDeviceInfoCellModel *cellModel1 = [[MKDeviceInfoCellModel alloc] init];
    cellModel1.leftMsg = @"Device Name";
    cellModel1.rightMsg = self.dataModel.deviceName;
    [self.section0List addObject:cellModel1];
    
    MKDeviceInfoCellModel *cellModel2 = [[MKDeviceInfoCellModel alloc] init];
    cellModel2.leftMsg = @"Product Model";
    NSString *fexString = @"";
    if ([MKCKConnectModel shared].isV104) {
        if (self.dataModel.cellularMode == 0) {
            fexString = @"-40G-GL";
        }else if (self.dataModel.cellularMode == 1) {
            fexString = @"-40E-NA";
        }else if (self.dataModel.cellularMode == 2) {
            fexString = @"-40E-EU";
        }else if (self.dataModel.cellularMode == 3) {
            fexString = @"-40E-LA";
        }
    }
    cellModel2.rightMsg = [self.dataModel.productMode stringByAppendingString:fexString];
    [self.section0List addObject:cellModel2];
    
    MKDeviceInfoCellModel *cellModel3 = [[MKDeviceInfoCellModel alloc] init];
    cellModel3.leftMsg = @"Manufacturer";
    cellModel3.rightMsg = self.dataModel.manu;
    [self.section0List addObject:cellModel3];
    
    MKDeviceInfoCellModel *cellModel4 = [[MKDeviceInfoCellModel alloc] init];
    cellModel4.leftMsg = @"Hardware Version";
    cellModel4.rightMsg = self.dataModel.hardware;
    [self.section0List addObject:cellModel4];
    
    MKDeviceInfoCellModel *cellModel5 = [[MKDeviceInfoCellModel alloc] init];
    cellModel5.leftMsg = @"Software Version";
    cellModel5.rightMsg = self.dataModel.software;
    [self.section0List addObject:cellModel5];
}

- (void)loadSection1Datas {
    MKDeviceInfoDfuCellModel *cellModel = [[MKDeviceInfoDfuCellModel alloc] init];
    cellModel.index = 0;
    cellModel.leftMsg = @"Firmware Version";
    cellModel.rightButtonTitle = @"DFU";
    cellModel.rightMsg = self.dataModel.firmware;
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKDeviceInfoCellModel *cellModel1 = [[MKDeviceInfoCellModel alloc] init];
    cellModel1.leftMsg = @"MAC Address";
    cellModel1.rightMsg = self.dataModel.macAddress;
    [self.section2List addObject:cellModel1];
    
    MKDeviceInfoCellModel *cellModel2 = [[MKDeviceInfoCellModel alloc] init];
    cellModel2.leftMsg = @"IMEI";
    cellModel2.rightMsg = self.dataModel.imei;
    [self.section2List addObject:cellModel2];
    
    MKDeviceInfoCellModel *cellModel3 = [[MKDeviceInfoCellModel alloc] init];
    cellModel3.leftMsg = @"ICCID";
    cellModel3.rightMsg = self.dataModel.iccid;
    [self.section2List addObject:cellModel3];
    
    if ([MKCKConnectModel shared].isV104) {
        MKDeviceInfoCellModel *cellModel4 = [[MKDeviceInfoCellModel alloc] init];
        cellModel4.leftMsg = @"LTE firmware version";
        cellModel4.rightMsg = self.dataModel.cellularVersion;
        [self.section2List addObject:cellModel4];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device information";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
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

- (MKCKDeviceInfoModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKDeviceInfoModel alloc] init];
    }
    return _dataModel;
}

@end
