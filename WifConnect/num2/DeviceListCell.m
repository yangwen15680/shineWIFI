//
//  DeviceListCell.m
//  SuperSmart
//
//  Created by gicisky on 15/9/2.
//  Copyright (c) 2015年 gicisky. All rights reserved.
//

#import "DeviceListCell.h"

@interface DeviceListCell ()
@property (strong, nonatomic) IBOutlet UILabel *deviceName;
@end

@implementation DeviceListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDeviceData:(NSString *)macDevice {
       if (!_deviceData.authKey || [_deviceData.authKey isEqualToString:@""]) {
        //显示未激活
        [self setNameTitle:@"未激活"];
        [self showNotSetAuthKey];
        _macAdress.hidden = YES;
        _macAdressT.hidden = YES;
        return;
    }
    _macAdress.hidden = NO;
    _macAdressT.hidden = NO;
    [self setAuthKeyOff];
    _progressView.center = _deviceName.center;
    if (_deviceData.connectionStatus == DeviceStatues_Conected) {
        [self setNameTitle:@"在线"];
//        [self setlockStutedOn];
    } else if (_deviceData.connectionStatus == DeviceStatues_Unconected){
        [self setNameTitle:@"离线"];
//        [self setlockStutedOff];
    } else {
        [self setNameTitle:@"连接中"];
//        [self setlockStutedOff];
    }
//    if (_deviceData.lockDic) {
//        [self setLockBtnStyleFor:_deviceData];
//    }
//    if (_deviceData.lockNameDic) {
//        [self setNewLockNameForDevice:_deviceData];
//    }
    
}

- (void)setNameTitle:(NSString *)stutedStr {
    NSString *newStutesStr = [NSString stringWithFormat:@"(%@)", stutedStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[_deviceData.deviceName stringByAppendingString:newStutesStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([_deviceData.deviceName length], [newStutesStr length])];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange([_deviceData.deviceName length], [newStutesStr length])];
    _deviceName.attributedText = str;
}





#pragma mark - 显示未激活状态
- (void)showNotSetAuthKey {

    [self setAuthKeyOn];
    [self setlock1Off];
    [self setlock2Off];
    [self setlock3Off];
}

#pragma mark - 门锁名称
- (void)setNewLockNameForDevice:(MyDevice *)device {
    _label1.text = [device.lockNameDic objectForKey:@"lock1"];
    _label2.text = [device.lockNameDic objectForKey:@"lock2"];
    _label3.text = [device.lockNameDic objectForKey:@"lock3"];
}


#pragma mark - HandleSet

- (void)setlockStutedOn {
    _img1.image = [UIImage imageNamed:@"lock_one"];
    _img2.image = [UIImage imageNamed:@"lock_two"];
    _img3.image = [UIImage imageNamed:@"lock_three"];
    _lockBtn1.userInteractionEnabled = YES;
    _lockBtn2.userInteractionEnabled = YES;
    _lockBtn3.userInteractionEnabled = YES;
}

- (void)setlockStutedOff {
    _img1.image = [UIImage imageNamed:@"lock_one_no"];
    _img2.image = [UIImage imageNamed:@"lock_two_no"];
    _img3.image = [UIImage imageNamed:@"lock_three_no"];
    _lockBtn1.userInteractionEnabled = NO;
    _lockBtn2.userInteractionEnabled = NO;
    _lockBtn3.userInteractionEnabled = NO;
}

- (void)setlock1On {
    _lockBtn1.hidden = NO;
    _img1.hidden = NO;
    _label1.hidden = NO;
}

- (void)setlock2On {
    _lockBtn2.hidden = NO;
    _img2.hidden = NO;
    _label2.hidden = NO;
}

- (void)setlock3On {
    _lockBtn3.hidden = NO;
    _img3.hidden = NO;
    _label3.hidden = NO;
}

- (void)setlock1Off {
    _lockBtn1.hidden = YES;
    _img1.hidden = YES;
    _label1.hidden = YES;
}

- (void)setlock2Off {
    _lockBtn2.hidden = YES;
    _img2.hidden = YES;
    _label2.hidden = YES;
}

- (void)setlock3Off {
    _lockBtn3.hidden = YES;
    _img3.hidden = YES;
    _label3.hidden = YES;
}

- (void)setAuthKeyOn {
    _hintLabel.hidden = NO;
    _setAuthkeyBtn.hidden = NO;
    _clickEditDeviceInfo.tag = 10020;
    [_clickEditDeviceInfo setTitle:@"删除" forState:UIControlStateNormal];
}

- (void)setAuthKeyOff {
    _hintLabel.hidden = YES;
    _setAuthkeyBtn.hidden = YES;
    _clickEditDeviceInfo.tag = 10020;
    [_clickEditDeviceInfo setTitle:@"删除" forState:UIControlStateNormal];
//    _clickEditDeviceInfo.tag = 10021;
//    [_clickEditDeviceInfo setTitle:@"编辑" forState:UIControlStateNormal];
}

- (void)setimg1On {
    [_img1 setImage:[UIImage imageNamed:@"lock_one"]];
}
- (void)setimg1Off {
    [_img1 setImage:[UIImage imageNamed:@"lock_one_no"]];
}

- (void)setimg2On {
    [_img2 setImage:[UIImage imageNamed:@"lock_two"]];
}
- (void)setimg2Off {
    [_img2 setImage:[UIImage imageNamed:@"lock_two_no"]];
}

- (void)setimg3On {
    [_img3 setImage:[UIImage imageNamed:@"lock_three"]];
}
- (void)setimg3Off {
    [_img3 setImage:[UIImage imageNamed:@"lock_three_no"]];
}
- (void)setlock1Frame {
    _lockBtn1.frame = CGRectMake(35, 70, 60, 60);
    _img1.frame = CGRectMake(40, 70, 50, 50);
    _label1.frame = CGRectMake(20, 120, 90, 20);
}

- (void)setlock21Frame {
    _lockBtn2.frame = CGRectMake(35, 70, 60, 60);
    _img2.frame = CGRectMake(40, 70, 50, 50);
    _label2.frame = CGRectMake(20, 120, 90, 20);
}

- (void)setlock22Frame {
    _lockBtn2.frame = CGRectMake(130, 70, 60, 60);
    _img2.frame = CGRectMake(135, 70, 50, 50);
    _label2.frame = CGRectMake(115, 120, 90, 20);
}

- (void)setlock31Frame {
    _lockBtn3.frame = CGRectMake(35, 70, 60, 60);
    _img3.frame = CGRectMake(40, 70, 50, 50);
    _label3.frame = CGRectMake(20, 120, 90, 20);
}

- (void)setlock32Frame {
    _lockBtn3.frame = CGRectMake(130, 70, 60, 60);
    _img3.frame = CGRectMake(135, 70, 50, 50);
    _label3.frame = CGRectMake(115, 120, 90, 20);
}

- (void)setlock33Frame {
    _lockBtn3.frame = CGRectMake(225, 70, 60, 60);
    _img3.frame = CGRectMake(230, 70, 50, 50);
    _label3.frame = CGRectMake(210, 120, 90, 20);
}
@end
