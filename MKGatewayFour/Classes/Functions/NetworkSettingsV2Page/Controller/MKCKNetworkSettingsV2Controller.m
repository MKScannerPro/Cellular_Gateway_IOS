//
//  MKCKNetworkSettingsV2Controller.m
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/18.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKCKNetworkSettingsV2Controller.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextButtonCell.h"
#import "MKTextFieldCell.h"

#import "MKCKNetworkSettingsV2Model.h"

#import "MKCKRegionsBandsView.h"

@interface MKCKNetworkSettingsV2Controller ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKCKNetworkSettingsV2Model *dataModel;

@property (nonatomic, strong)MKCKRegionsBandsView *footerView;

@end

@implementation MKCKNetworkSettingsV2Controller

- (void)dealloc {
    NSLog(@"MKCKNetworkSettingsV2Controller销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method

- (void)rightButtonMethod {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    self.dataModel.regionsBands = [self.footerView fetchCurrentRegion];
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
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
        //Network priority
        self.dataModel.priority = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //APN
        self.dataModel.apn = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Username
        self.dataModel.userName = value;
        MKTextFieldCellModel *cellModel = self.section1List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //Password
        self.dataModel.password = value;
        MKTextFieldCellModel *cellModel = self.section1List[2];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 3) {
        //Pin
        self.dataModel.pin = value;
        MKTextFieldCellModel *cellModel = self.section1List[3];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 4) {
        //Connect timeout
        self.dataModel.timeout = value;
        MKTextFieldCellModel *cellModel = self.section1List[4];
        cellModel.textFieldValue = value;
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
    
    self.footerView.regionsBands = self.dataModel.regionsBands;
    
    [self.tableView reloadData];
}
- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Network priority";
    cellModel.dataList = @[@"eMTC->NB-IOT->GSM",@"eMTC->GSM->NB-IOT",@"NB-IOT->GSM->eMTC",
                           @"NB-IOT->eMTC->GSM",@"GSM->NB-IOT->eMTC",@"GSM->eMTC->NB-IOT",
                           @"eMTC->NB-IOT",@"NB-IOT-> eMTC",@"GSM",@"NB-IOT",@"eMTC"];
    cellModel.dataListIndex = self.dataModel.priority;
    cellModel.buttonLabelFont = MKFont(11.f);
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"APN";
    cellModel1.textPlaceholder = @"0-100 Characters";
    cellModel1.textFieldType = mk_normal;
    cellModel1.maxLength = 100;
    cellModel1.textFieldValue = self.dataModel.apn;
    [self.section1List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Username";
    cellModel2.textPlaceholder = @"0-100 Characters";
    cellModel2.textFieldType = mk_normal;
    cellModel2.maxLength = 100;
    cellModel2.textFieldValue = self.dataModel.userName;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Password";
    cellModel3.textPlaceholder = @"0-100 Characters";
    cellModel3.textFieldType = mk_normal;
    cellModel3.maxLength = 100;
    cellModel3.textFieldValue = self.dataModel.password;
    [self.section1List addObject:cellModel3];
    
    MKTextFieldCellModel *cellModel4 = [[MKTextFieldCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"Pin";
    cellModel4.textPlaceholder = @"0 or 4-8 Characters";
    cellModel4.textFieldType = mk_normal;
    cellModel4.maxLength = 8;
    cellModel4.textFieldValue = self.dataModel.pin;
    [self.section1List addObject:cellModel4];
    
    MKTextFieldCellModel *cellModel5 = [[MKTextFieldCellModel alloc] init];
    cellModel5.index = 4;
    cellModel5.msg = @"Connect timeout";
    cellModel5.textPlaceholder = @"30-600";
    cellModel5.textFieldType = mk_realNumberOnly;
    cellModel5.maxLength = 3;
    cellModel5.textFieldValue = self.dataModel.timeout;
    cellModel5.unit = @"Second";
    [self.section1List addObject:cellModel5];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Network settings";
    [self.rightButton setImage:LOADICON(@"MKGatewayFour", @"MKCKNetworkSettingsV2Controller", @"ck_slotSaveIcon.png") forState:UIControlStateNormal];
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
        
        _tableView.tableFooterView = self.footerView;
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

- (MKCKNetworkSettingsV2Model *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKNetworkSettingsV2Model alloc] init];
    }
    return _dataModel;
}

- (MKCKRegionsBandsView *)footerView {
    if (!_footerView) {
        _footerView = [[MKCKRegionsBandsView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 200.f)];
    }
    return _footerView;
}

@end
