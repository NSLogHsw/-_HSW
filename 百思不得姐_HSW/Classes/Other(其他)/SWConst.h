#import<UIKit/UIKit.h>

/*常用数*/
UIKIT_EXTERN CGFloat const SWMargin;
/*标签间隔*/
UIKIT_EXTERN CGFloat const SWTagMargin;
/*标签高度*/
UIKIT_EXTERN CGFloat const SWTagHeight;
/*头像高*/
UIKIT_EXTERN CGFloat const SWiconH;
/*底部评论，分享，顶，踩 高*/
UIKIT_EXTERN CGFloat const SWDcrcH;
/*最热评论label高*/
UIKIT_EXTERN CGFloat const SWHotCommentLabel;
/*大图压缩高*/
UIKIT_EXTERN CGFloat const SWLargImageCompressH;

/*UITabBar高度*/
UIKIT_EXTERN CGFloat const SWTabBarH;
/*标题栏高度*/
UIKIT_EXTERN CGFloat const SWTitleViewH;
/*导航栏的最大Y值*/
UIKIT_EXTERN CGFloat const SWNavMaxY;


/*tabBar重复点击通知*/
UIKIT_EXTERN NSString * const SWTabBarButtonDidRepeatShowClickNotificationCenter;
/*标题按钮重复点击通知*/
UIKIT_EXTERN NSString * const SWTitleButtonDidRepeatShowClickNotificationCenter;



/*请求URL*/
UIKIT_EXTERN NSString * const SWBSURL;

/*请求广告URL*/
UIKIT_EXTERN NSString * const SWBSADURL;

/*男*/
UIKIT_EXTERN NSString * const SWBoy;
/*女*/
UIKIT_EXTERN NSString * const SWGirl;


/******************* 红人榜 *******************/

//红人榜
#define SWRedStartURL @"http://d.api.budejie.com/user/category/35/budejie-msite-1.0/1-100.json?"

//涨粉最快
#define SWfansFastestURL @"http://d.api.budejie.com/user/rank/fansrise/baisishequ-iphone-3.8/0-50.json?"
//贡献榜
#define SWContributionURL @""
//粉丝总数
#define SWFansCountURL @"http://d.api.budejie.com/user/rank/fans/baisishequ-iphone-3.8/0-50.json?"



