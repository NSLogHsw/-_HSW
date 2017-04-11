//
//  UIBarButtonItem+GFItem.h
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GFItem)

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action;


+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action;



/**
 返回
 */
+(UIBarButtonItem *)backItemWithImage:(UIImage *)image WithHighlightedImage:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action title:(NSString *)title;



/**
 *根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;



@end
