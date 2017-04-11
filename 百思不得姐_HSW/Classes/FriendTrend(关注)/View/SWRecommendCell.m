
#import "SWRecommendCell.h"
#import "SWRecommendItem.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface SWRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *descView;
@property (weak, nonatomic) IBOutlet UILabel *lableView;

@end
@implementation SWRecommendCell

////设置自定义Cell的周围尺寸
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    //真正Cell的Frame,修改完之后要调用这个方法，要不之前设置无效
    [super setFrame:frame];
}



//因为使用了XIB，所以会调用一次awakeFromNib，在这里面可以进行一次性赋值
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //目前最新的头像形状
    _iconView.layer.cornerRadius = 10;
     _iconView.layer.masksToBounds = YES;

}

//自定义一个类方法用来调用XIB
+ (instancetype)SetupRecommendView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SWRecommendCell" owner:nil options:kNilOptions]lastObject];
}

/*
 @property (nonatomic,strong) NSString *image_list;
 @property (nonatomic,strong) NSString *sub_number;
 @property (nonatomic,strong) NSString *theme_name;
 */
//赋值
- (void)setRecommendItem:(SWRecommendItem *)recommendItem
{
    _recommendItem = recommendItem;
    
    //因为所有的数据都是从网上下载下来，所以头像的数据要使用SDWedImage来加载
    
    //头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultTagIcon~iphone"]];
    _nameView.text = recommendItem.theme_name;
    
    //名字
    CGFloat number = [recommendItem.sub_number floatValue];
    
    //关注数——大于10000如何显示和小于10000如何显示
    NSString *str;
    if (number >= 10000) {
        str = [NSString stringWithFormat:@"%.1f万人订阅",number/10000.0];
        _descView.text = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        _descView.text = [NSString stringWithFormat:@"%f人订阅",number];
    }
    
    //总帖数
    _lableView.text = recommendItem.post_num;
    
}

@end
