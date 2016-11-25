//
//  YJ_GuideScrollView.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/25.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "YJ_GuideScrollView.h"
#import "YJ_UserManager.h"

@interface YJ_GuideScrollView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * guideScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;

@end

@implementation YJ_GuideScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addGuideScrollViewWithFrame:frame];
    }
    return self;
}

#pragma mark  -  初始化引导页 ----

-(void)addGuideScrollViewWithFrame:(CGRect)frame{
    
    _guideScrollView = [[UIScrollView alloc]initWithFrame:frame];
    [_guideScrollView setContentSize:CGSizeMake(frame.size.width * GUIDE_COUNT, frame.size.height)];
    [_guideScrollView setPagingEnabled:YES];
    [_guideScrollView setBounces:NO];
    _guideScrollView.delegate = self;
    _guideScrollView.userInteractionEnabled = YES;
    //    去掉滚动条
    [_guideScrollView setShowsHorizontalScrollIndicator:NO];
    [_guideScrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_guideScrollView];
    
    CGRect rect  = CGRectZero;
    
    for (int i = 0 ; i < GUIDE_COUNT; i ++) {
        
        rect  = CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height);
        
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
    
    rect = CGRectMake(3*margin, frame.size.height - margin, frame.size.width - margin * 6, 20);
    
    _pageControl = [[UIPageControl alloc]initWithFrame:rect];
    _pageControl.numberOfPages = GUIDE_COUNT;
    _pageControl.tintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
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
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:CURRENT_VERSION forKey:@"currentVersion"];
    
    [UIView animateWithDuration:.2 animations:^{
        _guideScrollView.alpha = 0.0f;
        _pageControl.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [_guideScrollView removeFromSuperview];
        [_pageControl removeFromSuperview];
        [self removeFromSuperview];
        
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

@end
