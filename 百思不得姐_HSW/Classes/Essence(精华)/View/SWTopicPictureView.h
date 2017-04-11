//
//  SWTopicPictureView.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTopic.h"
#import <DALabeledCircularProgressView.h>
#import "GFSeeBigImageViewController.h"

@interface SWTopicPictureView : UIView
/*图片数据*/
@property (strong , nonatomic)SWTopic *topic;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
