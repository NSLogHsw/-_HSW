//
//  SWEssenceViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWEssenceViewController.h"
#import "SWAllViewController.h"
#import "SWVideoViewController.h"
#import "SWVoiceViewController.h"
#import "SWPictureViewController.h"
#import "SWPictureViewController.h"
#import "SWWordViewController.h"
#import "SWTitleButton.h"

#import "SWStarGameViewControl.h"

@interface SWEssenceViewController ()<UIScrollViewDelegate>

/*当前选中的Button*/
@property (weak ,nonatomic) SWTitleButton *selectTitleButton;
/*标题按钮地下的指示器*/
@property (weak ,nonatomic) UIView *indicatorView ;
/*UIScrollView*/
@property (weak ,nonatomic) UIScrollView *scrollView;
/*标题栏*/
@property (weak ,nonatomic) UIView *titleView;

@end

@implementation SWEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavBar];
    //添加子控制器
    [self setUpChildViewControllers];
    [self setUpScrollView];
    [self setUpTitleView];
    [self addChildViewController];
}
#pragma mark - 设置导航条
-(void)setUpNavBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] WithHighlighted:[UIImage imageNamed:@"nav_item_game_click_icon"] Target:self action:@selector(game)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"nav_item_ramdon_icon"] WithHighlighted:[UIImage imageNamed:@"nav_item_ramdon_click_icon"] Target:self action:@selector(random)];
    
    //TitieView
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    _topTitleBtn = 5;
}

-(void)setUpChildViewControllers
{
//    //全部
    SWAllViewController *allVc = [[SWAllViewController alloc] init];
    [self addChildViewController:allVc];
    
    //视频
    SWVideoViewController *videoVc = [[SWVideoViewController alloc] init];
    [self addChildViewController:videoVc];
    
    //声音
    SWVoiceViewController *voiceVc = [[SWVoiceViewController alloc] init];
    [self addChildViewController:voiceVc];
    
    //图片
    SWPictureViewController *pictureVc = [[SWPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
    //段子
    SWWordViewController *wordVc = [[SWWordViewController alloc] init];
    [self addChildViewController:wordVc];
    
}
/**
 添加scrollView
 */
-(void)setUpScrollView
{
    
    //不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
    
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(self.view.gf_width * self.childViewControllers.count, 0);
}
/**
 添加标题栏View
 */
-(void)setUpTitleView
{
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    titleView.frame = CGRectMake(0, 64 , self.view.gf_width, 35);
    [self.view addSubview:titleView];
    
    _titleContens = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = _titleContens.count;
    
    CGFloat titleButtonW = titleView.gf_width / _topTitleBtn;
    CGFloat titleButtonH = titleView.gf_height;
    
    for (NSInteger i = 0;i < count; i++) {
        SWTitleButton *titleButton = [SWTitleButton buttonWithType:UIButtonTypeCustom];
        
        titleButton.tag = i; //绑定tag
        [titleButton addTarget:self action:@selector(titelClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleButton setTitle:_titleContens[i] forState:UIControlStateNormal];
        CGFloat titleX = i * titleButtonW;
        titleButton.frame = CGRectMake(titleX, 0, titleButtonW, titleButtonH);
        
        [titleView addSubview:titleButton];
        
    }
    //按钮选中颜色
    SWTitleButton *firstTitleButton = titleView.subviews.firstObject;
    //底部指示器
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    
    indicatorView.gf_height = 2;
    indicatorView.gf_y = titleView.gf_height - indicatorView.gf_height;
    
    [titleView addSubview:indicatorView];
    
    //默认选择第一个全部TitleButton
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.gf_width = firstTitleButton.titleLabel.gf_width;
    indicatorView.gf_centerX = firstTitleButton.gf_centerX;
    [self titelClick:firstTitleButton];
}
/**
 标题栏按钮点击
 */
-(void)titelClick:(SWTitleButton *)titleButton
{
    if (self.selectTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:SWTitleButtonDidRepeatShowClickNotificationCenter object:nil];
    }
    
    //控制状态
    self.selectTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectTitleButton = titleButton;
    
    //指示器
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.gf_width = titleButton.titleLabel.gf_width;
        self.indicatorView.gf_centerX = titleButton.gf_centerX;
    }];
    
    //让uiscrollView 滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.scrollView.gf_width * titleButton.tag;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 添加子控制器View
-(void)addChildViewController
{
    //在这里面添加自控制器的View
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.gf_width;
    //取出自控制器
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * self.scrollView.gf_width, 0, self.scrollView.gf_width, self.scrollView.gf_height);
    [self.scrollView addSubview:childVc.view];
    
}

#pragma mark - <UIScrollViewDelegate>

/**
 点击动画后停止调用
 */

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildViewController];
}


/**
 人气拖动的时候，滚动动画结束时调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //点击对应的按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.gf_width;
    SWTitleButton *titleButton = self.titleView.subviews[index];
    
    [self titelClick:titleButton];
    
    [self addChildViewController];
}
-(void)game
{
    SWStarGameViewControl * vc = [[SWStarGameViewControl alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)random
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
