//
//  AppDelegate.m
//  BreadTripNew
//
//  Created by 王小琪 on 16/12/28.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "PremViewController.h"
#import "MineViewController.h"
#import "Reachability.h"
#import <SVProgressHUD.h>

@interface AppDelegate ()
{
    Reachability *reach;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 判断网络
    reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickReach:) name:kReachabilityChangedNotification object:nil];
    [reach startNotifier];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    
    // 新手指导页(版本号判断)
    // 解析程序的 Info.plist文件路径  这个文件一般存在library的nsuserdeflauts里面
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    // 因为info。plist文件是一个字典格式的 所以将文件路径转化为字典
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
    
    // 比较两个版本号  获取现在字典里面的CFBundleVersion 和这个文件原来的 一般存在library的nsuserdeflauts里面的原Info.plist文件version比较
    if ([[dic objectForKey:@"CFBundleVersion"] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"version"]]) {
        NSLog(@"版本号相同");
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[PremViewController alloc] init]];
        self.window.backgroundColor = [UIColor colorWithRed:255/250.0 green:248/250.0 blue:230/250.0 alpha:1];
        
    }else{
        NSLog(@"版本号不同");
        
        LaunchViewController *launch = [[LaunchViewController alloc] init];
        launch.url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"launchvideo" ofType:@"mp4"]];
        self.window.rootViewController = launch;
        
        // 版本号不同 那么将现在的版本号存法nsuserdefaults里
        [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"CFBundleVersion"] forKey:@"version"];
    }
    sleep(0.5);
    
    
    return YES;
}
// 判断网络
-(void)clickReach:(NSNotification *)not{
    if ([reach currentReachabilityStatus]==NotReachable) {
        [SVProgressHUD showErrorWithStatus:@"无网络连接"];
    }else{
        
        switch ([reach currentReachabilityStatus]) {
            case ReachableViaWiFi:
                [SVProgressHUD showSuccessWithStatus:@"已切换至WIFI网络"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wifi" object:nil];
                break;
            case ReachableViaWWAN:
                [SVProgressHUD showSuccessWithStatus:@"已切换至234G网络"];
                break;
                
            default:
                break;
        }
    }
}

// 3DTouch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    //判断先前我们设置的唯一标识
    
    if([shortcutItem.localizedTitle isEqualToString:@"我的"]){
    
        [self.window.rootViewController presentViewController:[[MineViewController alloc] init] animated:YES completion:^{
            
        }];
        
    }
    if ([shortcutItem.localizedTitle isEqual: @"分享"]) {
        
        NSArray *array = @[@"hello 3D Touch"];
        
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
        
        //设置当前的VC 为rootVC
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
            
        }];

        
        return;
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
