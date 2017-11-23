//
//  MMTableViewController.m
//  MMTableView
//
//  Created by Allen on 2017/11/8.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "MMTableViewController.h"
#import "MMTableViewHandler.h"
#import "MMTableViewInfo.h"
#import "Masonry.h"
#import "MMTableViewCell.h"
#import "MMHelper.h"

@interface MMTableViewController ()
@property(nonatomic, strong) MMTableViewInfo *tableInfo;
@property(nonatomic, strong) MMTableViewHandler *tableViewHandler;
@property(nonatomic, assign) id delegate;
@property(nonatomic, strong) NSString *deviceName;


@end

@implementation MMTableViewController

- (instancetype)initWithDeviceName:(NSString *)deviceName {
    self = [super init];
    if (self) {
        _deviceName = deviceName;
    }

    return self;
}

- (void)registerHandler:(id)delegate {
    self.delegate = delegate;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableInfo reloadMMTableView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    MMTableView *tableView = [self.tableInfo getTableView];
    [self.view addSubview:tableView];

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [tableView reloadData];
}

- (MMTableViewInfo *)tableInfo {
    if (!_tableInfo) {
        _tableInfo = [self.tableViewHandler infoWithJSONDeviceClass:self.deviceName];
    }

    return _tableInfo;
}

- (MMTableViewHandler *)tableViewHandler {
    if (!_tableViewHandler) {
        _tableViewHandler = [[MMTableViewHandler alloc] init];
        _tableViewHandler.delegate = self;
    }

    return _tableViewHandler;
}

- (NSString *)cleanState {
    return @"";//[ECORobotManager shared].cleanStatus;
}

- (NSString *)robotName {
    return @"DF35";
}

- (void)jumpToRouter:(NSString *)router {
    NSLog(@"jumpToRouter: %@", router);

    //测试用
    NSString * routerPath = [[router componentsSeparatedByString:@"//"] lastObject];
    UIViewController * vc = [[NSClassFromString(routerPath) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)findDevice {
    NSLog(@"findDevice");
}

- (void)closeRobot:(BOOL)isOn switchButton:(UISwitch *)switchButton {
    NSLog(@"closeRobot: %d", isOn);
}


//这个函数名可以随意写，但是参数的类型和数量是固定的，主要用于在每一个MMTableViewCell显示以后需要额外做的事情，一般不需要修改。
- (void)cleanTypeStatus:(MMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellInfo:(MMTableViewCellInfo *)info cell:(MMTableViewCell *)cell {
    //先判断要显示的数据是否存在，如果不存在再去加载
//    if ([MMHelper isBlankString:[ECORobotManager shared].cleanStatus]) {
//        [cell startIndicatorView];
//
//        //加载所需要的数据
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [ECORobotManager shared].cleanStatus = @"标准";
//            [cell stopIndicatorView];
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        });
//    }
}

//这个函数名可以随意写，但是参数的类型和数量是固定的，主要用于在每一个MMTableViewCell显示以后需要额外做的事情，一般不需要修改。
- (void)schedClosed:(MMTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellInfo:(MMTableViewCellInfo *)info cell:(MMTableViewCell *)cell {
    //查询开关状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cell changeSwitchStatus:YES];
    });
}


#pragma mark - 消息转发

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (self.delegate && [self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }

    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSString * sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0) {
        //动态造一个 setter函数
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        //动态造一个 getter函数
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

//如果你配置了一个不存的方法，就走这里生成一个，主要是防止闪退的，因为要做消息转发，所以Handler类里并没有判断此类有没有实现该方法
- (void)forwardInvocation:(NSInvocation *)invocation {
    //拿到函数名
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    NSString * key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0) {
        //setter函数形如 setXXX: 拆掉 set和冒号
        key = [[key substringWithRange:NSMakeRange(3, [key length] - 4)] lowercaseString];
        NSString * obj;
        //从参数列表中找到值
        [invocation getArgument:&obj atIndex:2];
        [data setObject:obj forKey:key];
    } else {
        //getter函数就相对简单了，直接把函数名做 key就好了。
        NSString * obj = [data objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}

@end
