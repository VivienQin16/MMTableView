//
//  MMSectionModel.h
//  MMTableView
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCellModel.h"

@interface MMSectionModel : NSObject
@property(nonatomic, strong) NSString *headerTitle;
@property(nonatomic, strong) NSString *footerTitle;
@property(nonatomic, strong) NSNumber *headerHeight;
@property(nonatomic, strong) NSNumber *footerHeight;
@property(nonatomic, strong) NSArray *data;

@end
