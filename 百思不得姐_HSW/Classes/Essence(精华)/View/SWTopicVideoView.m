//
//  SWTopicVideoView.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWTopicVideoView.h"
#import "GFSeeBigImageViewController.h"

//苹果自带播放视频框架

#import <MediaPlayer/MediaPlayer.h>//视频播放类
#import <AVFoundation/AVFoundation.h>
#import <AFNetworkReachabilityManager.h>
#import <AVKit/AVKit.h>



@interface SWTopicVideoView ()


@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@end
@implementation SWTopicVideoView
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //从Xib中加载进来的控件默认 UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage)];
    self.videoImageView.userInteractionEnabled = YES;
    [self.videoImageView addGestureRecognizer:gesture];
    
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
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    if ([topic.playcount integerValue]>10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",[topic.playcount integerValue] / 10000.0];
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    //%02zd - 占据两位 空出来用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (IBAction)butttonDidClickPlay:(id)sender {
    
    
#warning IOS9 之前

    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion integerValue ] < 9) {
        //IOS9 之前
        MPMoviePlayerController * moviewVc = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentModalViewController:moviewVc animated:YES];
    }else{
        //IOS9 以上
        AVPlayer  * player = [AVPlayer playerWithURL:[NSURL URLWithString:self.topic.videouri]];
        AVPlayerViewController * playerVc = [[AVPlayerViewController alloc]init];
        playerVc.player = player;
        [playerVc.player play];//开始播放
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerVc animated:YES completion:nil];
    }
    
}

@end
