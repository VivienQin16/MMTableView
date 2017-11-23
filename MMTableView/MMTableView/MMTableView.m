//
//  MMTableView.m
//  EcoRobotSDK
//
//  Created by 张艾伦 on 2017/10/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableView.h"

@implementation MMTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:243 / 255.0 alpha:1.0];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }

    return self;
}

@end
