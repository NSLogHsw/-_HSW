//
//  SWTopicCell.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTopic.h"

@interface SWTopicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
//@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
//@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;

@property(nonatomic,strong)SWTopic *  topic;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@end
