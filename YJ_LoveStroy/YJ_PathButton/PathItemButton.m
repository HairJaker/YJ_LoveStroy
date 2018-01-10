//
//  PathItemButton.m
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "PathItemButton.h"

@interface PathItemButton ()

@property (nonatomic,strong) UIImageView *backgroundImageView;

@end


@implementation PathItemButton

-(id)initWithImage:(UIImage *)image
  highlightedImage:(UIImage *)highlightedImage
   backgroundImage:(UIImage *)backgroundImage
backgroundHighLightedImage:(UIImage *)backgroundHighLightedImage{
    
    if (self = [super init]) {
        
        CGRect itemFrame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        
        
        if (!backgroundImage || !backgroundHighLightedImage) {
            itemFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        
        self.frame = itemFrame;
        
        self.image = backgroundImage;
        self.highlightedImage = backgroundHighLightedImage;
        
        self.userInteractionEnabled = YES;
        
        _backgroundImageView = [[UIImageView alloc]initWithImage:image highlightedImage:highlightedImage];
        _backgroundImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self addSubview:_backgroundImageView];
        
    }
    
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentLocation = [[touches anyObject] locationInView:self];
    
    if (!CGRectContainsPoint([self scaleRect:self.bounds], currentLocation)) {
        self.highlighted = NO;
        self.backgroundImageView.highlighted = NO;
        return;
    }
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
    
}

-(CGRect)scaleRect:(CGRect)originRect{
    
    return CGRectMake(-originRect.size.width * 2,
                      -originRect.size.height * 2,
                      originRect.size.width * 5, originRect.size.height * 5);
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_delegate && [_delegate respondsToSelector:@selector(itemButtonTapped:)]) {
        [_delegate itemButtonTapped:self];
    }
    
    self.highlighted = NO;
    self.backgroundImageView.highlighted = NO;
    
}

@end
