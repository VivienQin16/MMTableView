//
//  MMTableViewSectionInfo.h
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTableViewCellInfo.h"

@interface MMTableViewSectionInfo : NSObject
@property(nonatomic, strong) NSMutableArray *cells;
@property(nonatomic, strong) NSString *headerTitle;
@property(nonatomic, strong) NSString *footerTitle;
@property(nonatomic, strong) NSNumber *footerHeight;
@property(nonatomic, strong) NSNumber *headerHeight;
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UIView *footerView;


+ (instancetype)sectionInfoDefaut;

+ (instancetype)headerTitle:(NSString *)headerTitle;

+ (instancetype)headerView:(UIView *)headerView footerView:(UIView *)footerView;

+ (instancetype)headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

+ (instancetype)headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle headerHeight:(NSNumber *)headerHeight footerHeight:(NSNumber *)footerHeight;

- (void)addCell:(MMTableViewCellInfo *)cell;

- (void)removeCellAtIndex:(NSInteger)index;

- (void)removeAllCells;

- (void)replaceCellAtIndex:(NSInteger)index withCell:(MMTableViewCellInfo *)cellInfo;

@end
