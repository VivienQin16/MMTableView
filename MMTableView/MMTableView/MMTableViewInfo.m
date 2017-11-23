//
//  MMTableViewInfo.m
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableViewInfo.h"
#import "MMTableViewCell.h"
#import "MMTableViewCell.h"
#import "Masonry.h"
#import "UITableView+ReusableCell.h"
#define DEFAULT_CELL_HEIGHT 30

@interface MMTableViewInfo () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) MMTableView *tableView;
@end

@implementation MMTableViewInfo

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _tableView = [[MMTableView alloc] initWithFrame:frame style:style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MMTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MMTableViewCell class])];
    }

    return self;
}

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return _sections;
}

- (void)reloadMMTableView {
    [_tableView reloadData];
}

- (void)reloadMMTableView:(NSArray *)sections {
    [self removeAllSection];
    [self.sections addObjectsFromArray:sections];
    [self.tableView reloadData];
}

- (void)registerClassName:(Class)className {
    [_tableView registerClass:className forCellReuseIdentifier:NSStringFromClass(className)];
}

- (MMTableView *)getTableView {
    return _tableView;
}

- (void)addSection:(MMTableViewSectionInfo *)secion {
    [[self mutableArrayValueForKey:@"sections"] addObject:secion];

}

- (void)removeAllSection {
    [[self mutableArrayValueForKey:@"sections"] removeAllObjects];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    return sectionInfo.cells.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    NSString * headerTitle = NSLocalizedString(sectionInfo.headerTitle, nil);
    return headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    UIView *view = sectionInfo.headerView;
    if (view) {
        return [sectionInfo.headerHeight floatValue];
    }

//    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
//    if ([sectionTitle isEqualToString:@""] || !sectionTitle){
//        return 0.01;
//    }

    CGFloat height = [sectionInfo.headerHeight floatValue] == 0 ? DEFAULT_CELL_HEIGHT : [sectionInfo.headerHeight floatValue];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSString * sectionTitle = [self tableView:tableView titleForFooterInSection:section];
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    UIView *view = sectionInfo.footerView;
    if (view) {
        return [sectionInfo.footerHeight floatValue];
    }

    if ([sectionTitle isEqualToString:@""] || !sectionTitle) {
        return 0.01;
    }

    CGFloat height = [sectionInfo.footerHeight floatValue] == 0 ? DEFAULT_CELL_HEIGHT : [sectionInfo.footerHeight floatValue];
    return height;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString * sectionTitle = [self tableView:tableView titleForFooterInSection:section];
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    UIView *view = sectionInfo.footerView;
    //如果有配置的View，就返回该View
    if (view) {
        return view;
    }

    if (sectionTitle == nil || [sectionTitle isEqualToString:@""]) {
        return nil;
    }
    CGFloat height = [sectionInfo.footerHeight floatValue] == 0 ? DEFAULT_CELL_HEIGHT : [sectionInfo.footerHeight floatValue];
    return [self customeHFView:sectionTitle height:height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString * sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    UIView *view = sectionInfo.headerView;
    //如果有配置的View，就返回该View
    if (view) {
        return view;
    }

    if (sectionTitle == nil || [sectionTitle isEqualToString:@""]) {
        return nil;
    }
    CGFloat height = [sectionInfo.headerHeight floatValue] == 0 ? DEFAULT_CELL_HEIGHT : [sectionInfo.headerHeight floatValue];
    return [self customeHFView:sectionTitle height:height];
}

- (UIView *)customeHFView:(NSString *)title height:(CGFloat)height {
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor lightGrayColor];
    label.text = title;

    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(15);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(label.font.lineHeight);
    }];

    return view;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    MMTableViewSectionInfo *sectionInfo = _sections[section];
    NSString * footerTitle = NSLocalizedString(sectionInfo.footerTitle, nil);
    return footerTitle;
}

- (void)addSections:(NSArray *)sections {
    if (sections && sections.count > 0) {
        [_sections addObjectsFromArray:sections];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMTableViewSectionInfo *sectionInfo = _sections[indexPath.section];
    MMTableViewCellInfo *cellInfo = sectionInfo.cells[indexPath.row];
    return cellInfo.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMTableViewSectionInfo *sectionInfo = _sections[indexPath.section];
    MMTableViewCellInfo *cellInfo = sectionInfo.cells[indexPath.row];

    if (cellInfo.customBlock) {
        return cellInfo.customBlock(tableView, indexPath);
    }

    MMTableViewCell *cell = [tableView mm_dequeueReusableCellWithClass:[MMTableViewCell class]];
    [cell setSelectionStyle:cellInfo.selectionStyle];
    [cell tableViewCellInfo:cellInfo completeHandler:^(BOOL isON, UISwitch *switchButton) {
        if (cellInfo.switchEvent) {
            cellInfo.switchEvent(isON, switchButton);
        }
    }];


    if (cellInfo.block) {
        cellInfo.block(tableView, indexPath, cellInfo, cell);
    }

    return cell;
}

- (void)removeSectionAtIndex:(NSInteger)index {
    if (_sections && _sections.count > index) {
        [[self mutableArrayValueForKey:@"sections"] removeObjectAtIndex:index];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MMTableViewSectionInfo *sectionInfo = _sections[indexPath.section];
    MMTableViewCellInfo *cellInfo = sectionInfo.cells[indexPath.row];
    if (cellInfo.didSelectedEvent) {
        cellInfo.didSelectedEvent(tableView, indexPath);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    MMTableViewSectionInfo *sectionInfo = _sections[indexPath.section];
    MMTableViewCellInfo *cellInfo = sectionInfo.cells[indexPath.row];
    if (cellInfo.editBlock) {
        return YES;
    }

    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    MMTableViewSectionInfo *sectionInfo = _sections[indexPath.section];
    MMTableViewCellInfo *cellInfo = sectionInfo.cells[indexPath.row];
    if (cellInfo.editBlock) {
        cellInfo.editBlock(tableView, editingStyle, indexPath);
    }
}


@end
