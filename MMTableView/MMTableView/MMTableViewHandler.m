//
//  MMTableViewHandler.m
//  EcoRobotSDK
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableViewHandler.h"
#import "MJExtension.h"
#import "MMCellModel.h"
#import "MMHelper.h"
#import "MMSectionModel.h"
#import "MMHelper.h"
#import <objc/message.h>

static NSString *TableConfigFileName = @"TableConfig";

@implementation MMTableViewHandler

- (MMTableViewInfo *)infoWithJSONDeviceClass:(NSString *)deviceClass {
    return [self infoWithJSONFileName:TableConfigFileName deviceClass:deviceClass];
}

- (MMTableViewInfo *)infoWithJSONFileName:(NSString *)filename {
    return [self infoWithJSONFileName:filename deviceClass:@"DefaultClass"];
}

- (MMTableViewInfo *)infoWithJSON {
    return [self infoWithJSONFileName:TableConfigFileName];
}

- (MMTableViewInfo *)infoWithJSON:(NSString *)json deviceClass:(NSString *)deviceClass{
    NSError *error = nil;
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    NSDictionary *robotClass = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    return [self infoWithDictionary:robotClass deviceClass:deviceClass];
}

- (MMTableViewInfo *)infoWithJSONFileName:(NSString *)filename deviceClass:(NSString *)deviceClass {
    NSString * path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSDictionary * robotClass = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [self infoWithDictionary:robotClass deviceClass:deviceClass];
}

- (MMTableViewInfo *)infoWithDictionary:(NSDictionary *)robotClass deviceClass:(NSString *)deviceClass {
    MMTableViewInfo *tableInfo = [[MMTableViewInfo alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (robotClass) {
        NSArray * items = robotClass[deviceClass] ? robotClass[deviceClass] : robotClass[@"DefaultClass"];
        [MMSectionModel mj_setupObjectClassInArray:^NSDictionary * {
            return @{@"data": [MMCellModel class]};
        }];
        
        
        NSArray * dataList = [MMSectionModel mj_objectArrayWithKeyValuesArray:items];
        NSAssert(dataList.count != 0, @"MMTableViewInfo Data Error");
        
        for (MMSectionModel *sectionModel in dataList) {
            MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo headerTitle:sectionModel.headerTitle footerTitle:sectionModel.footerTitle headerHeight:sectionModel.headerHeight footerHeight:sectionModel.footerHeight];
            if (sectionModel.data.count > 0) {
                for (MMCellModel *cellModel in sectionModel.data) {
                    MMTableViewCellInfo *cellInfo = nil;
                    
                    NSString * title = cellModel.title;
                    NSString * subTitle = cellModel.subTitle;
                    
                    if (cellModel.isSiwtch) {
                        cellInfo = [MMTableViewCellInfo switchCellTitle:title switchChanged:^(BOOL isON, UISwitch *switchButton) {
                            NSString * selectorName = [MMHelper responseSelectorName:cellModel.switchSelectorName];
                            selectorName = [NSString stringWithFormat:@"%@switchButton:", selectorName];
                            if (![MMHelper isBlankString:selectorName]) {
                                SEL sel = NSSelectorFromString(selectorName);
                                ((void (*)(id, SEL, BOOL isON, UISwitch *switchButton)) (void *) objc_msgSend)(self.delegate, sel, isON, switchButton);
                            }
                            
                            
                        } complete:^(UITableView *tableView, NSIndexPath *indexPath, MMTableViewCellInfo *info, MMTableViewCell *cell) {
                            NSString * selectorName = [MMHelper responseSelectorName:cellModel.cellForRowIndexSelectorName];
                            if (![MMHelper isBlankString:selectorName]) {
                                SEL sel = NSSelectorFromString(selectorName);
                                ((void (*)(id, SEL, UITableView *tableView, NSIndexPath *indexPath, MMTableViewCellInfo *info, MMTableViewCell *cell)) (void *) objc_msgSend)(self.delegate, sel, tableView, indexPath, info, cell);
                            }
                            
                        }];
                        cellInfo.delegate = self.delegate;
                    } else {
                        cellInfo = [MMTableViewCellInfo normalCellTitle:title subTitle:subTitle didSelected:^(UITableView *tableView, NSIndexPath *indexPath) {
                            NSString * selectorName = [MMHelper responseSelectorName:cellModel.didSelectorName];
                            
                            if (![MMHelper isBlankString:selectorName]) {
                                if ([MMHelper isRouter:cellModel.didSelectorName]) {
                                    SEL sel = sel_registerName("jumpToRouter:");
                                    ((void (*)(id, SEL, NSString *router)) (void *) objc_msgSend)(self.delegate, sel, selectorName);
                                    
                                } else {
                                    SEL sel = NSSelectorFromString(selectorName);
                                    ((void (*)(id, SEL)) (void *) objc_msgSend)(self.delegate, sel);
                                }
                            }
                            
                        } complete:^(UITableView *tableView, NSIndexPath *indexPath, MMTableViewCellInfo *info, MMTableViewCell *cell) {
                            NSString * selectorName = [MMHelper responseSelectorName:cellModel.cellForRowIndexSelectorName];
                            if (![MMHelper isBlankString:selectorName]) {
                                SEL sel = NSSelectorFromString(selectorName);
                                ((void (*)(id, SEL, UITableView *tableView, NSIndexPath *indexPath, MMTableViewCellInfo *info, MMTableViewCell *cell)) (void *) objc_msgSend)(self.delegate, sel, tableView, indexPath, info, cell);
                            }
                        }];
                        cellInfo.delegate = self.delegate;
                    }
                    [cellInfo setAccessoryType:cellModel.isAccessory?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone];
                    [sectionInfo addCell:cellInfo];
                }
            }
            
            [tableInfo addSection:sectionInfo];
        }
        
        return tableInfo;
    }
    return nil;
}


@end
