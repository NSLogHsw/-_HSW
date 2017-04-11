//
//  SWRedStatrTableViewCell.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWRedStatrTableViewCell.h"


@interface SWRedStatrTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *introlView;

@end
@implementation SWRedStatrTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


-(void)setItems:(SWRedStartItems *)items{
    _items = items;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:items.header.big.firstObject]placeholderImage:[UIImage imageNamed:@"defaultTagIcon"]];
    self.nameView.text = items.name;
    self.introlView.text = items.introduction;
    if (items.isVip) {
        self.vipView.hidden = NO;
    }else{
        self.vipView.hidden = YES;
    }
}
@end
