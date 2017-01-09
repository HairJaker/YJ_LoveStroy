//
//  AppDelegate.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * guideScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    [self.window makeKeyAndVisible];
    
    NSString * versionStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentVersion"];
    
    if (versionStr == nil || ![versionStr isEqualToString:CURRENT_VERSION]) {
       [self addGuideScrollViewWithFrame:self.window.bounds];
    }
    
    [self showTabbarController];
    
    return YES;
}

#pragma mark  -  初始化引导页 ----

-(void)addGuideScrollViewWithFrame:(CGRect)frame{
    
    YJ_GuideScrollView * guideVeiw = [[YJ_GuideScrollView alloc]initWithFrame:frame];
    [self.window addSubview:guideVeiw];
    
}

-(void)showTabbarController
{
    YJ_TabBarController *  tab = [[YJ_TabBarController alloc]init];

    UINavigationController * baseNavigationController = [[UINavigationController alloc]initWithRootViewController:tab];
    baseNavigationController.navigationBarHidden = YES;
    [self.window setRootViewController:baseNavigationController];
    
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
