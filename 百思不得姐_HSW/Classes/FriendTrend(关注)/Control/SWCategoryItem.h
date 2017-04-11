//
//  SWCategoryItem.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCategoryItem : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger count;


//这个类对应的用户总数据
@property (nonatomic,strong) NSMutableArray * users;
//总数
@property (nonatomic,assign) NSInteger total;
//当前页码
@property (nonatomic,assign) NSInteger currentPage;


@end
