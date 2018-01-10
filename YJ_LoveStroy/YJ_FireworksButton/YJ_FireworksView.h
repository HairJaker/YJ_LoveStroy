//
//  YJ_FireworksView.h
//  YJ_Animation
//
//  Created by yujie on 2018/1/9.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJ_FireworksView : UIView

@property (strong,nonatomic) UIImage *particleImage;
@property (assign,nonatomic) CGFloat particleScale;
@property (assign,nonatomic) CGFloat particleScaleRange;

-(void)animate;

@end
