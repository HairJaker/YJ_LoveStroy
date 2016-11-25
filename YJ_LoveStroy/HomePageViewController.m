//
//  HomePageViewController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#define CIRCLE_SCROLL_VIEW_HEIGHT 200
#define ALL_CIRCLE_COUNT 6

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadViewTitleLabelTextWith:@"首页"];
    
    [self showCircleScrollView];
    
}

#pragma mark  -   轮播图视图 --

-(void)showCircleScrollView
{
    CGRect circleScrollViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT, SCREEN_WIDTH, CIRCLE_SCROLL_VIEW_HEIGHT);
    
    NSMutableArray * circleImages = [NSMutableArray array];
    
    for (int i = 0; i < ALL_CIRCLE_COUNT; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"circle_%d.jpg",i]];
        [circleImages addObject:image];
    }
    
    YJ_CircleScrollView * circleScrollView = [[YJ_CircleScrollView alloc]initWithFrame:circleScrollViewRect andImages:circleImages];
    [self.view addSubview:circleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
