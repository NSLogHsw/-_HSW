//
//  SWRecommendItem.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRecommendItem : NSObject

//根据写出的Plish文件找出相应的数据进行定义

//头像的URL
@property (nonatomic,strong) NSString *image_list;

//关注的数量
@property (nonatomic,strong) NSString *sub_number;

//名字
@property (nonatomic,strong) NSString *theme_name;

//总帖数
@property (nonatomic,strong) NSString *post_num;
@end
