//
//  PathButton.m
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "PathButton.h"

#import "PathCenterButton.h"

#import "PathItemButton.h"

#import <AudioToolbox/AudioToolbox.h>

@interface PathButton ()<PathCenterButtonDelegate,PathItemButtonDelegate,PathButtonDelegate,CAAnimationDelegate>

@property (nonatomic,strong) UIImage * centerImage;
@property (nonatomic,strong) UIImage * centerHighLightedImage;

@property (assign,nonatomic,getter=isBloom) BOOL bloom;

@property (assign,nonatomic) CGSize foldedSize;
@property (assign,nonatomic) CGSize bloomSize;

@property (assign,nonatomic) CGPoint foldCenter;
@property (assign,nonatomic) CGPoint bloomCenter;

@property (assign,nonatomic) CGPoint pathCenterButtonBloomCenter;

@property (assign,nonatomic) CGPoint expandCenter;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) PathCenterButton * pathCenterButton;
@property (nonatomic,strong) NSMutableArray * itemButtons;

@property (nonatomic,assign) SystemSoundID bloomSound;
@property (nonatomic,assign) SystemSoundID foldSound;
@property (nonatomic,assign) SystemSoundID seldtedSound;

@end

@implementation PathButton


-(id)initCenterImage:(UIImage *)centerImage centerHighLightedImage:(UIImage *)centerHighLightedImage{
    
    if (self = [super init]) {
        self.centerImage = centerImage;
        self.centerHighLightedImage = centerHighLightedImage;
        
        self.itemButtonImages = [NSMutableArray array];
        self.itemButtonHighLightedImages = [NSMutableArray array];
        self.itemButtons = [NSMutableArray array];
        
        [self configureViewsLayout];
        
        [self configurationSounds];

    }
    
    return self;
}


/**
    configure views layout
 */
-(void)configureViewsLayout{
    
    // init property  once
    
    self.foldedSize = self.centerImage.size;
    self.bloomSize = [UIScreen mainScreen].bounds.size;
    
    self.bloom = NO;
    self.bloomRadius = 105.0f;
    
    // configure the view's center
    
    self.foldCenter = CGPointMake(self.bloomSize.width/2, self.bloomSize.height - 225.5f);
    self.bloomCenter = CGPointMake(self.bloomSize.width/2, self.bloomSize.height/2);
    
    // configure the pathButton's origin frame
    
    self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
    self.center = self.foldCenter;
    
    // configure center button
    
    _pathCenterButton = [[PathCenterButton alloc]initWithImage:self.centerImage highlightedImage:self.centerHighLightedImage];
    _pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _pathCenterButton.delegate = self;
    [self addSubview:_pathCenterButton];
    
    // configure bottom view
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height)];
    _bottomView.backgroundColor = [UIColor blackColor];
    _bottomView.alpha = 0.0f;
    
}

/**
  configure sounds
 */
-(void)configurationSounds{
    
    // configure bloom sound
    NSString * bloomSoundPath = [[NSBundle mainBundle]pathForResource:@"bloom" ofType:@"caf"];
    NSURL * bloomUrl = [NSURL URLWithString:bloomSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)bloomUrl, &_bloomSound);
    
    // configure fold sound
    NSString * foldSoundPath = [[NSBundle mainBundle]pathForResource:@"fold" ofType:@"caf"];
    NSURL * foldUrl = [NSURL URLWithString:foldSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)foldUrl, &_foldSound);
    
    // configure selected sound
    NSString * selectedSoundPath = [[NSBundle mainBundle]pathForResource:@"selected" ofType:@"caf"];
    NSURL * selectedUrl = [NSURL URLWithString:selectedSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)selectedUrl, &_seldtedSound);
    
}

#pragma mark  -- configure center button images --

-(void)setCenterImage:(UIImage *)centerImage{
    
    if (!centerImage) {
        NSLog(@"load center image failed ...");
        return;
    }
    _centerImage = centerImage;
}

-(void)setCenterHighLightedImage:(UIImage *)centerHighLightedImage{
    
    if (!centerHighLightedImage) {
        NSLog(@"load center high lighted image fail .");
        return;
    }
    _centerHighLightedImage = centerHighLightedImage;
}

#pragma mark  -- configure expand center point --

