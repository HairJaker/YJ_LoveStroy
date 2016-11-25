//
//  UIImage+BackgroundColor.m
//  TabBarControllerTest
//
//  Created by yujie on 16/9/13.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "UIImage+BackgroundColor.h"

@implementation UIImage (BackgroundColor)

+(UIImage *)getBackGroundColorWithView:(UIView *)view withColors:(NSArray *)colors{
    
    CGRect frame = view.bounds;
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *color in colors) {
        
        [ar addObject:(id)color.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    start = CGPointMake(0.0, frame.size.height);
    
    end = CGPointMake(frame.size.width, 0.0);
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    

}

@end
