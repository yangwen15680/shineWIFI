//
//  AppDelegate.h
//  udp
//
//  Created by jakey on 14-2-26.
//  Copyright (c) 2014年 jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
#define kOnGotDeviceByScan              @"kOnGotDeviceByScan"

@property (strong, nonatomic) UIWindow *window;
@property(strong) Reachability *reach;

-(NSString *)getWifiName;

@end
