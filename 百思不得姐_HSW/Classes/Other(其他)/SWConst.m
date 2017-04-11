#import<UIKit/UIKit.h>

/*常用数*/
CGFloat const SWMargin = 10;

/*标签间隔*/
CGFloat const SWTagMargin = 5;

/*标签高度*/
CGFloat const SWTagHeight = 25;

/*头像高*/
CGFloat const SWiconH = 55;
/*底部View(评论，分享，顶，踩) 高*/
CGFloat const SWDcrcH = 35;
/*最热评论label高*/
CGFloat const SWHotCommentLabel = 18;
/*大图压缩高*/
CGFloat const SWLargImageCompressH = 250;

/*UITabBar高度*/
CGFloat const SWTabBarH = 49;

/*导航栏的最大Y值*/
CGFloat const SWNavMaxY = 64;

/*标题栏高度*/
CGFloat const SWTitleViewH = 35;


/*tabBar重复点击通知*/
NSString * const SWTabBarButtonDidRepeatShowClickNotificationCenter = @"SWTabBarButtonDidRepeatShowClickNotificationCenter";
/*标题按钮重复点击通知*/
NSString * const SWTitleButtonDidRepeatShowClickNotificationCenter = @"SWTitleButtonDidRepeatShowClickNotificationCenter";


/*请求URL*/
NSString * const SWBSURL = @"http://api.budejie.com/api/api_open.php";

/*请求URL*/
NSString * const SWBSADURL = @"http://mobads.baidu.com/cpro/ui/mads.php";



/******************* 红人榜 *******************/

//红人榜
#define SWRedStartURL @"http://d.api.budejie.com/user/category/35/budejie-msite-1.0/1-100.json?"

//涨粉最快
#define SWfansFastestURL @"http://d.api.budejie.com/user/rank/fansrise/baisishequ-iphone-3.8/0-50.json?"
//贡献榜
#define SWContributionURL @""
//粉丝总数
#define SWFansCountURL @"http://d.api.budejie.com/user/rank/fans/baisishequ-iphone-3.8/0-50.json?"



/*男*/
NSString * const SWBoy = @"m";
/*女*/
NSString * const SWGirl = @"f";

