//
//  ViewController.m
//  MMTableView
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "ViewController.h"
#import "MMTableViewController.h"
#import "Masonry.h"
#import "MMTableView.h"
#import "MMTableViewSectionInfo.h"
#import "MMTableViewCell.h"
#import "MMTableViewInfo.h"
@interface ViewController ()
@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MMTableView *tableView = [self.tableViewInfo getTableView];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo headerTitle:@"" footerTitle:@""];
    
    __weak typeof(self) weakSelf = self;
    MMTableViewCellInfo *normalCellInfo = [MMTableViewCellInfo normalCellTitle:@"DM3" subTitle:@"" didSelected:^(UITableView *tableView, NSIndexPath *indexPath) {
        MMTableViewController *vc = [[MMTableViewController alloc] initWithDeviceName:@"DM3DeviceName"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } complete:nil];
    [normalCellInfo setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [sectionInfo addCell:normalCellInfo];

    
    MMTableViewCellInfo *powerCellInfo = [MMTableViewCellInfo normalCellTitle:@"DG720" subTitle:@""  didSelected:^(UITableView *tableView, NSIndexPath *indexPath) {
        MMTableViewController *vc = [[MMTableViewController alloc] initWithDeviceName:@"DF35DeviceName"];
        [vc registerHandler:weakSelf];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } complete:nil];
    [powerCellInfo setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [sectionInfo addCell:powerCellInfo];

    [self.tableViewInfo addSection:sectionInfo];
    [self.tableViewInfo reloadMMTableView];

}

- (MMTableViewInfo *)tableViewInfo {
    if (!_tableViewInfo) {
        _tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    
    return _tableViewInfo;
}



#pragma mark - 自已实现某些特殊的功能
- (void)closeSched:(BOOL)isOn switchButton:(UISwitch *)switchButton{
    //模拟失败的情况
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [switchButton setOn:!isOn animated:YES];
    });
}




@end
