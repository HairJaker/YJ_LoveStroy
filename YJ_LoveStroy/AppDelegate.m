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
    
    
//    YJ_TabBarController * homePage = [[YJ_TabBarController alloc]i];
//    [self.window setRootViewController:homePage];
    [self.window makeKeyAndVisible];
    
    [self addGuideScrollViewWithFrame:self.window.bounds];
    
    return YES;
}

#pragma mark  -  初始化引导页 ----

-(void)addGuideScrollViewWithFrame:(CGRect)frame{
    
    _guideScrollView = [[UIScrollView alloc]initWithFrame:frame];
    [_guideScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * GUIDE_COUNT, SCREEN_HEIGHT)];
    [_guideScrollView setPagingEnabled:YES];
    [_guideScrollView setBounces:NO];
    _guideScrollView.delegate = self;
    _guideScrollView.userInteractionEnabled = YES;
    //    去掉滚动条
    [_guideScrollView setShowsHorizontalScrollIndicator:NO];
    [_guideScrollView setShowsVerticalScrollIndicator:NO];
    [self.window addSubview:_guideScrollView];
    
    CGRect rect  = CGRectZero;
    
    for (int i = 0 ; i < GUIDE_COUNT; i ++) {
        
        rect  = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        UIImageView *iv = [[UIImageView alloc]init];
        iv.frame = rect;
        iv.userInteractionEnabled = YES;
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d.jpg",i+1]];
        [_guideScrollView addSubview:iv];
        
        if (i == GUIDE_COUNT - 1) {
            [self addStartButton];
        }
    }
    
    CGFloat  margin  = PAGECONTROL_HEIGHT  * 2;
    
    rect = CGRectMake(3*margin, SCREEN_HEIGHT - margin, SCREEN_WIDTH - margin * 6, 20);
    
    _pageControl = [[UIPageControl alloc]initWithFrame:rect];
    _pageControl.numberOfPages = GUIDE_COUNT;
    _pageControl.tintColor = [UIColor whiteColor];
    [self.window addSubview:_pageControl];
    
}

#pragma mark -----   启动按钮  -------

-(void)addStartButton
{
    int  startButtonWidth = 80;
    int  xMar = 25;
    int  yMar = 20;
    
    CGRect  startButtonRect = CGRectMake(_guideScrollView.contentSize.width - (startButtonWidth + xMar), SCREEN_HEIGHT - (xMar + yMar), startButtonWidth, xMar);
    
    UIButton * startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setFrame:startButtonRect];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [_guideScrollView addSubview:startButton];
    
}
//  --------  start  -----

-(void)start{
    
    [UIView animateWithDuration:.2 animations:^{
        _guideScrollView.alpha = 0.0f;
        _pageControl.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [_guideScrollView removeFromSuperview];
        [_pageControl removeFromSuperview];
    }];
    
}

#pragma mark  -  scroll view delegate  ---

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index= scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    [_pageControl setCurrentPage:index];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x == (GUIDE_COUNT - 1) * SCREEN_WIDTH) {
        [self start];
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
