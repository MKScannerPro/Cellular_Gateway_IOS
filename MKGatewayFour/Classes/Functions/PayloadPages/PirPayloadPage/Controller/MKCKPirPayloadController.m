//
//  MKCKPirPayloadController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKPirPayloadController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"

#import "MKCKPirPayloadModel.h"

@interface MKCKPirPayloadController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKCKPirPayloadModel *dataModel;

@end

@implementation MKCKPirPayloadController

- (void)dealloc {
    NSLog(@"MKCKPirPayloadController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
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
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //RSSI
        self.dataModel.rssi = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 1) {
        //Timestamp
        self.dataModel.timestamp = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[1];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 2) {
        //Delay response status
        self.dataModel.delayResponseStatus = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 3) {
        //Door open/close status
        self.dataModel.doorStatus = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 4) {
        //Sensor sensitivity
        self.dataModel.sensorSensitivity = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[2];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 5) {
        //Sensor detection status
        self.dataModel.sensorDetectionStatus = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[3];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 6) {
        //Battery voltage
        self.dataModel.voltage = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[4];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 7) {
        //Major
        self.dataModel.major = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[5];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 8) {
        //Minor
        self.dataModel.minor = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[6];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 9) {
        //RSSI@1m
        self.dataModel.rssi1m = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[7];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 10) {
        //Tx power
        self.dataModel.txPower = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[8];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 11) {
        //ADV name
        self.dataModel.advName = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[9];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 12) {
        //Raw data- Advertising
        self.dataModel.advertising = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 13) {
        //Raw data- Response
        self.dataModel.response = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[1];
        cellModel.isOn = isOn;
        return;
    }
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

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
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
    
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"RSSI";
    cellModel1.isOn = self.dataModel.rssi;
    [self.section0List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Timestamp";
    cellModel2.isOn = self.dataModel.timestamp;
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"Delay response status";
    cellModel1.isOn = self.dataModel.delayResponseStatus;
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"Door open/close status";
    cellModel2.isOn = self.dataModel.doorStatus;
    [self.section1List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 4;
    cellModel3.msg = @"Sensor sensitivity";
    cellModel3.isOn = self.dataModel.sensorSensitivity;
    [self.section1List addObject:cellModel3];
    
    MKTextSwitchCellModel *cellModel4 = [[MKTextSwitchCellModel alloc] init];
    cellModel4.index = 5;
    cellModel4.msg = @"Sensor detection status";
    cellModel4.isOn = self.dataModel.sensorDetectionStatus;
    [self.section1List addObject:cellModel4];
    
    MKTextSwitchCellModel *cellModel5 = [[MKTextSwitchCellModel alloc] init];
    cellModel5.index = 6;
    cellModel5.msg = @"Battery voltage";
    cellModel5.isOn = self.dataModel.voltage;
    [self.section1List addObject:cellModel5];
    
    MKTextSwitchCellModel *cellModel6 = [[MKTextSwitchCellModel alloc] init];
    cellModel6.index = 7;
    cellModel6.msg = @"Major";
    cellModel6.isOn = self.dataModel.major;
    [self.section1List addObject:cellModel6];
    
    MKTextSwitchCellModel *cellModel7 = [[MKTextSwitchCellModel alloc] init];
    cellModel7.index = 8;
    cellModel7.msg = @"Minor";
    cellModel7.isOn = self.dataModel.minor;
    [self.section1List addObject:cellModel7];
    
    MKTextSwitchCellModel *cellModel8 = [[MKTextSwitchCellModel alloc] init];
    cellModel8.index = 9;
    cellModel8.msg = @"RSSI@1m";
    cellModel8.isOn = self.dataModel.rssi1m;
    [self.section1List addObject:cellModel8];
    
    MKTextSwitchCellModel *cellModel9 = [[MKTextSwitchCellModel alloc] init];
    cellModel9.index = 10;
    cellModel9.msg = @"Tx power";
    cellModel9.isOn = self.dataModel.txPower;
    [self.section1List addObject:cellModel9];
    
    MKTextSwitchCellModel *cellModel10 = [[MKTextSwitchCellModel alloc] init];
    cellModel10.index = 11;
    cellModel10.msg = @"ADV name";
    cellModel10.isOn = self.dataModel.advName;
    [self.section1List addObject:cellModel10];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 12;
    cellModel1.msg = @"Raw data-Advertising";
    cellModel1.isOn = self.dataModel.advertising;
    [self.section2List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 13;
    cellModel2.msg = @"Raw data-Response";
    cellModel2.isOn = self.dataModel.response;
    [self.section2List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"PIR presence payload";
    [self.rightButton setImage:LOADICON(@"MKGatewayFour", @"MKCKPirPayloadController", @"ck_slotSaveIcon.png") forState:UIControlStateNormal];
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
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKCKPirPayloadModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKPirPayloadModel alloc] init];
    }
    return _dataModel;
}

@end
