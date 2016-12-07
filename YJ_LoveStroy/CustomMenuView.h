//
//  CustomMenuView.h
//  YJ_LoveStroy
//
//  Created by yujie on 16/12/5.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMenuView : UIView

-(instancetype)initWithFrame:(CGRect)frame withItemsTitle:(NSArray *)titles;

-(void)menuChooseAction:(UIButton *)sender;

-(void)reloadItmesFrameWithFrame:(CGRect)frame;

@end
