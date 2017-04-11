//
//  SWTopicCell.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWTopicCell.h"
#import "SWTopicPictureView.h"
#import "SWTopicVideoView.h"
#import "SWTopicVoiceView.h"


@interface SWTopicCell ()
/*图片View*/
@property (weak ,nonatomic) SWTopicPictureView * pictureView;
/**
  视频
 */
@property(weak,nonatomic)SWTopicVideoView * videoView;
/*声音View*/
@property (weak ,nonatomic) SWTopicVoiceView *voiceView;

@end
@implementation SWTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

#pragma mark － 懒加载
-(SWTopicPictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [SWTopicPictureView gf_viewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}
 
-(SWTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [SWTopicVideoView gf_viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

-(SWTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [SWTopicVoiceView gf_viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}


-(void)setTopic:(SWTopic *)topic
{
    _topic = topic;
    
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"]gf_circleImage];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.profileImageView.image = [image gf_circleImage];
    }];
    self.nameLabel.text = topic.name;
    
    //日期处理
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    /*数量显示以万为界*/
    [self setUpButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setUpButton:self.commentButton number:topic.comment placeholder:@"评论"];
    [self setUpButton:self.repostButton number:topic.repost placeholder:@"分享"];
    
//    //最热评论显示或者隐藏
//    if (topic.top_cmt) {//有最热评论
//        self.topCommentView.hidden = NO;
//        
//        //展示评论数据
//        NSString *content = topic.top_cmt.content;
//        NSString *username = topic.top_cmt.user.username;
//        
//        self.topCommentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
//        
//    }else{//没有最热评论
//        
//        self.topCommentView.hidden = YES;
//    }
    
#pragma mark - 根据类型判断
    if (topic.type == SWTopicWord) {//段子
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == SWTopicPicture){//图片
        
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.middleF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == SWTopicVideo){//声音
        
        self.videoView.hidden = NO;
        self.videoView.frame = topic.middleF;
        self.videoView.topic = topic;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == SWTopicVoice){//视频
        
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.middleF;
        self.voiceView.topic = topic;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

/**
 设置按钮数字
 */
-(void)setUpButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 重写这个方法：拦截所有cell frame的设置
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= SWMargin;
    frame.origin.y += SWMargin;
    
    [super setFrame:frame];
}


@end
