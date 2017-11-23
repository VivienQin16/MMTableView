//
//  MMTableViewCellInfo.h
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MMTableViewCellInfo;
@class MMTableViewCell;

typedef void(^MMTableViewCellEvent)(UITableView *tableView, NSIndexPath *indexPath);

typedef void(^MMTableViewCellSwitchEvent)(BOOL isON, UISwitch *switchButton);

typedef void(^MMTableViewCellBlock)(UITableView *tableView, NSIndexPath *indexPath, MMTableViewCellInfo *info, MMTableViewCell *cell);

typedef void(^MMTableViewCellEditBlock)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);

typedef UITableViewCell *(^MMCustomTableviewCellBlock)(UITableView *tableView, NSIndexPath *indexPath);

typedef NSString *(^SubtTitleBlock)(void);

@interface MMTableViewCellInfo : NSObject
/**
 * 标题
 */
@property(nonatomic, strong) NSString *title;
/**
 * 右侧子标题
 */
@property(nonatomic, strong) NSString *subTitle;
/**
 * 同Cell中的selectionStyle
 */
@property(nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
/**
 * 同Cell中的accessoryType
 */
@property(nonatomic, assign) UITableViewCellAccessoryType accessoryType;
/**
 * 一般不设置，这个属性是给配置表格使用的
 */
@property(nonatomic, assign) id delegate;
/**
 * Cell的高度
 */
@property(nonatomic, assign) CGFloat height;
/**
 * 是否有Switch按钮
 */
@property(nonatomic, assign) BOOL isSiwtch;
/**
 * 点击表格时触发的方法
 */
@property(nonatomic, copy) MMTableViewCellEvent didSelectedEvent;
/**
 * 点击Switch时触发的方法
 */
@property(nonatomic, copy) MMTableViewCellSwitchEvent switchEvent;
/**
 * cellForRowAtIndexPath的钩子函数，如果需要在表格显示时额外做一些事情，可以实现这个Block
 */
@property(nonatomic, copy) MMTableViewCellBlock block;
/**
 * 自定义cell的显示
 */
@property(nonatomic, copy) MMCustomTableviewCellBlock customBlock;
/**
 * 目前仅支持删除
 */
@property(nonatomic, copy) MMTableViewCellEditBlock editBlock;
/**
 * 如果副标题需要复杂的计算时，实现该Block
 */
@property(nonatomic, copy) SubtTitleBlock subTitleBlock;

+ (instancetype)normalCellForTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)normalCellForTitle:(NSString *)title subTitleSelector:(SEL)selector delegate:(id)delegate didSelected:(MMTableViewCellEvent)event;

+ (instancetype)normalCellForTitle:(NSString *)title subTitleBlock:(SubtTitleBlock)block didSelected:(MMTableViewCellEvent)event;

+ (instancetype)normalCellTitle:(NSString *)title subTitle:(NSString *)subTitle didSelected:(MMTableViewCellEvent)event complete:(MMTableViewCellBlock)block;

+ (instancetype)switchCellTitle:(NSString *)title switchChanged:(MMTableViewCellSwitchEvent)event complete:(MMTableViewCellBlock)block;

+ (instancetype)cellForRowIndexPathBlock:(MMCustomTableviewCellBlock)block height:(CGFloat)height didSelected:(MMTableViewCellEvent)event;

- (void)commitEditBlock:(MMTableViewCellEditBlock)editblock;

@end
