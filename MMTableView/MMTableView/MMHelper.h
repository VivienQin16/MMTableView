//
//  MMHelper.h
//  MMTableView
//
//  Created by Allen on 2017/11/9.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMHelper : NSObject
+ (NSString *)dynamicProperty:(NSString *)title delegate:(id)delegate;

+ (BOOL)isSelector:(NSString *)selectorName;

+ (NSString *)responseSelectorName:(NSString *)selectorName;

+ (BOOL)isRouter:(NSString *)selectorName;

+ (BOOL)isBlankString:(NSString *)string;
@end
