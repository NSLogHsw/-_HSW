//
//  SWAddModel.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAddModel : NSObject

/*广告地址*/
@property (nonatomic ,strong)NSString *w_picurl;
/*广告跳转界面*/
@property (nonatomic ,strong)NSString *ori_curl;
/*广告宽*/
@property (nonatomic ,assign)CGFloat w;
/*广告高*/
@property (nonatomic ,assign)CGFloat h;
@end