-(void)setPathCenterButtonBloomCenter:(CGPoint)pathCenterButtonBloomCenter{
    
    if (_pathCenterButtonBloomCenter.x == 0) {
        _pathCenterButtonBloomCenter = pathCenterButtonBloomCenter;
    }
    return;
    
}

#pragma mark  -- expend status  --

-(BOOL)isBloom{
    
    return _bloom;
    
}

#pragma mark  -- center button delegate  --

-(void)centerButtonTouchInSide{
    
    NSLog(@"%d",self.bloom);
    
    self.isBloom?[self pathCenterButtonFold]:[self pathCenterButtonBloom];
    
}

#pragma mark  -- caculate the item's end point --

-(CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius andAngel:(CGFloat)angel{
    
    return CGPointMake(self.pathCenterButtonBloomCenter.x - cosf(angel * M_PI)*itemExpandRadius, self.pathCenterButtonBloomCenter.y - sinf(angel * M_PI) * itemExpandRadius);
    
}

#pragma mark  -- center button fold --

-(void)pathCenterButtonFold{
    
    // play fold sound
    
    AudioServicesPlaySystemSound(self.foldSound);
    
    // load item buttons from array
    
    for (int i = 1; i <= self.itemButtons.count; i ++) {
        
        PathItemButton * itemButton = self.itemButtons[i - 1];
        
        CGFloat  currentAngel = i/((CGFloat)self.itemButtons.count + 1);
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 5.0f andAngel:currentAngel];
        
        CAAnimationGroup * foldAnimation = [self foldAnimationFromPoint:itemButton.center withFarPoint:farPoint];
        [itemButton.layer addAnimation:foldAnimation forKey:@"foldAnimation"];
        itemButton.center = self.pathCenterButtonBloomCenter;
    }
    
    [self bringSubviewToFront:self.pathCenterButton];
    
    // resize the pathButton's frame to the foled frame and remove the item buttons
    
    [self resizeToFoldFrame];
    
}

-(void)resizeToFoldFrame{
    
    [UIView animateWithDuration:0.0618f*3
                          delay:0.0618f*2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _pathCenterButton.transform = CGAffineTransformMakeRotation(0);
                     } completion:nil];
    
    [UIView animateWithDuration:0.1f
                          delay:0.35f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _bottomView.alpha = 0.0f;
                     } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        for (PathItemButton * itemButton in self.itemButtons) {
            [itemButton performSelector:@selector(removeFromSuperview)];
        }
        self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
        self.center = self.foldCenter;
        self.pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self.bottomView removeFromSuperview];
        
    });
    _bloom = NO;
}

-(CAAnimationGroup *)foldAnimationFromPoint:(CGPoint)point withFarPoint:(CGPoint)farPoint{
    
    // 1.0 configure rotation animation
    
    CAKeyframeAnimation * rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0),@(M_PI),@(M_PI * 2)];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = 0.35;
    
    // 2.0 configure moving animation
    
    CAKeyframeAnimation * movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // create moving path
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathAddLineToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    
    movingAnimation.keyTimes = @[@(0.0f),@(0.75),@(1.0f)];
    movingAnimation.path = path;
    movingAnimation.duration = 0.35;
    CGPathRelease(path);
    
    // 3.0 merge animations
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[rotationAnimation,movingAnimation];
    groupAnimation.duration = 0.35f;
    
    return groupAnimation;
    
}

#pragma mark  -- path center button bloom --

