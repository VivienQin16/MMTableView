//
//  MMHelper.m
//  MMTableView
//
//  Created by Allen on 2017/11/9.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "MMHelper.h"
#import <objc/message.h>

@implementation MMHelper
+ (NSString *)dynamicProperty:(NSString *)title delegate:(id)delegate {
    if ([self isSelector:title]) {
        NSString * selector = [self responseSelectorName:title];
        if (![MMHelper isBlankString:selector]) {
            SEL sel = NSSelectorFromString(selector);
            NSString * value = ((NSString *(*)(id, SEL)) (void *) objc_msgSend)(delegate, sel);
            return value;
        }

    }

    return title;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@"null"] || [string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


+ (BOOL)isRouter:(NSString *)selectorName {
    if (!selectorName || [selectorName isEqualToString:@""] || selectorName.length < 2) {
        return nil;
    }
    NSString * prefix = [selectorName substringToIndex:1];
    if ([prefix isEqualToString:@"R"]) {
        return YES;
    }

    return NO;

}

+ (BOOL)isSelector:(NSString *)selectorName {
    if (!selectorName || [selectorName isEqualToString:@""] || selectorName.length < 2) {
        return NO;
    }

    NSString * prefix = [selectorName substringToIndex:1];
    if ([prefix isEqualToString:@"M"]) {
        return YES;
    }

    return NO;
}

+ (NSString *)responseSelectorName:(NSString *)selectorName {
    if (!selectorName || [selectorName isEqualToString:@""] || selectorName.length < 2) {
        return nil;
    }

    NSString * prefix = [selectorName substringToIndex:1];
    if ([prefix isEqualToString:@"M"]) {
        NSString * sel = [selectorName substringFromIndex:2];

        return sel;


    } else if ([prefix isEqualToString:@"R"]) {
        NSString * router = [selectorName substringFromIndex:2];
        return router;
    }

    return nil;
}

@end
