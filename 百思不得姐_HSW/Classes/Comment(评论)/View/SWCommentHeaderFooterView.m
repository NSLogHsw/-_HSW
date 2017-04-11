//
//  SWCommentHeaderFooterView.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWCommentHeaderFooterView.h"

@implementation SWCommentHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = SWBgColor;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont systemFontOfSize:13];
}

@end
