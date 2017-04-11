//
//  SWMeSendVc.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/3/2.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWMeSendVc.h"
#import "SWSquareItem.h"

@interface SWMeSendVc (){
    UIWebView * _web;
    
}
@end

@implementation SWMeSendVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView * web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    SWBSLog(@"===%@=====%@",self.itemData.url,self.itemData.icon);
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.itemData.url]]];
    
    _web = web;
    self.navigationItem.title = self.itemData.name;
    
    UIBarButtonItem *item = [UIBarButtonItem initWithNormalImage:self.itemData.icon target:self action:@selector(setting) width:30 height:30];
    
    
    
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)setting{
    
}
@end
