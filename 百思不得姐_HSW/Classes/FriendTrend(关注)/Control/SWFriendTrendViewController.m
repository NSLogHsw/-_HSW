//
//  SWFriendTrendViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWFriendTrendViewController.h"
#import "SWMemberViewController.h"
@interface SWFriendTrendViewController ()

@end

@implementation SWFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavBar];

}

-(void)setUpNavBar{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] WithHighlighted:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(friendsRecommentIcon)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"Search"] WithHighlighted:[UIImage imageNamed:@"Search-click"] Target:self action:@selector(Search)];
    
    
    //Titie
    self.navigationItem.title = @"关注";
}
- (IBAction)Login:(id)sender {
    
    //跳转到GFMemberViewController
    SWMemberViewController *memberVc = [[SWMemberViewController alloc] init];
    
    [self presentViewController:memberVc animated:YES completion:nil];
    
}
- (IBAction)regist:(id)sender {
}
-(void)friendsRecommentIcon
{
 
}

-(void)Search
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
