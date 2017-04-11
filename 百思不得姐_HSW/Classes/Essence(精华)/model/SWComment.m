//
//  SWComment.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWComment.h"

@implementation SWComment


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
    
}

-(CGFloat)cellHeight{
    
    //如果cell高度已经计算处理 就直接返回
    if (_cellHeight) return _cellHeight;
    //头像
    _cellHeight = SWiconH - 30;
    // 间距
    _cellHeight += SWMargin * 2;
    
    if (_content) {
        //文字
        CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * SWMargin;
        CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
        CGSize textSize = [_content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        _cellHeight += textSize.height;
    }
  
    return _cellHeight;
}

@end
