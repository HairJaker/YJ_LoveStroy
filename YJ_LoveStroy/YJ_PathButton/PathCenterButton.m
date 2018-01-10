//
//  PathCenterButton.m
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "PathCenterButton.h"

@implementation PathCenterButton

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage{
    
    if (self = [super initWithImage:image
                   highlightedImage:highlightedImage]) {
        
        self.userInteractionEnabled = YES;
        self.image = image;
        self.highlightedImage = highlightedImage;
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.highlighted = YES;
    
    if (_delegate && [self.delegate respondsToSelector:@selector(centerButtonTouchInSide)]) {
        [_delegate centerButtonTouchInSide];
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentLocation = [[touches anyObject]locationInView:self];
    
    if (!CGRectContainsPoint([self scaleRect:self.bounds], currentLocation)) {
        self.highlighted = NO;
        return;
    }
    self.highlighted = YES;
    
}

-(CGRect)scaleRect:(CGRect)originRect{
    
    return  CGRectMake(-originRect.size.width,
                       -originRect.size.height,
                       originRect.size.width * 3,
                       originRect.size.height * 3);
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.highlighted = NO;
    
}

@end
