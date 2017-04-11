//
//  SWMeCollectionCell.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWMeCollectionCell.h"



@interface SWMeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *text;

@end
@implementation SWMeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}
-(void)setItem:(SWSquareItem *)item
{
    _item = item;
    
    
    self.text.text = item.name;
    
    //设置图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:nil];
    
}
@end
