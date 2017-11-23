//
//  MMTableViewSectionInfo.m
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableViewSectionInfo.h"

@interface MMTableViewSectionInfo ()

@end


@implementation MMTableViewSectionInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _cells = [[NSMutableArray alloc] init];
        _footerTitle = @"";
        _headerTitle = @"";
        _headerHeight = @20;
        _footerHeight = @20;
    }

    return self;
}

+ (instancetype)headerView:(UIView *)headerView footerView:(UIView *)footerView {
    MMTableViewSectionInfo *sectionInfo = [[MMTableViewSectionInfo alloc] init];
    sectionInfo.headerView = headerView;
    sectionInfo.footerView = footerView;
    sectionInfo.footerHeight = [NSNumber numberWithFloat:CGRectGetHeight(footerView.frame)];
    sectionInfo.headerHeight = [NSNumber numberWithFloat:CGRectGetHeight(headerView.frame)];
    return sectionInfo;
}

+ (instancetype)sectionInfoDefaut {
    return [[MMTableViewSectionInfo alloc] init];
}

- (void)removeCellAtIndex:(NSInteger)index {
    if (_cells && _cells.count > index) {
        [[self mutableArrayValueForKey:@"cells"] removeObjectAtIndex:index];
    }
}

- (void)replaceCellAtIndex:(NSInteger)index withCell:(MMTableViewCellInfo *)cellInfo {
    if (_cells && _cells.count > index) {
        [[self mutableArrayValueForKey:@"cells"] replaceObjectAtIndex:index withObject:cellInfo];
    }
}

- (void)removeAllCells {
    [[self mutableArrayValueForKey:@"cells"] removeAllObjects];
}

+ (instancetype)headerTitle:(NSString *)headerTitle {
    MMTableViewSectionInfo *sectionInfo = [[MMTableViewSectionInfo alloc] init];
    sectionInfo.headerTitle = headerTitle;
    return sectionInfo;
}

+ (instancetype)headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle {
    MMTableViewSectionInfo *sectionInfo = [[MMTableViewSectionInfo alloc] init];
    sectionInfo.headerTitle = headerTitle;
    sectionInfo.footerTitle = footerTitle;
    return sectionInfo;
}

+ (instancetype)headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle headerHeight:(NSNumber *)headerHeight footerHeight:(NSNumber *)footerHeight {
    MMTableViewSectionInfo *sectionInfo = [[MMTableViewSectionInfo alloc] init];
    sectionInfo.headerTitle = headerTitle;
    sectionInfo.footerTitle = footerTitle;
    sectionInfo.footerHeight = footerHeight;
    sectionInfo.headerHeight = headerHeight;
    return sectionInfo;
}

- (void)addCell:(MMTableViewCellInfo *)cell {
    [[self mutableArrayValueForKey:@"cells"] addObject:cell];
}


@end
