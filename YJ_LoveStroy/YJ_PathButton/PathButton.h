//
//  PathButton.h
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PathButtonDelegate<NSObject>

-(void)itemButtonTappedAtIndex:(NSInteger)index;

@end

@interface PathButton : UIView

@property (weak,nonatomic) id<PathButtonDelegate>delegate;

@property (strong,nonatomic) NSMutableArray * itemButtonImages;
@property (strong,nonatomic) NSMutableArray * itemButtonHighLightedImages;

@property (strong,nonatomic) UIImage * itemButtonBackgroundImage;
@property (strong,nonatomic) UIImage * itemButtonBackgroundHighLightedImage;

@property (assign,nonatomic) CGFloat  bloomRadius;

-(id)initCenterImage:(UIImage *)centerImage centerHighLightedImage:(UIImage *)centerHighLightedImage;

-(void)addPathItems:(NSArray *)pathItemButtons;

@end
