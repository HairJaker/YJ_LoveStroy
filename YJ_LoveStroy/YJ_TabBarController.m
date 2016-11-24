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
    
    [self changeTabBarItem];
    
}

#pragma mark -  更改 tabBar item ----

-(void)changeTabBarItem
{
    self.tabBar.barTintColor = [UIColor blackColor];
    
    NSArray * tabSelectImages = @[[UIImage imageNamed:@"tab_first_highlight"],[UIImage imageNamed:@"tab_last_highlight"]];
    
    for (int i = 0; i < tabSelectImages.count; i ++) {
        UITabBarItem * tabBarItem = [self.tabBar.items objectAtIndex:i];
        UIImage * image = [tabSelectImages objectAtIndex:i];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
