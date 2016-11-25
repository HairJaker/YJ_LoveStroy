//
//  HomePageViewController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#define CIRCLE_SCROLL_VIEW_HEIGHT 150
#define ALL_CIRCLE_COUNT 6

#import "HomePageViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * homeTableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setHeadViewTitleLabelTextWith:@"首页"];
    
    [self showCircleScrollView];
    
    [self addTableView];
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

#pragma mark  -- 列表 --

-(void)addTableView
{
    
    CGRect  tableViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT));
    
    _homeTableView = [[UITableView alloc]initWithFrame:tableViewRect];
    
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
    [self.view addSubview:_homeTableView];
                                       
}

#pragma mark -  tableView dataSource -----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * cellName = @"cellName";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
