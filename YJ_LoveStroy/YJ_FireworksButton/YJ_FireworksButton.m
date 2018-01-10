//
//  YJ_FireworksButton.m
//  YJ_Animation
//
//  Created by yujie on 2018/1/9.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "YJ_FireworksButton.h"

#import "YJ_FireworksView.h"

@interface YJ_FireworksButton ()

@property (nonatomic,strong) YJ_FireworksView * fireworksView;

@end

@implementation YJ_FireworksButton

-(void)setup{
    
    self.clipsToBounds = NO;
    
    _fireworksView = [[YJ_FireworksView alloc]init];
    [self insertSubview:_fireworksView atIndex:0];
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.fireworksView.frame = self.bounds;
    
    [self insertSubview:self.fireworksView atIndex:0];
    
}

#pragma mark  --  method  --

-(void)animate{
    
    [self.fireworksView animate];
    
}

-(void)popOutSideWithDuration:(NSTimeInterval)duration{
    
    __weak typeof (self) weakSelf = self;
    
    self.transform = CGAffineTransformIdentity;
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:0
                              animations:^{
                                  
                                  typeof (weakSelf)strongSelf = weakSelf;
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/3.0f animations:^{

                                      strongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
                                      
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:1/3.0f relativeDuration:1/3.0f animations:^{
                                      
                                      strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                      
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:2/3.0f relativeDuration:1/3.0f animations:^{
                                      
                                      strongSelf.transform = CGAffineTransformMakeScale(1, 1);
                                      
                                  }];
                                  
                              } completion:nil];
    
}

-(void)popInsideWithDuration:(NSTimeInterval)duration{
    
    __weak typeof (self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:0
                              animations:^{
                                  
                                  __strong typeof (weakSelf)strongSelf = weakSelf;
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:1/2
                                                                animations:^{
                                                                    strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:1/2.0f
                                                          relativeDuration:1/2.0f
                                                                animations:^{
                                                                    strongSelf.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                                                }];
                                  
                              } completion:nil];
    
}

#pragma mark  -- properties  --

-(UIImage *)particleImage{
    
    return  self.fireworksView.particleImage;
    
}

-(void)setParticleImage:(UIImage *)particleImage{
    
    self.fireworksView.particleImage = particleImage;
    
}

-(CGFloat)particleScale{
    
    return self.fireworksView.particleScale;
    
}

-(void)setParticleScale:(CGFloat)particleScale{
    
    self.fireworksView.particleScale = particleScale;
    
}

-(CGFloat)particleScaleRange{
    
    return self.fireworksView.particleScaleRange;
}

-(void)setParticleScaleRange:(CGFloat)particleScaleRange{
    
    self.fireworksView.particleScaleRange = particleScaleRange;
    
}

@end
