//
//  SWTopicVoiceView.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTopic.h"
@interface SWTopicVoiceView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

/** 上一个按钮 */
@property (weak, nonatomic) UIButton *lastPlayButton;
/** 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voicePlayButton;
/*🔊数据*/
@property (strong , nonatomic)SWTopic *topic;
@end
