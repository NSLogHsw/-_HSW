//
//  SWUserItem.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUserItem : NSObject
@property (nonatomic,strong) NSString * header;
@property (nonatomic,assign) NSInteger  fans_count;
@property (nonatomic,strong) NSString * screen_name;
@property (nonatomic,assign,getter=isVip) BOOL is_vip;
@end
