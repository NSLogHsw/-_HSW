
#import <UIKit/UIKit.h>
@class SWRecommendItem;

@interface SWRecommendCell : UITableViewCell

@property (nonatomic,strong) SWRecommendItem * recommendItem;

+ (instancetype)SetupRecommendView;

@end
