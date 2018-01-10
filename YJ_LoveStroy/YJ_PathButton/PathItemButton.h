//
//  PathItemButton.h
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PathItemButton;

@protocol PathItemButtonDelegate<NSObject>

-(void)itemButtonTapped:(PathItemButton *)pathItemButton;

@end

@interface PathItemButton : UIImageView

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,weak)  id<PathItemButtonDelegate> delegate;


-(id)initWithImage:(UIImage *)image
  highlightedImage:(UIImage *)highlightedImage
    backgroundImage:(UIImage *)backgroundImage
backgroundHighLightedImage:(UIImage *)backgroundHighLightedImage;

@end
