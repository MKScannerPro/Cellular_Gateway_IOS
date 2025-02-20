//
//  MKCKPayloadItemsV2Controller.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/19.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKPayloadItemsV2Controller.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKCKPayloadItemsV2Model.h"

#import "MKCKBeaconPayloadController.h"
#import "MKCKUidPayloadController.h"
#import "MKCKUrlPayloadController.h"
#import "MKCKTlmPayloadController.h"
#import "MKCKInfoPayloadController.h"
#import "MKCKAccPayloadController.h"
#import "MKCKThPayloadController.h"
#import "MKCKButtonPayloadController.h"
#import "MKCKTagPayloadController.h"
#import "MKCKPirPayloadController.h"
#import "MKCKTofPayloadController.h"
#import "MKCKOtherPayloadController.h"
#import "MKCKBXPSPayloadController.h"


@interface MKCKPayloadItemsV2Controller ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKCKPayloadItemsV2Model *dataModel;

@end

@implementation MKCKPayloadItemsV2Controller

- (void)dealloc {
    NSLog(@"MKCKPayloadItemsV2Controller销毁");
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
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 20.f;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //iBeacon payload
        MKCKBeaconPayloadController *vc = [[MKCKBeaconPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Eddystone-UID payload
        MKCKUidPayloadController *vc = [[MKCKUidPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Eddystone-URL payload
        MKCKUrlPayloadController *vc = [[MKCKUrlPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Eddystone-TLM payload
        MKCKTlmPayloadController *vc = [[MKCKTlmPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //BXP-Device info payload
        MKCKInfoPayloadController *vc = [[MKCKInfoPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //BXP-ACC payload
        MKCKAccPayloadController *vc = [[MKCKAccPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        //BXP-T&H payload
        MKCKThPayloadController *vc = [[MKCKThPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        //BXP-Button payload
        MKCKButtonPayloadController *vc = [[MKCKButtonPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        //BXP-Tag payload
        MKCKTagPayloadController *vc = [[MKCKTagPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        //BXP - Sensor
        MKCKBXPSPayloadController *vc = [[MKCKBXPSPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.section == 0 && indexPath.row == 10) {
        //BXP-PIR payload
        MKCKPirPayloadController *vc = [[MKCKPirPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 11) {
        //MK TOF payload
        MKCKTofPayloadController *vc = [[MKCKTofPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 12) {
        //Other type payload
        MKCKOtherPayloadController *vc = [[MKCKOtherPayloadController alloc] init];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Beacon number
        self.dataModel.beaconNumber = isOn;
        
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 1) {
        //Sequence number
        self.dataModel.sequenceNumber = isOn;
        
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
        return;
    }
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
- (void)updateCellValues {
    MKTextSwitchCellModel *cellModel1 = self.section1List[0];
    cellModel1.isOn = self.dataModel.beaconNumber;
    
    MKTextSwitchCellModel *cellModel2 = self.section1List[1];
    cellModel2.isOn = self.dataModel.sequenceNumber;
    
    [self.tableView reloadData];
}

- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    for (NSInteger i = 0; i < 2; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        if (i == 1) {
            headerModel.text = @"Common items";
        }
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"iBeacon";
    cellModel1.showRightIcon = YES;
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Eddystone-UID";
    cellModel2.showRightIcon = YES;
    [self.section0List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Eddystone-URL";
    cellModel3.showRightIcon = YES;
    [self.section0List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Eddystone-TLM";
    cellModel4.showRightIcon = YES;
    [self.section0List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"BXP-Device info";
    cellModel5.showRightIcon = YES;
    [self.section0List addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.leftMsg = @"BXP–ACC";
    cellModel6.showRightIcon = YES;
    [self.section0List addObject:cellModel6];
    
    MKNormalTextCellModel *cellModel7 = [[MKNormalTextCellModel alloc] init];
    cellModel7.leftMsg = @"BXP–T&H";
    cellModel7.showRightIcon = YES;
    [self.section0List addObject:cellModel7];
    
    MKNormalTextCellModel *cellModel8 = [[MKNormalTextCellModel alloc] init];
    cellModel8.leftMsg = @"BXP–Button";
    cellModel8.showRightIcon = YES;
    [self.section0List addObject:cellModel8];
    
    MKNormalTextCellModel *cellModel9 = [[MKNormalTextCellModel alloc] init];
    cellModel9.leftMsg = @"BXP–Tag";
    cellModel9.showRightIcon = YES;
    [self.section0List addObject:cellModel9];
    
    MKNormalTextCellModel *cellModel10 = [[MKNormalTextCellModel alloc] init];
    cellModel10.leftMsg = @"BXP - Sensor";
    cellModel10.showRightIcon = YES;
    [self.section0List addObject:cellModel10];
    
    MKNormalTextCellModel *cellModel11 = [[MKNormalTextCellModel alloc] init];
    cellModel11.leftMsg = @"PIR Presence";
    cellModel11.showRightIcon = YES;
    [self.section0List addObject:cellModel11];
    
    MKNormalTextCellModel *cellModel12 = [[MKNormalTextCellModel alloc] init];
    cellModel12.leftMsg = @"MK TOF";
    cellModel12.showRightIcon = YES;
    [self.section0List addObject:cellModel12];
    
    MKNormalTextCellModel *cellModel13 = [[MKNormalTextCellModel alloc] init];
    cellModel13.leftMsg = @"Other type";
    cellModel13.showRightIcon = YES;
    [self.section0List addObject:cellModel13];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Beacon number";
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Sequence number";
    [self.section1List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Payload items settings";
    [self.rightButton setImage:LOADICON(@"MKGatewayFour", @"MKCKPayloadItemsV2Controller", @"ck_slotSaveIcon.png") forState:UIControlStateNormal];

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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKCKPayloadItemsV2Model *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKPayloadItemsV2Model alloc] init];
    }
    return _dataModel;
}

@end
