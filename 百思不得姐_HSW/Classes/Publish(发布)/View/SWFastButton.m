//
//  SWFastButton.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWFastButton.h"
#import "UIView+GFFrame.h"

@implementation SWFastButton

-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.gf_y = 0;
    self.imageView.gf_centerX = self.gf_width * 0.5;
    
    //自己计算文字的宽
    [self.titleLabel sizeToFit];
    //设置lable
    self.titleLabel.gf_centerX = self.gf_width * 0.5;
    self.titleLabel.gf_y = self.gf_height - self.titleLabel.gf_height;
    
    
}
@end
