//
//  MMTableViewController.h
//  MMTableView
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTableViewController : UIViewController

- (instancetype)initWithDeviceName:(NSString *)deviceName;

- (void)registerHandler:(id)delegate;
@end
