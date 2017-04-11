//
//  SWCommentViewController.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTopic.h"

#import "SWCommentCell.h"

@interface SWCommentViewController : UIViewController
/** 帖子模型数据 */
@property (nonatomic, strong) SWTopic *topic;

@property(nonatomic,weak)SWCommentCell * cell;

@end