-(void)pathCenterButtonBloom{
    
    // play bloom sound
    
    AudioServicesPlaySystemSound(self.bloomSound);
    
    // configure center button bloom
    
    self.pathCenterButtonBloomCenter = self.center;
    
    // resize the pathButton's frame
    
    self.frame = CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height);
    self.center = CGPointMake(self.bloomSize.width/2, self.bloomSize.height/2);
    
    [self insertSubview:self.bottomView belowSubview:self.pathCenterButton];
    
    // excute the bottom view alpha animation
    
    [UIView animateWithDuration:0.0618f*3
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _bottomView.alpha = 0.618f;
                         
                     } completion:nil];
    
    // excute the center button rotation animation
    
    [UIView animateWithDuration:0.1575f
                     animations:^{
                         _pathCenterButton.transform = CGAffineTransformMakeRotation(-0.75f * M_PI);
                     }];
    
    self.pathCenterButton.center = self.pathCenterButtonBloomCenter;
    
    // excute bloom animation
    
    CGFloat basicAngel = 180 / (self.itemButtons.count + 1);
    
    for (int i = 1; i <= self.itemButtons.count; i ++) {
        
        PathItemButton * itemButton = self.itemButtons[i - 1];
        itemButton.delegate =self;
        itemButton.tag = i - 1;
        itemButton.transform = CGAffineTransformMakeTranslation(1, 1);
        itemButton.alpha = 1.0f;
        
        // add pathItem button to the view
        
        CGFloat currentAngel = (basicAngel * i)/180;
        
        itemButton.center = self.pathCenterButtonBloomCenter;
        
        [self insertSubview:itemButton belowSubview:self.pathCenterButton];
        
        // excute expand animation
        
        CGPoint endPoint = [self createEndPointWithRadius:self.bloomRadius andAngel:currentAngel];
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 10.0f andAngel:currentAngel];
        CGPoint nearPoint = [self createEndPointWithRadius:self.bloomRadius - 5.0f andAngel:currentAngel];
        
        
        // CAAnimation group
        
        CAAnimationGroup * bloomAnimation = [self bloomAnimationWithEndPoint:endPoint andFarPoint:farPoint andNearPoint:nearPoint];
        
        [itemButton.layer addAnimation:bloomAnimation forKey:@"bloomAnimation"];
        itemButton.center = endPoint;
        
    }
    _bloom = YES;
}

-(CAAnimationGroup *)bloomAnimationWithEndPoint:(CGPoint)endPoint andFarPoint:(CGPoint)farPoint andNearPoint:(CGPoint)nearPoint{
    
    // configure rotation animation
    
    CAKeyframeAnimation * rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0.0f),@(-M_PI),@(-M_PI * 1.5f),@(-M_PI * 2)];
    rotationAnimation.keyTimes = @[@(0.0f),@(0.3),@(0.6),@(1.0f)];
    rotationAnimation.duration = 0.3f;
    
    // configure moving animation
    
    CAKeyframeAnimation * movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // create moving path
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathAddLineToPoint(path, NULL, nearPoint.x, nearPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    movingAnimation.path = path;
    movingAnimation.keyTimes = @[@(0.0),@(0.5),@(0.7),@(1.0f)];
    movingAnimation.duration = 0.3f;
    CGPathRelease(path);
    
    // groupAnimation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[movingAnimation,rotationAnimation];
    groupAnimation.duration = 0.3f;
    groupAnimation.delegate = self;
    
    return groupAnimation;
    
}

#pragma mark  -- add PathButton item  --

-(void)addPathItems:(NSArray *)pathItemButtons{
    
    [self.itemButtons addObjectsFromArray:pathItemButtons];
    
}

#pragma mark  -- pathButton touch events --

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // tap the bottom area ,excute the fold animation
    
    [self pathCenterButtonFold];
}

#pragma  mark  -- pathButton item delegate  --

-(void)itemButtonTapped:(PathItemButton *)pathItemButton{
    
    if ([_delegate respondsToSelector:@selector(itemButtonTappedAtIndex:)]) {
        
        PathItemButton * selectedButton = self.itemButtons[pathItemButton.tag];
        
        // play selected Sound
        
        AudioServicesPlaySystemSound(self.seldtedSound);
        
        // excute the explode animation when the item is selected
        
        [UIView animateWithDuration:0.0618f*5 animations:^{
            
            selectedButton.transform = CGAffineTransformMakeScale(3, 3);
            selectedButton.alpha = 0.0f;
            
        }];
        
        //. excute the dismiss animation when the item is unselected
        
        for (int i = 0; i < self.itemButtons.count; i ++) {
            
            if (i == selectedButton.tag) {
                continue;
            }
            PathItemButton * unselectedButton = self.itemButtons[i];
            
            [UIView animateWithDuration:0.0618f * 2 animations:^{
                
                unselectedButton.transform = CGAffineTransformMakeScale(0, 0);
                
            }];
            
        }
        
        // excute the delegate method
        
        [_delegate itemButtonTappedAtIndex:pathItemButton.tag];
        
        // resize the pathButton frame
        
        [self resizeToFoldFrame];
    }
    
}

@end
