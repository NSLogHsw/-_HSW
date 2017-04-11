//
//  SWTabbarViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWTabbarViewController.h"
#import "SWNewViewController.h"
#import "SWEssenceViewController.h"
#import "SWFollowViewController.h"

#import "SWMeTableViewController.h"
#import "SWTabbr.h"

@interface SWTabbarViewController ()

@end

@implementation SWTabbarViewController
//只加载一次
#pragma mark - 设置tabBar字体格式
+(void)load
{
    

    UITabBarItem *titleItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //正常
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    //选中
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setUpAllChildView];
    //添加所有按钮内容
    [self setUpTabBarBtn];
    //更换系统tabbar
    [self setUpTabBar];
}
-(void)setUpAllChildView{
    //精华
    SWEssenceViewController *essence = [[SWEssenceViewController alloc] init];
    SWNavigationViewController *nav = [[SWNavigationViewController alloc]initWithRootViewController:essence];
    [self addChildViewController:nav];
    
    //新帖
    SWNewViewController *new = [[SWNewViewController alloc] init];
    SWNavigationViewController *nav1 = [[SWNavigationViewController alloc]initWithRootViewController:new];
    [self addChildViewController:nav1];
    
    //关注
    SWFollowViewController *firend = [[SWFollowViewController alloc] init];
    SWNavigationViewController *nav2 = [[SWNavigationViewController alloc]initWithRootViewController:firend];
    [self addChildViewController:nav2];
    
    //我
    SWMeTableViewController *me = [[SWMeTableViewController alloc]init];
    SWNavigationViewController *nav3 = [[SWNavigationViewController alloc]initWithRootViewController:me];
    [self addChildViewController:nav3];

}
#pragma mark - 添加所有按钮内容
-(void)setUpTabBarBtn{

        SWNavigationViewController *nav = self.childViewControllers[0];
        nav.tabBarItem.title = @"精选";
        nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
        
        SWNavigationViewController *nav1 = self.childViewControllers[1];
        nav1.tabBarItem.title = @"新帖";
        nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
        nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
        SWNavigationViewController *nav2 = self.childViewControllers[2];
        nav2.tabBarItem.title = @"关注";
        nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
        nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
        SWNavigationViewController *nav3 = self.childViewControllers[3];
        nav3.tabBarItem.title = @"我";
        nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
        nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
        
}
-(void)setUpTabBar{
    SWTabbr *tabBar = [[SWTabbr alloc] init];
    tabBar.backgroundColor = [UIColor clearColor];
    //把系统换成自定义
    [self setValue:tabBar forKey:@"tabBar"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
