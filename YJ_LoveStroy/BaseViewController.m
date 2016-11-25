//
//  BaseViewController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundColor];  // 设置渐变背景
}

#pragma mark ----  添加渐变背景色  -----

-(void)setBackgroundColor
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.0f].CGColor];
    
    //位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
    
    gradientLayer.startPoint = CGPointMake(0, 1);
    
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    [self.view.layer addSublayer:gradientLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
