//
//  MKCKPayloadItemsController.m
//  MKGatewayFour_Example
//
//  Created by aa on 2023/12/28.
//  Copyright © 2023 lovexiaoxia. All rights reserved.
//

#import "MKCKPayloadItemsController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"

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


@interface MKCKPayloadItemsController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKCKPayloadItemsController

- (void)dealloc {
    NSLog(@"MKCKPayloadItemsController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
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
        //BXP-PIR payload
        MKCKPirPayloadController *vc = [[MKCKPirPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 10) {
        //MK TOF payload
        MKCKTofPayloadController *vc = [[MKCKTofPayloadController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 11) {
        //Other type payload
        MKCKOtherPayloadController *vc = [[MKCKOtherPayloadController alloc] init];
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

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"iBeacon";
    cellModel1.showRightIcon = YES;
    [self.dataList addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Eddystone-UID";
    cellModel2.showRightIcon = YES;
    [self.dataList addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Eddystone-URL";
    cellModel3.showRightIcon = YES;
    [self.dataList addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Eddystone-TLM";
    cellModel4.showRightIcon = YES;
    [self.dataList addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"BXP-Device info";
    cellModel5.showRightIcon = YES;
    [self.dataList addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.leftMsg = @"BXP–ACC";
    cellModel6.showRightIcon = YES;
    [self.dataList addObject:cellModel6];
    
    MKNormalTextCellModel *cellModel7 = [[MKNormalTextCellModel alloc] init];
    cellModel7.leftMsg = @"BXP–T&H";
    cellModel7.showRightIcon = YES;
    [self.dataList addObject:cellModel7];
    
    MKNormalTextCellModel *cellModel8 = [[MKNormalTextCellModel alloc] init];
    cellModel8.leftMsg = @"BXP–Button";
    cellModel8.showRightIcon = YES;
    [self.dataList addObject:cellModel8];
    
    MKNormalTextCellModel *cellModel9 = [[MKNormalTextCellModel alloc] init];
    cellModel9.leftMsg = @"BXP–Tag";
    cellModel9.showRightIcon = YES;
    [self.dataList addObject:cellModel9];
    
    MKNormalTextCellModel *cellModel10 = [[MKNormalTextCellModel alloc] init];
    cellModel10.leftMsg = @"PIR Presence";
    cellModel10.showRightIcon = YES;
    [self.dataList addObject:cellModel10];
    
    MKNormalTextCellModel *cellModel11 = [[MKNormalTextCellModel alloc] init];
    cellModel11.leftMsg = @"MK TOF";
    cellModel11.showRightIcon = YES;
    [self.dataList addObject:cellModel11];
    
    MKNormalTextCellModel *cellModel12 = [[MKNormalTextCellModel alloc] init];
    cellModel12.leftMsg = @"Other type";
    cellModel12.showRightIcon = YES;
    [self.dataList addObject:cellModel12];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Payload items settings";
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

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
