//
//  SWCaregroyCell.h
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//


#import "SWUserCell.h"

@interface SWUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *countView;
@property (weak, nonatomic) IBOutlet UIImageView *VIp;
@end

@implementation SWUserCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
- (void)setUserItem:(SWUserItem *)userItem
{
    _userItem = userItem;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userItem.header] placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    self.nameView.text = userItem.screen_name;
    self.countView.text = [NSString stringWithFormat:@"%zd人关注",userItem.fans_count];
    
    if (userItem.is_vip) {
        self.nameView.textColor = [UIColor redColor];
        self.VIp.hidden = NO;
    }else
    {
        self.nameView.textColor = [UIColor blackColor];
        self.VIp.hidden = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    self.iconView.layer.cornerRadius = self.iconView.gf_width * 0.5;
//    self.iconView.layer.masksToBounds = YES;
}


- (IBAction)recommendClick:(id)sender {
    SWBSLog(@"%s", __func__);
}


@end
