//
//  UITableView+ReusableCell.h
//  MMTableView
//
//  Created by Allen on 2017/11/20.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ReusableCell)
- (__kindof UITableViewCell *)mm_dequeueReusableCellWithClass:(Class)className;
@end
