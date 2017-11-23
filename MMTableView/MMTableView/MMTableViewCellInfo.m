//
//  MMTableViewCellInfo.m
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableViewCellInfo.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation MMTableViewCellInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = 44;
        _selectionStyle = UITableViewCellSelectionStyleDefault;
        _accessoryType = UITableViewCellAccessoryNone;
    }

    return self;
}

+ (instancetype)normalCellForTitle:(NSString *)title subTitle:(NSString *)subTitle {
    return [self normalCellTitle:title subTitle:subTitle didSelected:nil];
}


+ (instancetype)normalCellTitle:(NSString *)title subTitle:(NSString *)subTitle didSelected:(MMTableViewCellEvent)event {
    return [self normalCellTitle:title subTitle:subTitle didSelected:event complete:nil];
}

+ (instancetype)normalCellTitle:(NSString *)title subTitle:(NSString *)subTitle didSelected:(MMTableViewCellEvent)event complete:(MMTableViewCellBlock)block {
    MMTableViewCellInfo *cellinfo = [[MMTableViewCellInfo alloc] init];
    cellinfo.title = title;
    cellinfo.subTitle = subTitle;
    cellinfo.didSelectedEvent = event;
    cellinfo.block = block;
    return cellinfo;
}

+ (instancetype)cellForRowIndexPathBlock:(MMCustomTableviewCellBlock)block height:(CGFloat)height didSelected:(MMTableViewCellEvent)event {
    return [self cellForRowIndexPathBlock:block height:height delegate:nil didSelected:event];
}

+ (instancetype)cellForRowIndexPathBlock:(MMCustomTableviewCellBlock)block height:(CGFloat)height delegate:(id)delegate didSelected:(MMTableViewCellEvent)event {
    MMTableViewCellInfo *cellinfo = [[MMTableViewCellInfo alloc] init];
    cellinfo.customBlock = block;
    cellinfo.height = height;
    cellinfo.didSelectedEvent = event;
    cellinfo.delegate = delegate;
    return cellinfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title subTitleBlock:(SubtTitleBlock)block didSelected:(MMTableViewCellEvent)event {
    MMTableViewCellInfo *cellInfo = [self normalCellTitle:title subTitle:@"" didSelected:event complete:nil];
    cellInfo.subTitleBlock = block;
    return cellInfo;
}

+ (instancetype)normalCellForTitle:(NSString *)title subTitleSelector:(SEL)selector delegate:(id)delegate didSelected:(MMTableViewCellEvent)event {
    NSString * subTitle = [NSString stringWithFormat:@"M@%@", NSStringFromSelector(selector)];
    MMTableViewCellInfo *cellInfo = [self normalCellTitle:title subTitle:subTitle didSelected:event];
    cellInfo.delegate = delegate;
    return cellInfo;
}

+ (instancetype)switchCellTitle:(NSString *)title switchChanged:(MMTableViewCellSwitchEvent)event complete:(MMTableViewCellBlock)block {
    MMTableViewCellInfo *cellinfo = [[MMTableViewCellInfo alloc] init];
    cellinfo.title = title;
    cellinfo.subTitle = @"";
    cellinfo.switchEvent = event;
    cellinfo.isSiwtch = YES;
    cellinfo.block = block;
    return cellinfo;
}

- (void)commitEditBlock:(MMTableViewCellEditBlock)editblock {
    self.editBlock = editblock;
}


@end
