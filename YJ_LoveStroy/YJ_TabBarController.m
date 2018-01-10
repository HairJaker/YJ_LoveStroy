//
//  YJ_TabBarController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "YJ_TabBarController.h"

@interface YJ_TabBarController ()

@end

@implementation YJ_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewControllers];
    [self changeTabBarItem];
    
}

#pragma mark -  更改 tabBar item ----

-(void)changeTabBarItem
{
    self.tabBar.barTintColor = [UIColor blackColor];
    
    NSArray * tabSelectImages = @[[UIImage imageNamed:@"tab_first_highlight"],[UIImage imageNamed:@"tab_last_highlight"]];
    NSArray * tabNormalImages = @[[UIImage imageNamed:@"tab_first_normal"],[UIImage imageNamed:@"tab_last_normal"]];
    NSArray * itemTexts = @[@"首页",@"我的"];
    
    for (int i = 0; i < tabSelectImages.count; i ++) {
        UITabBarItem * tabBarItem = [self.tabBar.items objectAtIndex:i];
        UIImage * image = [tabSelectImages objectAtIndex:i];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.image = [tabNormalImages objectAtIndex:i];
        tabBarItem.title = [itemTexts objectAtIndex:i];
        tabBarItem.selectedImage = image;
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
}

-(void)addViewControllers{

    NSMutableArray * controllerArray = [[NSMutableArray alloc]init];

    NSArray * controllerNameArray = [NSArray arrayWithObjects:@"HomePageViewController",@"MineViewController",nil];
    
    for (int i = 0; i<controllerNameArray.count; i++) {
        
        NSString * className = controllerNameArray[i];
        
        Class  NewClass = NSClassFromString(className);

        if (NewClass) {
            BaseViewController * nowVC = [[NewClass alloc] init];
            UINavigationController * naviVC = [[UINavigationController alloc]initWithRootViewController:nowVC];
            naviVC.navigationBarHidden = YES;
            [controllerArray addObject:naviVC];
        }
    }
    
    self.viewControllers = controllerArray;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBar setHidden:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
