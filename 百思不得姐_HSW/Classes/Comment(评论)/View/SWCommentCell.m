//
//  SWCommentCell.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWCommentCell.h"



@interface SWCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageUser;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *nameText;

@property (weak, nonatomic) IBOutlet UILabel *contentText;
@end
@implementation SWCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setComment:(SWComment *)comment{
    _comment = comment;
    //用户头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"]gf_circleImage];
    [self.imageUser sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.imageUser.image = [image gf_circleImage];
    }];
    //用户昵称
    self.nameText.text = comment.user.username;
    //文本，没做适配
    self.contentText.text = comment.content;
    //判断性别
     NSString *sexImageSexName = [comment.user.sex isEqualToString:SWBoy] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexImage.image = [UIImage imageNamed:sexImageSexName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
