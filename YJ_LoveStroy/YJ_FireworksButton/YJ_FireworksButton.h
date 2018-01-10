//
//  YJ_FireworksButton.h
//  YJ_Animation
//
//  Created by yujie on 2018/1/9.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJ_FireworksButton : UIButton

@property (nonatomic,strong) UIImage * particleImage;
@property (nonatomic,assign) CGFloat  particleScale;
@property (nonatomic,assign) CGFloat  particleScaleRange;

-(void)animate;
-(void)popOutSideWithDuration:(NSTimeInterval)duration;
-(void)popInsideWithDuration:(NSTimeInterval)duration;

@end
