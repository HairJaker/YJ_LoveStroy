//
//  HomePageViewController.m
//  YJ_LoveStroy
//
//  Created by yujie on 16/11/24.
//  Copyright © 2016年 yujie. All rights reserved.
//

#define CIRCLE_SCROLL_VIEW_HEIGHT 150
#define ALL_CIRCLE_COUNT 6
#define TABLE_HEAD_VIEW_HEIGHT 44

#import "HomePageViewController.h"


// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UITableView * homeTableView;

@property (nonatomic,strong) UICollectionView * homeCollectionView;

@property (nonatomic,strong) CustomMenuView * menuView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setHeadViewTitleLabelTextWith:@"首页"];
    
    [self showCircleScrollView];
    
    [self setItemWithTitle:@"筛选" isToRight:YES image:nil];
    [self setItemWithTitle:@"帮助" isToRight:NO image:nil];
    
    [self addTableView];
    [self addCollectionView];
    [self addMenuView];
    
    [self prepareRefresh];
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
    
    CGRect  tableViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT + 50));
    
    _homeTableView = [[UITableView alloc]initWithFrame:tableViewRect];
    _homeTableView.hidden = YES;
    _homeTableView.backgroundColor = [UIColor clearColor];
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_homeTableView];
                                       
}

#pragma mark --  刷新加载  --
//自定义一个方法实现
- (void)prepareRefresh
{
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d.tiff",i]];
        [headerImages addObject:image];
    }
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
        
//        [_homeTableView.mj_header endRefreshing];
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.stateLabel.text = @"加载中...";
    gifHeader.stateLabel.textColor = [UIColor whiteColor];
//    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    _homeTableView.mj_header = gifHeader;
    
    
    NSMutableArray *footerImages = [NSMutableArray array];
//    for (int i = 8; i >=0; i--) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d.tiff",i]];
//        [footerImages addObject:image];
//    }
    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        //上拉加载需要做的操作.
        
//        [_homeTableView.mj_footer endRefreshing];
    }];
    
    gifFooter.stateLabel.hidden = YES;
    gifFooter.refreshingTitleHidden = YES;
//    [gifFooter setImages:@[footerImages[0]] forState:MJRefreshStateIdle];
//    [gifFooter setImages:footerImages forState:MJRefreshStateRefreshing];
    _homeTableView.mj_footer = gifFooter;
}

#pragma mark -  tableView dataSource -----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?3:section==1?6:section == 2?7:0;
}

#pragma mark  --  tableView delegate  ---

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_HEAD_VIEW_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [self addHeadView];
    return headView;
}

-(UIView *)addHeadView
{
    CGRect headViewRect = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    UIView * headView = [[UIView alloc]initWithFrame:headViewRect];
    headView.backgroundColor = [UIColor blackColor];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * homePageCell = @"homePageCell";
    
    BOOL nibRegistered = NO;
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([YJ_HomePageCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:homePageCell];
        nibRegistered = YES;
    }
    YJ_HomePageCell * cell = (YJ_HomePageCell *)[tableView dequeueReusableCellWithIdentifier:homePageCell];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJ_ContainerViewController * containerVC = [[YJ_ContainerViewController alloc]init];
    containerVC.currentSelectedIndex = 1;
    [self.navigationController pushViewController:containerVC animated:YES];
}

#pragma mark  --  add collection view  --

-(void)addCollectionView{

    UICollectionViewFlowLayout * collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    CGRect  collectionViewRect = CGRectMake(0, HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (HEAD_VIEW_HEIGHT + CIRCLE_SCROLL_VIEW_HEIGHT + 50));
    
    _homeCollectionView = [[UICollectionView alloc]initWithFrame:collectionViewRect collectionViewLayout:collectionViewLayout];
    _homeCollectionView.backgroundColor = [UIColor clearColor];
    _homeCollectionView.dataSource = self;
    _homeCollectionView.delegate = self;
    _homeCollectionView.hidden = NO;
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
    return 16;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark  --   navigation item action  --

-(void)addMenuView{
    NSArray * menuTitlesArray  = @[@"高手推荐",@"竞彩赔率",@"列表",@"集合"];
    CGRect menuRect  = CGRectMake(SCREEN_WIDTH - 25 * menuTitlesArray.count - 10, HEAD_VIEW_HEIGHT, 25 * menuTitlesArray.count, 0);
    
    _menuView = [[CustomMenuView alloc]initWithFrame:menuRect withItemsTitle:menuTitlesArray];
    _menuView.hidden = YES;
    
    
    __weak typeof(HomePageViewController *) weakSelf = self;
    
    _menuView.menuChooseBlock = ^(int index){
    
        [weakSelf chooseMenuActionInIndex:index];
        
    };
    [self.view addSubview:_menuView];
}

-(void)rightAction:(UIButton *)sender
{
    CGRect __block rect  = _menuView.frame;

    [UIView animateWithDuration:0.2 animations:^{
     
        if (_menuView.hidden) {
            
            _menuView.hidden = NO;
            rect.size.height += 100;
           
        }else {
            
            rect.size.height -= 100;
            _menuView.hidden = YES;
            
        }
        
         _menuView.frame = rect;
        
        [_menuView reloadItmesFrameWithFrame:_menuView.frame];
        
    } completion:^(BOOL finished) {
        
//        _menuView.hidden = !_menuView.hidden;
        
    }];
}

-(void)chooseMenuActionInIndex:(int)index
{

    CGRect __block rect  = _menuView.frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        rect.size.height -= 100;
        _menuView.hidden = YES;

        _menuView.frame = rect;
        
        [_menuView reloadItmesFrameWithFrame:_menuView.frame];
        
    } completion:^(BOOL finished) {

    }];
    
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            _homeCollectionView.hidden = YES;
            _homeTableView.hidden = NO;
            break;
        case 3:
            _homeTableView.hidden = YES;
            _homeCollectionView.hidden = NO;
            break;
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
