//
//  SWCaregroyCell.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWCaregroyCell.h"

#define SWNomolColor [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1]
@interface SWCaregroyCell ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
@implementation SWCaregroyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.gf_height = self.contentView.gf_height - 1;
}


/**
 选中的样式

 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.redView.hidden = !selected;
    //选中字体颜色
    self.textLabel.textColor = selected ? [UIColor redColor] : SWNomolColor;
    //选中背景View
    UIView * whiteColor = [UIView new];
    whiteColor.backgroundColor = [UIColor whiteColor];
    UIView * garyColor = [UIView new];
    garyColor.backgroundColor = [UIColor grayColor];
    
    self.selectedBackgroundView = selected ? whiteColor : garyColor;
}

-(void)setItem:(SWCategoryItem *)item{
    _item = item;
    self.textLabel.text = item.name;
    
}


@end
