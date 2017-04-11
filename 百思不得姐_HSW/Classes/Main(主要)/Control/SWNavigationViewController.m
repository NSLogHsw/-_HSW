//
//  SWNavigationViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWNavigationViewController.h"
#import "UIBarButtonItem+GFItem.h"

/**
 设置手势代理方法
 */
@interface SWNavigationViewController ()<UIGestureRecognizerDelegate>


@end

@implementation SWNavigationViewController


/**
 程序进入只会加载一次
 */
+(void)load{
    
    //设置bar 字体
    UINavigationBar * bar = [UINavigationBar appearance];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [bar setTitleTextAttributes:dict];
    
    //设置bar 背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //设置item 的字体和颜色
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    NSMutableDictionary * itemDict = [NSMutableDictionary dictionary];
    itemDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
    NSMutableDictionary *itemDisableDict = [NSMutableDictionary dictionary];
    itemDisableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //StateDisabled
    [item setTitleTextAttributes:itemDisableDict  forState:UIControlStateDisabled];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate= self;
    //静止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    [self.view addGestureRecognizer:pan];
    
    
    
}

//消除方法警告
-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
    
}
#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //是否出发手势
    return self.childViewControllers.count > 1;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        //统一设置NavigationBar顶部返回按钮样式和文字
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //按钮大小匹配
        [backBtn sizeToFit];
        //设置按钮和边界的距离
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIView *view = [[UIView alloc]init];
        view.frame = backBtn.bounds;
        [view addSubview:backBtn];
        
        //修改导航栏左边的Item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //必须放在最后，否则之前的设置都会失效
    [super pushViewController:viewController animated:YES];
}

-(void)goBack{
    [self popViewControllerAnimated:YES];
}
@end
