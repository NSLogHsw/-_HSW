//
//  SWRefreshFooter.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWRefreshFooter.h"

@implementation SWRefreshFooter

-(void)prepare
{
    [super prepare];
    
    //上拉刷新，友情提醒
    [self setTitle:@"已帮您加载完全部数据" forState:MJRefreshStateNoMoreData];
}


@end
