//
//  CustomMenuView.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/12/5.
//  Copyright © 2016年 yujie. All rights reserved.
//

#import "CustomMenuView.h"

@interface CustomMenuView()

@property (nonatomic ,strong) NSMutableArray * items;

@end

@implementation CustomMenuView

-(instancetype)initWithFrame:(CGRect)frame withItemsTitle:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _items = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
        [self creatMenuItemsWithFrame:frame andTitles:titles];
    }
    return self;
}

-(void)creatMenuItemsWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    for (int i = 0; i < titles.count; i ++) {
        UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(0, (frame.size.height/titles.count) * i, frame.size.width, frame.size.height/titles.count);
        [menuButton setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        menuButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        if (i == 0) {
            menuButton.selected = YES;
        }
        menuButton.tag = i;
        [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [menuButton addTarget:self action:@selector(menuChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_items addObject:menuButton];
        [self addSubview:menuButton];
    }
}

-(void)menuChooseAction:(UIButton *)sender
{
    _menuChooseBlock((int)sender.tag);
}

-(void)reloadItmesFrameWithFrame:(CGRect)frame{
    for (int i = 0; i < _items.count; i ++) {
        UIButton * menuButton = [_items objectAtIndex:i];
        menuButton.frame = CGRectMake(0, (frame.size.height/_items.count) * i, frame.size.width, frame.size.height/_items.count);
    }
}

@end
