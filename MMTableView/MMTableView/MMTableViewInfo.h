//
//  MMTableViewInfo.h
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTableView.h"
#import "MMTableViewSectionInfo.h"

@interface MMTableViewInfo : NSObject
@property(nonatomic, strong) NSMutableArray *sections;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (MMTableView *)getTableView;

- (void)addSection:(MMTableViewSectionInfo *)secion;

- (void)addSections:(NSArray *)sections;

- (void)removeAllSection;

- (void)removeSectionAtIndex:(NSInteger)index;

- (void)registerClassName:(Class)className;

- (void)reloadMMTableView;

- (void)reloadMMTableView:(NSArray *)sections;
@end
