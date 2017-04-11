//
//  SWFollowViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWFollowViewController.h"
#import "SWFriendTrendViewController.h"
#import "SWSubscribeViewController.h"
#import "SWRecommendViewController.h"

@interface SWFollowViewController ()
//定义属性
@property (nonatomic,strong) UIButton *subscribeBtn;
@property (nonatomic,strong) UIButton *attentionBtn;

//当前显示窗口
@property(nonatomic,weak)UIViewController * showingVC;
@property(nonatomic,weak)UIView * underLine;


@end

@implementation SWFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置导航栏标题
    [self setupNavigatuionItemTitle];
    
    [self addChildViewController:[[SWSubscribeViewController alloc]init]];
    [self addChildViewController:[[SWFriendTrendViewController alloc]init]];
    
    
    //右边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] WithHighlighted:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(random)];
    
    
    
    //默认显示第一个按钮的视图
    [self subscribeBtn:self.subscribeBtn];
    
}
-(void)setupNavigatuionItemTitle{
    //一个View
    UIView *titleBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    //第一个按钮
    UIButton *subscribeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(0, 0, titleBtnView.gf_width * 0.5 , titleBtnView.gf_height);
    [subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [subscribeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [subscribeBtn addTarget:self action:@selector(subscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [subscribeBtn.titleLabel sizeToFit];
   
    [titleBtnView addSubview:subscribeBtn];
    
    //滚动线条
    CGFloat w = subscribeBtn.titleLabel.frame.size.width;
    CGFloat h = subscribeBtn.gf_height;
    UIView * underLine = [[UIView alloc]init];
    underLine.backgroundColor = [UIColor redColor];
    underLine.frame =CGRectMake(0, h, w, 3);
    [subscribeBtn.titleLabel addSubview:underLine];
    _underLine = underLine;
    
    
    //第二个按钮
    UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.frame = CGRectMake(titleBtnView.gf_width * 0.5, 0, titleBtnView.gf_width * 0.5 , titleBtnView.gf_height);
    [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [attentionBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [attentionBtn.titleLabel sizeToFit];
    [attentionBtn addTarget:self action:@selector(subscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleBtnView addSubview:attentionBtn];
    
    //最终把View设置成titleView
    self.navigationItem.titleView = titleBtnView;
    
    
}

//点击按钮
- (void)subscribeBtn:(UIButton *)btn
{
    //删除记录原来展示的视图 (视图切换)
    [self.showingVC.view removeFromSuperview];
    NSInteger index = [btn.superview.subviews indexOfObject:btn];
    self.showingVC = self.childViewControllers[index];
    self.showingVC.view.frame = CGRectMake(0, 0, SWScreenWidth, SWScreenHeight);
    [self.view addSubview:self.showingVC.view];
    
    //点击按钮线条跟着滚动
    [UIView animateWithDuration:.25 animations:^{
       _underLine.gf_x = btn.gf_x;
    }];

}
//点击左边按钮进入推荐关注页面
- (void)random
{
    SWRecommendViewController *recommend = [[SWRecommendViewController alloc]init];
    recommend.title = @"推荐关注";
    [self.navigationController pushViewController:recommend animated:YES];
    
}

@end
