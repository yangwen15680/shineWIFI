//
//  AddDeviceViewController.h
//  smartYogurtMaker
//
//  Created by mqw on 15/6/3.
//  Copyright (c) 2015年 mqw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


#import "ACPButton.h"
#import "SIAlertView.h"


@interface AddDeviceViewController : UIViewController
{
    Boolean isSearching ;
    SIAlertView * myAlertView;
}



@property (strong, nonatomic) IBOutlet UITextField *ipName;
@property (strong, nonatomic) IBOutlet UITextField *pswd;
@property (strong, nonatomic) IBOutlet UISwitch *pswdShow;

@property (weak, nonatomic) IBOutlet ACPButton *addDeviceBtn;

@property (nonatomic, strong) NSMutableArray *deviceArray;//接收所有可控制设备的信息

@property (assign) Boolean autoGoinTaG;
@end
