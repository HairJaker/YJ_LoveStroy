//
//  PathCenterButton.h
//  YJ_Animation
//
//  Created by yujie on 2018/1/8.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PathCenterButtonDelegate<NSObject>

-(void)centerButtonTouchInSide;

@end

@interface PathCenterButton : UIImageView

@property (nonatomic,weak) id<PathCenterButtonDelegate> delegate;

@end
