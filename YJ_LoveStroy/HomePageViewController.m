//
//  HomePageViewController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#define CIRCLE_SCROLL_VIEW_HEIGHT 150
#define ALL_CIRCLE_COUNT 6

#import "HomePageViewController.h"

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UITableView * homeTableView;

@property (nonatomic,strong) UICollectionView * homeCollectionView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setHeadViewTitleLabelTextWith:@"首页"];
    
    [self showCircleScrollView];
    
//    [self addTableView];
    
    [self addCollectionView];
}

#pragma mark  -   轮播图视图 --

-(void)showCircleScrollView
{
    CGRect circleScrollViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT, SCREEN_WIDTH, CIRCLE_SCROLL_VIEW_HEIGHT);
    
    NSMutableArray * circleImages = [NSMutableArray array];
    
    for (int i = 0; i < ALL_CIRCLE_COUNT; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"circle_%d.jpg",i]];
        [circleImages addObject:image];
    }
    
    YJ_CircleScrollView * circleScrollView = [[YJ_CircleScrollView alloc]initWithFrame:circleScrollViewRect andImages:circleImages];
    [self.view addSubview:circleScrollView];
}

#pragma mark  -- 列表 --

-(void)addTableView
{
    
    CGRect  tableViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT));
    
    _homeTableView = [[UITableView alloc]initWithFrame:tableViewRect];
    
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
    [self.view addSubview:_homeTableView];
                                       
}

#pragma mark -  tableView dataSource -----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * cellName = @"cellName";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    return cell;
}

#pragma mark  --  add collection view  --

-(void)addCollectionView{

    UICollectionViewFlowLayout * collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    CGRect  collectionViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT + 44));
    
    _homeCollectionView = [[UICollectionView alloc]initWithFrame:collectionViewRect collectionViewLayout:collectionViewLayout];
    _homeCollectionView.backgroundColor = [UIColor redColor];
    _homeCollectionView.dataSource = self;
    _homeCollectionView.delegate = self;
    [self.view addSubview:_homeCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
}

#pragma mark  --  collection view  datasource  --

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    switch (section) {
//        case 0:
//            return 3;
//            break;
//        case 1:
//            return 4;
//            break;
//        case 2:
//            return 7;
//            break;
//        default:
//            break;
//    }
    return 16;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    
//    UINib * nib = [UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil];
//    [collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
//    cell.backgroundColor = [UIColor grayColor];
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
        nibsRegistered = YES;
    }
    
    CustomCollectionViewCell * cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
    
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(SCREEN_WIDTH-40)/3,(SCREEN_WIDTH-40)/3};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){SCREEN_WIDTH,0};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){SCREEN_WIDTH,0};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
