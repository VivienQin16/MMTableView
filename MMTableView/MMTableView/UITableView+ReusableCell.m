//
//  UITableView+ReusableCell.m
//  MMTableView
//
//  Created by Allen on 2017/11/20.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "UITableView+ReusableCell.h"

@implementation UITableView (ReusableCell)
- (__kindof UITableViewCell *)mm_dequeueReusableCellWithClass:(Class)className {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(className)];
}
@end
