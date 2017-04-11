//
//  SWUser.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;  // m： 男    f： 女
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
