//
//  YJ_CircleScrollView.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/25.
//  Copyright © 2016年 yujie. All rights reserved.
//

#define CIRCLE_COUNT 3

#import "YJ_CircleScrollView.h"

@interface YJ_CircleScrollView()<UIScrollViewDelegate,UIPageViewControllerDelegate>
{
    
    NSMutableArray * imageDatas;
    NSInteger _currentImageIndex;
    NSInteger _imagesCount;
    
    int selfWidth;
    int selfHeight;
    
}
@property (nonatomic,strong)  NSMutableArray * imageViews;
@property (nonatomic,strong)  UIPageControl * pageControl;
@property (nonatomic,strong)  UIScrollView * scrollView;

@property (nonatomic,strong)  NSTimer * timer;

@end

@implementation YJ_CircleScrollView

-(instancetype)initWithFrame:(CGRect)frame andImages:(NSMutableArray *)images
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        imageDatas = images;
        _imagesCount = imageDatas.count;
        _imageViews = [NSMutableArray array];
        selfWidth = frame.size.width;
        selfHeight = frame.size.height;
        
        [self initProperty];
        
        //添加图片控件
        [self addImageViews];
        //添加分页控件
        [self addPageControl];
        //加载默认图片
        [self setDefaultImage];
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"currentVersion"] == nil) {
            
            [self performSelector:@selector(addTimerAfterDelay) withObject:nil afterDelay:3];
            
        }else [self addTimer];
        
        
    }
    return self;
}

-(void)addTimerAfterDelay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(addTimerAfterDelay) object:nil];

    [self addTimer]; // 添加定时器
}

#pragma mark --  init property  ------

-(void)initProperty
{
    CGRect scrollViewRect = CGRectMake(0, 0, selfWidth, selfHeight);
    
    _scrollView = [[UIScrollView alloc]initWithFrame:scrollViewRect];
    [self addSubview:_scrollView];
    
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(selfWidth * CIRCLE_COUNT, selfHeight);
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)]; //  设置当前显示位置为中间
    
    //去掉滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
}

#pragma mark 添加图片三个控件
-(void)addImageViews{
    
    for (int i = 0; i < CIRCLE_COUNT; i ++) {
        CGRect imageViewRect = CGRectMake(selfWidth * i, 0, selfWidth, selfHeight);
        UIImageView * iv = [[UIImageView alloc]initWithFrame:imageViewRect];
        iv.contentMode = UIViewContentModeScaleToFill;
        [_imageViews addObject:iv];
        [_scrollView addSubview:iv];
    }
}

#pragma mark 设置默认显示图片
-(void)setDefaultImage{
    //加载默认图片
    
    for (int i = 0; i < _imageViews.count; i++) {
        UIImageView * iv = [_imageViews objectAtIndex:i];
        iv.image = (i==0?[imageDatas lastObject]:(i == 1)?[imageDatas firstObject]:[imageDatas objectAtIndex:1]);
    }
    _currentImageIndex=0;
    //设置当前页
    _pageControl.currentPage=_currentImageIndex;
}

#pragma mark 添加分页控件
-(void)addPageControl{
    _pageControl=[[UIPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size= [_pageControl sizeForNumberOfPages:_imagesCount];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(selfWidth/2,selfHeight - 20);
    //设置颜色
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    //设置总页数
    _pageControl.numberOfPages=_imagesCount;

    [self addSubview:_pageControl];
}

#pragma mark - delegate -
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger leftImageIndex, rightImageIndex;
    
    CGPoint  current = [_scrollView contentOffset];
    
    if (current.x > selfWidth) {
        _currentImageIndex = (_currentImageIndex + 1) % _imagesCount;
    }else{
        
        _currentImageIndex = (_currentImageIndex + _imagesCount - 1)%_imagesCount;
    }
    
    _pageControl.currentPage = _currentImageIndex;
    
    leftImageIndex = (_currentImageIndex +_imagesCount - 1)%_imagesCount;
    rightImageIndex = (_currentImageIndex + 1) % _imagesCount;
    
    NSArray * indexs = @[@(leftImageIndex),@(_currentImageIndex),@(rightImageIndex)];
    
    for (int i = 0; i < _imageViews.count; i++) {
        UIImageView * iv = [_imageViews objectAtIndex:i];
        iv.image = [imageDatas objectAtIndex:[[indexs objectAtIndex:i] integerValue]];
    }
    
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)];
    
}

//  开始拖拽 关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeTimer];
}

//  结束拖拽 添加定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

#pragma mark - timer方法
//  添加定时器
-(void)addTimer
{

    self.timer =  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showNextImage) userInfo:nil repeats:YES];
    //多线程 UI IOS程序默认只有一个主线程，处理UI的只有主线程。如果拖动第二个UI，则第一个UI事件则会失效。
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 关闭定时器
-(void)closeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    
}

#pragma mark -  自动轮播图片调用方法 --

-(void)showNextImage
{
    
    NSInteger leftImageIndex, rightImageIndex;
    
    [_pageControl setCurrentPage:(_currentImageIndex + 1) % _imagesCount];
    
//    _pageControl.currentPage = _currentImageIndex;
    
    leftImageIndex = (_pageControl.currentPage +_imagesCount - 1)%_imagesCount;
    rightImageIndex = (_pageControl.currentPage + 1) % _imagesCount;
    
    NSArray * indexs = @[@(leftImageIndex),@(_pageControl.currentPage),@(rightImageIndex)];
    
    for (int i = 0; i < _imageViews.count; i++) {
        UIImageView * iv = [_imageViews objectAtIndex:i];
        iv.image = [imageDatas objectAtIndex:[[indexs objectAtIndex:i] integerValue]];
    }
    
    _currentImageIndex = _pageControl.currentPage;
    
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)];
}

@end
