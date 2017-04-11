//
//  SWRefreshNormalHeader.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWRefreshNormalHeader.h"

@implementation SWRefreshNormalHeader

-(void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor purpleColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor purpleColor];
    [self setTitle:@"下拉SWSWSW" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"啪啪啪" forState:MJRefreshStateRefreshing];
}
@end
