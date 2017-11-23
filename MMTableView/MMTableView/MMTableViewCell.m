//
//  MMTableViewCell.m
//  EcoRobotSDK
//
//  Created by Allen on 2017/11/7.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "MMTableViewCell.h"
#import "Masonry.h"
#import "MMHelper.h"
#import "UIColor+Hex.h"

@interface MMTableViewCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subTitleLabel;
@property(nonatomic, strong) MMTableViewCellSwitchEvent event;
@property(nonatomic, strong) UISwitch *switchButton;
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation MMTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self setupLayout];
    }

    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.switchButton];
    [self.contentView addSubview:self.indicatorView];
}

- (void)setupLayout {
    __weak typeof(self) weakself = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.contentView).mas_offset(15);
        make.centerY.mas_equalTo(weakself.contentView);
    }];

    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(weakself.contentView);
    }];

    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.contentView);
        make.right.mas_equalTo(weakself.contentView).mas_offset(-13);
    }];

    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself.contentView);
    }];
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.hidden = YES;
    }

    return _indicatorView;
}

- (UISwitch *)switchButton {
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] init];
        [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }

    return _switchButton;
}

- (void)switchAction:(id)sender {
    UISwitch *swithButton = (UISwitch *) sender;
    if (self.event) {
        self.event([swithButton isOn], swithButton);
    }
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textColor = [UIColor colorWithCSS:@"999999"];
        _subTitleLabel.font = [UIFont systemFontOfSize:17];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subTitleLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithCSS:@"253746"];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (void)tableViewCellInfo:(MMTableViewCellInfo *)cellInfo completeHandler:(MMTableViewCellSwitchEvent)event {
    self.titleLabel.text = [MMHelper dynamicProperty:NSLocalizedString(cellInfo.title, nil) delegate:cellInfo.delegate];
    
    if (cellInfo.subTitleBlock) {
        self.subTitleLabel.text = cellInfo.subTitleBlock();
    }else {
        self.subTitleLabel.text = [MMHelper dynamicProperty:NSLocalizedString(cellInfo.subTitle, nil) delegate:cellInfo.delegate];
    }
    
    self.subTitleLabel.hidden = cellInfo.isSiwtch;
    self.switchButton.hidden = !cellInfo.isSiwtch;
    self.event = event;
    [self setAccessoryType:cellInfo.accessoryType];

}

- (void)startIndicatorView {
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    [self setUserInteractionEnabled:NO];
}

- (void)stopIndicatorView {
    [self.indicatorView stopAnimating];
    [self setUserInteractionEnabled:YES];

}

- (void)changeSwitchStatus:(BOOL)isOn {
    [self.switchButton setOn:isOn animated:YES];
}


@end
