//
//  SWTopicViewController.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTopic.h"
@interface SWTopicViewController : UITableViewController
/*类型判断*/
//@property (assign ,nonatomic) GFTopicType type;

/**
 产生get方法
 限时成员访问和任意修改 使.(点)语法失效
 */
-(SWTopicType)type;
@end
