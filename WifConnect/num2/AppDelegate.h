//
//  AppDelegate.h
//  SuperSmart
//
//  Created by gicisky on 15/9/2.
//  Copyright (c) 2015年 gicisky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOnGotDeviceByScan              @"kOnGotDeviceByScan"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;


-(NSString *)getWifiName;

@end

