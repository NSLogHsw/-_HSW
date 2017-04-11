//
//  SWTopicViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWTopicViewController.h"
#import "SWTopicCell.h"
#import "SWCommentViewController.h"

@interface SWTopicViewController ()
/*请求管理者*/
@property (strong , nonatomic)SWHTTPSessionManager *manager;
/*所有帖子数据*/
@property (strong , nonatomic)NSMutableArray<SWTopic *> *topics;
/*maxtime*/
@property (strong , nonatomic)NSString *maxtime;


@end
static NSString *const topicID = @"topic";
@implementation SWTopicViewController


#pragma mark - 消除警告
-(SWTopicType)type
{
    return 0;
}
#pragma mark - 懒加载
-(SWHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [SWHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTable];
    
    [self setupRefresh];
    
    [self setUpNote];
}
-(void)setUpTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(SWTitleViewH + SWNavMaxY, 0, SWTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = SWBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SWTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [SWRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark - 加载新数据
-(void)loadNewTopics
{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //2.凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    //发送请求
    [_manager GET:SWBSURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        //存取maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self. topics = [SWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showWithStatus:@"网络繁忙，请稍后再试~"];
        [self.tableView.mj_header endRefreshing];
        
    }];
}
-(void)setUpNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:SWTabBarButtonDidRepeatShowClickNotificationCenter object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:SWTitleButtonDidRepeatShowClickNotificationCenter object:nil];
}

#pragma mark - 监听
/**
 *  监听TabBar按钮的重复点击
 */
- (void)tabBarButtonRepeatClick
{
    // 如果当前控制器的view不在window上，就直接返回,否则这个方法调用五次
    if (self.view.window == nil) return;
    
    // 如果当前控制器的view跟window没有重叠，就直接返回
    if (![self.view isShowingOnKeyWindow]) return;
    
    // 进行下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  监听标题按钮的重复点击
 */
- (void)titleButtonRepeatClick
{
    [self tabBarButtonRepeatClick];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 加载更多数据
-(void)loadMoreData
{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //2.凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"type"] = @(self.type);
    
    //发送请求
    [_manager GET:SWBSURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        //存储这一页的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [responseObject writeToFile:@"/Users/apple/Desktop/ceshi.plist" atomically:YES];
        
        //字典转模型
        NSMutableArray<SWTopic *> *moreTopics = [SWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showWithStatus:@"网络繁忙，请稍后再试~"];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SWTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}
//// cell动画
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //设置Cell的动画效果为3D效果
//    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTopic *topic = _topics[indexPath.row];
    
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWCommentViewController *commentVc = [[SWCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //清理缓存 放在这个个方法中调用频率过快
    [[SDImageCache sharedImageCache] clearMemory];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //清理缓存
//    [[SDImageCache sharedImageCache] clearMemory];
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
@end
