//
//  SWComment.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUser.h"

@interface SWComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (strong , nonatomic)SWUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频路径 */
@property (nonatomic, copy) NSString * voiceuri;


@property(nonatomic,assign)CGFloat cellHeight;


@end
