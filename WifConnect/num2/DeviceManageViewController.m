//
//  DeviceManageViewController.m
//  smartYogurtMaker
//
//  Created by mqw on 15/7/10.
//  Copyright (c) 2015年 mqw. All rights reserved.
//

#import "DeviceManageViewController.h"
#import "UIAlertView+Block.h"
#import "AppDelegate.h"
#import "UdpCheckUtl.h"
#import "EasyTimeline.h"



@interface DeviceManageViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView* tableview;
@end

@implementation DeviceManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:28/255.0 green:191/255.0 blue:215/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    
    //.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableview.delegate = self;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect rect = [[UIScreen mainScreen] applicationFrame];
        self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 1)];
        //self.tableview.tableHeaderView.backgroundColor = [UIColor clearColor];
        self.tableview.tableHeaderView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"top.png"]];
        self.tableview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    }
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotDeviceByScan:) name:kOnGotDeviceByScan object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pswdShowPressed{
    
    _deviceArray = nil;
    _deviceArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    //获取所有数据
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    NSString *S1 = NSLocalizedString(@"S1", nil);
    _HUD.labelText = S1;
    [self.view addSubview:_HUD];
    [_HUD show:YES];
    
 EasyTimeline * _timelineConfig = [[EasyTimeline alloc] init];
    
    _timelineConfig.duration		= 8;
    _timelineConfig.tickPeriod	= 2;
    _timelineConfig.tickBlock		= ^void (NSTimeInterval time, EasyTimeline *timeline) {
        
        UdpCheckUtl *udpCheck = [[UdpCheckUtl alloc]init];
        [udpCheck startUdpCheck];
       
    };
    _timelineConfig.completionBlock = ^void (EasyTimeline *timeline) {
       
        [_HUD hide:YES];
    };
    
    
    [_timelineConfig start];
    [[NSRunLoop currentRunLoop] run];
}

#pragma mark 扫描到设备
//用户登陆成功回调
-(void)onGotDeviceByScan:(NSNotification*)noti{
    NSString* deviceMac = [noti.object objectForKey:@"deviceMac"];
    
    if (![_deviceArray containsObject:deviceMac]) {
        [_deviceArray addObject:deviceMac];
        [self.tableview reloadData];

    }
    
   }



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_deviceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaItem"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AreaItem"];
        
    }
  cell.backgroundColor=[UIColor clearColor];
    //得到词典中所有KEY值
    NSString * macAdress = [_deviceArray objectAtIndex:indexPath.row];
    NSString *S7 = NSLocalizedString(@"S7", nil);
    NSString* text = [NSString stringWithFormat:S7,macAdress ];
    cell.textLabel.text =text;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"MAC:%@",[device.deviceInf getMacAddressString]];

    return cell;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *S3= NSLocalizedString(@"S3", nil);
        NSString *S4 = NSLocalizedString(@"S4", nil);
        NSString *S5 = NSLocalizedString(@"S5", nil);
        NSString *S6 = NSLocalizedString(@"S6", nil);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:S3 message:S4 delegate:nil cancelButtonTitle:S5 otherButtonTitles:S6, nil];
        
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if(1 == buttonIndex){
              
                
            }
            
            
            
        }];

        
        
        // Delete the row from the data source
    
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *S2 = NSLocalizedString(@"S2", nil);
    return S2;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView

           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath      //当在Cell上滑动时会调用此函数

{
    return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键,点击Delete后会调用下面的函数,别给传递UITableViewCellEditingStyleDelete参数
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
    
}




@end
