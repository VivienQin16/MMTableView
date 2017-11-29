//
//  MMTableViewHandler.h
//  EcoRobotSDK
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTableViewInfo.h"

@interface MMTableViewHandler : NSObject
@property(nonatomic, assign) id delegate;

- (MMTableViewInfo *)infoWithJSON;

- (MMTableViewInfo *)infoWithJSON:(NSString *)json deviceClass:(NSString *)deviceClass;

- (MMTableViewInfo *)infoWithDictionary:(NSDictionary *)robotClass deviceClass:(NSString *)deviceClass;

- (MMTableViewInfo *)infoWithJSONFileName:(NSString *)filename;

- (MMTableViewInfo *)infoWithJSONFileName:(NSString *)filename deviceClass:(NSString *)deviceClass;

- (MMTableViewInfo *)infoWithJSONDeviceClass:(NSString *)deviceClass;
@end
