//
//  SWStarGameViewControl.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWStarGameViewControl.h"
#import "SWRedStartViewController.h"
#import "SWFansFastestViewController.h"
#import "SWContributionViewController.h"
#import "SWFansCountViewController.h"
@interface SWStarGameViewControl ()

@end

@implementation SWStarGameViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SWBgColor;
    self.navigationItem.title = @"红人榜";
    self.topTitleBtn = 4;
//    self.titleContens = @[@"红人榜",@"涨粉最快",@"贡献榜",@"粉丝总数"];
    [self addAllChildViewController];
}
-(void)addAllChildViewController{
    //红人榜
    SWRedStartViewController *startView = [[SWRedStartViewController alloc]init];
    startView.title = @"红人榜";
    [self addChildViewController:startView];
    
    //涨粉最快
    SWFansFastestViewController *fansFastest = [[SWFansFastestViewController alloc]init];
    fansFastest.title = @"涨粉最快";
    [self addChildViewController:fansFastest];
    
    //贡献榜
    SWContributionViewController *contribution = [[SWContributionViewController alloc]init];
    contribution.title = @"贡献榜";
    [self addChildViewController:contribution];
    
    //粉丝总数
    SWFansCountViewController *fansCount = [[SWFansCountViewController alloc]init];
    fansCount.title = @"粉丝总数";
    [self addChildViewController:fansCount];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
