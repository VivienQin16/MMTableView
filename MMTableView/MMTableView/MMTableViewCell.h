//
//  MMTableViewCell.h
//  EcoRobotSDK
//
//  Created by Allen on 2017/11/7.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTableViewCellInfo.h"

@interface MMTableViewCell : UITableViewCell

- (void)tableViewCellInfo:(MMTableViewCellInfo *)cellInfo completeHandler:(MMTableViewCellSwitchEvent)event;

- (void)startIndicatorView;

- (void)stopIndicatorView;

- (void)changeSwitchStatus:(BOOL)isOn;
@end
