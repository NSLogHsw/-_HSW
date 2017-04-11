//
//  SWAdViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWAdViewController.h"
#import "SWAddModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "SWHTTPSessionManager.h"
#import "SWTabbarViewController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"



@interface SWAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lunchImage;
@property (weak, nonatomic) IBOutlet UIView *acountImage;
@property (weak, nonatomic) IBOutlet UIButton *junbBtn;
@property (weak ,nonatomic) UIImageView *adView;
@property (weak ,nonatomic) NSTimer *timer;
@property (strong ,nonatomic) SWAddModel *item;
@end

@implementation SWAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setUpLaunchImage];
    
  
    
    //加载网络数据
    [self setUpAd];
    
    //创建定时器
    [self setUpNsTimer];
    
}

#pragma mark - 定时器
-(void)setUpNsTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
}
#pragma mark - 定时器运作和销毁广告界面
-(void)timerChange
{
    static NSInteger i = 3;
   
    --i;
    //按钮
    [self setJunBtn:i];
  
    if (i == 0) {
      
        [UIView animateWithDuration:3 animations:^{
            //去掉定时器
            [_timer invalidate];
            self.adView.alpha = 0;
        } completion:^(BOOL finished) {
            SWTabbarViewController *tabVc = [[SWTabbarViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
            
        }];
    }
}
-(void)setJunBtn:(NSInteger )i{
    //设置跳转文字
    self.junbBtn.layer.masksToBounds = YES;
    self.junbBtn.layer.cornerRadius = 10;
    [self.junbBtn setTitle:[NSString stringWithFormat:@"跳转(%zd)",i] forState:UIControlStateNormal];
    [self.junbBtn addTarget:self action:@selector(removeSuperViewSendHome) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设置启动图片
-(void)setUpLaunchImage
{

    self.lunchImage.image = [UIImage imageNamed:@"LaunchImage"];
    
}
#pragma mark - 加载网络数据
-(void)setUpAd
{
//    SWHTTPSessionManager *manager = [SWHTTPSessionManager manager];
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"code2"] = code2;
//    [manager GET:SWBSADURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
//        
//        NSDictionary *adDict = [responseObject[@"ad"]lastObject];
//        SWAddModel *item = [SWAddModel mj_objectWithKeyValues:adDict];
//        
//        self.item = item;
//        //        CGFloat W = GFScreenWidth;
//        //        CGFloat H = (GFScreenWidth / item.w) * item.h;
//        self.adView.frame = CGRectMake(0, 0 , SWScreenWidth, SWScreenHeight);
//        
//        [self.adView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    self.adView.frame = CGRectMake(0, 0 , SWScreenWidth, SWScreenHeight);
    
    [self.adView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488366298467&di=863b4ae3ab0f01c69ec789beca167e57&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F77094b36acaf2edd9a034601891001e938019363.jpg"]];
    self.adView.alpha = 1;
    [self.lunchImage removeFromSuperview];
    //设置跳转文字
    [self.junbBtn setTitle:[NSString stringWithFormat:@"点击跳转"] forState:UIControlStateNormal];
    [self.adView addSubview:self.junbBtn];
    

}
-(UIImageView *)adView
{
    if (!_adView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        [self.acountImage addSubview:imageView];
        _adView = imageView;
        [imageView sizeToFit];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
        [imageView addGestureRecognizer:tap];
    }
    return _adView;
}
#pragma mark - 跳转
-(void)jump
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}
-(void)removeSuperViewSendHome{
    
    [UIView animateWithDuration:1 animations:^{
        
        self.adView.alpha = .5;
        
        //去掉定时器
        [_timer invalidate];
        
    }completion:^(BOOL finished) {
        SWTabbarViewController *tabVc = [[SWTabbarViewController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
        
    }];
    
   
}
@end
