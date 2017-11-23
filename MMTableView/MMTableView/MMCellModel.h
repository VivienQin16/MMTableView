//
//  MMTableModel.h
//  MMTableView
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMCellModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subTitle;
@property(nonatomic, assign) BOOL isAccessory;
@property(nonatomic, assign) BOOL isSiwtch;
@property(nonatomic, strong) NSString *didSelectorName;
@property(nonatomic, strong) NSString *switchSelectorName;
@property(nonatomic, strong) NSString *cellForRowIndexSelectorName;
@end
