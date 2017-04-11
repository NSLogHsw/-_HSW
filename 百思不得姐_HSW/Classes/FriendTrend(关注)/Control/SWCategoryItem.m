//
//  SWCategoryItem.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWCategoryItem.h"

@implementation SWCategoryItem
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
