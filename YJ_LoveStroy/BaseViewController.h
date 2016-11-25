//
//  BaseViewController.h
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UILabel * titleLabel;

-(void)setHeadViewTitleLabelTextWith:(NSString *)text;

-(void)setHeadViewHidden:(BOOL)hidden;

@end
