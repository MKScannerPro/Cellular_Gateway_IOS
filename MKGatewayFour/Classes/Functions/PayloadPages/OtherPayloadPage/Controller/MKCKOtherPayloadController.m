//
//  MKCKOtherPayloadController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKOtherPayloadController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"

#import "MKCKOtherTypePayloadHeaderView.h"

#import "MKCKOtherPayloadModel.h"

#import "MKCKOtherDataBlockCell.h"

@interface MKCKOtherPayloadController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKCKOtherTypePayloadHeaderViewDelegate,
MKCKOtherDataBlockCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKCKOtherPayloadModel *dataModel;

@end

@implementation MKCKOtherPayloadController

- (void)dealloc {
    NSLog(@"MKCKOtherPayloadController销毁");
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
    if (section == 1) {
        return 35.f;
    }
    if (section == 2) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        MKCKOtherTypePayloadHeaderView *headerView = [MKCKOtherTypePayloadHeaderView initHeaderViewWithTableView:tableView];
        headerView.delegate = self;
        return headerView;
    }
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = [[MKTableSectionLineHeaderModel alloc] init];
    return headerView;
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
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKCKOtherDataBlockCell *cell = [MKCKOtherDataBlockCell initCellWithTableView:tableView];
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
        //Raw data- Advertising
        self.dataModel.advertising = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 3) {
        //Raw data- Response
        self.dataModel.response = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[1];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKCKOtherTypePayloadHeaderViewDelegate
- (void)ck_addBlockOptions {
    if (self.section1List.count >= 10) {
        [self.view showCentralToast:@"You can set up to 10 filters!"];
        return;
    }
    MKCKOtherDataBlockCellModel *cellModel = [[MKCKOtherDataBlockCellModel alloc] init];
    cellModel.index = self.section1List.count;
    cellModel.msg = [NSString stringWithFormat:@"Data block %ld",(long)(self.section1List.count + 1)];
    [self.section1List addObject:cellModel];
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - MKCKOtherDataBlockCellDelegate
- (void)ck_otherDataBlockCell_textFieldChanged:(NSInteger)index textID:(NSInteger)textID text:(NSString *)text {
    MKCKOtherDataBlockCellModel *cellModel = self.section1List[index];
    if (textID == 0) {
        cellModel.dataType = text;
    }else if (textID == 1) {
        cellModel.start = text;
    }else if (textID == 2) {
        cellModel.end = text;
    }
}

- (void)ck_otherDataBlockCell_delete:(NSInteger)index {
    if (index >= self.section1List.count) {
        return;
    }
    [self.section1List removeObjectAtIndex:index];
    for (NSInteger i = 0; i < self.section1List.count; i ++) {
        MKCKOtherDataBlockCellModel *cellModel = self.section1List[i];
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Data block %ld",(long)(i + 1)];
    }
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
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
    NSMutableArray *list = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section1List.count; i ++) {
        MKCKOtherDataBlockCellModel *cellModel = self.section1List[i];
        if (!ValidStr(cellModel.start) || !ValidStr(cellModel.end) || [cellModel.start integerValue] < 1 || [cellModel.start integerValue] > 29 || [cellModel.end integerValue] < 1 || [cellModel.end integerValue] > 29 || [cellModel.start integerValue] > [cellModel.end integerValue]) {
            [self.view showCentralToast:@"Params Error"];
            return;
        }
        MKCKOtherBlockPayloadModel *dataModel = [[MKCKOtherBlockPayloadModel alloc] init];
        dataModel.dataType = (ValidStr(cellModel.dataType) ? cellModel.dataType : @"00");
        dataModel.start = [cellModel.start integerValue];
        dataModel.end = [cellModel.end integerValue];
        [list addObject:dataModel];
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithList:list sucBlock:^{
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
    for (NSInteger i = 0; i < self.dataModel.dataList.count; i ++) {
        NSDictionary *dic = self.dataModel.dataList[i];
        MKCKOtherDataBlockCellModel *cellModel = [[MKCKOtherDataBlockCellModel alloc] init];
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Data block %ld",(long)(i + 1)];
        cellModel.dataType = ([dic[@"dataType"] isEqualToString:@"00"] ? @"" : dic[@"dataType"]);
        cellModel.start = [NSString stringWithFormat:@"%@",dic[@"start"]];
        cellModel.end = [NSString stringWithFormat:@"%@",dic[@"end"]];
        [self.section1List addObject:cellModel];
    }
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"Raw data-Advertising";
    cellModel1.isOn = self.dataModel.advertising;
    [self.section2List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"Raw data-Response";
    cellModel2.isOn = self.dataModel.response;
    [self.section2List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Other type payload";
    [self.rightButton setImage:LOADICON(@"MKGatewayFour", @"MKCKOtherPayloadController", @"ck_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (MKCKOtherPayloadModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCKOtherPayloadModel alloc] init];
    }
    return _dataModel;
}

@end
