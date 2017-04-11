//
//  SWTopicVoiceView.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWTopicVoiceView.h"
#import "GFSeeBigImageViewController.h"
//苹果自带播放音频
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static AVPlayer * player_;
static UIButton * lastPlayButton_;
static SWTopic * lastTopic_;
@implementation SWTopicVoiceView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage)];
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:gesture];
}
/**
 查看大图
 */
-(void)seeBigImage
{
    GFSeeBigImageViewController *seeBigVc = [[GFSeeBigImageViewController alloc] init];
    seeBigVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigVc animated:YES completion:nil];
}
-(void)setTopic:(SWTopic *)topic
{
    _topic = topic;
    
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    if ([topic.playcount integerValue]>10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",[topic.playcount integerValue] / 10000.0];
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    //播放按钮设置
    [self.voicePlayButton setImage:[UIImage imageNamed:topic.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化player
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        player_ = [AVPlayer playerWithPlayerItem:playerItem];
    });
    
}
- (IBAction)ClickTo:(UIButton *)sender {
    sender.selected = !sender.isSelected;
        lastPlayButton_.selected = !lastPlayButton_.isSelected;
        if (lastTopic_ != self.topic) {
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
    
            [player_ replaceCurrentItemWithPlayerItem:playerItem];
            [player_ play];
            lastTopic_.voicePlaying = NO;
            self.topic.voicePlaying = YES;
    
            [lastPlayButton_ setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
    
        }else{
            if(lastTopic_.voicePlaying){
                [player_ pause];
                self.topic.voicePlaying = NO;
                [sender setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
            }else{
                [player_ play];
                self.topic.voicePlaying = YES;
                [sender setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
            }
        }
        lastTopic_ = self.topic;
        lastPlayButton_ = sender;

    
}


@end
