//
//  SWRedStartItems.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWHeaderItems.h"


@interface SWRedStartItems : NSObject
//头像
@property (nonatomic,strong) SWHeaderItems *header;

//名字
@property (nonatomic,strong) NSString *name;

//是否VIP
@property (nonatomic,assign,getter=isVip) BOOL jie_v;

//简介
@property (nonatomic,strong) NSString *introduction;
@end
