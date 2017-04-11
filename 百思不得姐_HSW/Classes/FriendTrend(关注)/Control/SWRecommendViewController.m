//
//  SWRecommendViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWRecommendViewController.h"
#import "SWCategoryItem.h"
#import "SWCaregroyCell.h"
#import "SWUserCell.h"
#import "SWUserItem.h"

/**
    花瓶抓取的数据源

 */
#define SWUserURL @"http://api.budejie.com/api/api_open.php?a=list&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=subscribe&category_id=35&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&page=1&pagesize=50&udid=&ver=4.2"

/**分类*/
#define SWCategoryURL @"http://api.budejie.com/api/api_open.php?a=category&appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=f1e1e75d11ec5e8a96503b30220f196e37759455&udid=&ver=4.2"

/**左侧数据*/
#define SWUrl_ @"http://api.budejie.com/api/api_open.php"

static NSString *const caregroyID = @"caregroyCell";
static NSString *const userID = @"userID";
@interface SWRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;
//AFN请求管理者
@property (nonatomic,strong) SWHTTPSessionManager * manager;
//左侧数据
@property (nonatomic,strong) NSArray *caregroyItems;
//请求参数
@property (nonatomic,strong) NSMutableDictionary *parameters;
@end

@implementation SWRecommendViewController
//懒加载请求数据方式
- (SWHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [SWHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建表
    [self setUpTableView];
    //刷新右侧数据
    [self setRefresh];
    //加载左侧的类别数据
    [self setupRightData];
}

-(void)setUpTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //坐标
    self.leftTable.frame = CGRectMake(0, 64, SWScreenWidth * .3, SWScreenHeight - 64);
    self.rightTable.frame = CGRectMake(SWScreenWidth * .3, 64, SWScreenWidth * .7, SWScreenHeight- 64);
    
    _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    _rightTable.rowHeight = 60;
    _leftTable.rowHeight = 44;
    //为了区分颜色
//    self.leftTable.backgroundColor = [UIColor redColor];
//    self.rightTable.backgroundColor = [UIColor purpleColor];
    //注册
    //左侧注册
    [_leftTable registerNib:[UINib nibWithNibName:NSStringFromClass([SWCaregroyCell class]) bundle:nil] forCellReuseIdentifier:caregroyID];
    //右侧注册
    [_rightTable registerNib:[UINib nibWithNibName:NSStringFromClass([SWUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
}

-(void)setRefresh{
    
    //下拉刷新数据
    self.rightTable.mj_header = [SWRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.rightTable.mj_footer = [SWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //进入页面的时候下拉刷新样式应该隐藏
    self.rightTable.mj_footer.hidden = YES;
}
#pragma mark － 加载左侧数据，再根据左侧数据模型 －－》给右侧请求
-(void)setupRightData{
    [SVProgressHUD showWithStatus:@"啪啪啪..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_manager GET:SWUrl_ parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [SVProgressHUD dismiss];
        //将模型保存到数组中
       _caregroyItems =  [SWCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表
        [_leftTable reloadData];

        //默认选中第一行cell
        [_leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //点击左侧  右侧表刷新的效果
        [self.rightTable.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - tableViewdelegate and dataSouce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //左侧表行数
    if (tableView == _leftTable)return _caregroyItems.count;
    [self checkFooterState];
    //右侧表行数(根据所选中的左侧模型数据 “users” 来返回右侧的行数)
    return  [self.caregroyItems[self.leftTable.indexPathForSelectedRow.row] users].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTable) {
        SWCaregroyCell *cell = [tableView dequeueReusableCellWithIdentifier:caregroyID];
        cell.item = self.caregroyItems[indexPath.row];
        return cell;
    }else
    {
        SWUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userItem = [self.caregroyItems[self.leftTable.indexPathForSelectedRow.row] users][indexPath.row];
        return cell;
    }
}
#pragma mark (点击时候掉用)

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    //停止加载
//    [self.rightTable.mj_header endRefreshing];
//    [self.rightTable.mj_footer endRefreshing];
//    
//    SWCategoryItem * item = _caregroyItems[indexPath.row];
//    if (item.users.count) {
//        // 显示曾经的数据
//        [_rightTable reloadData];
//    }else{
//        [_rightTable reloadData];
//        [_rightTable.mj_header beginRefreshing];
//    }
}
#pragma mark － 加载右侧数据
-(void)loadNewData{
    [SVProgressHUD showWithStatus:@"啪啪啪..."];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //找到所选中的对应的Cell
    SWCategoryItem * categoryItem = self.caregroyItems[self.leftTable.indexPathForSelectedRow.row];
    //设置当前页面为第一页
    categoryItem.currentPage = 1;
    //加载数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    //此参数作为传递ID数据
    parameters[@"category_id"] = @(categoryItem.ID);
    parameters[@"page"] = @(categoryItem.currentPage);
    self.parameters = parameters;
    [_manager GET:SWUrl_ parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * users = [SWUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //当加载新的数据时候应该把老数据删除
        [categoryItem.users removeAllObjects];
        //添加新数据
        [categoryItem.users addObjectsFromArray:users];
        //记录右侧出现的数量一共有多少和总数进行判断
        categoryItem.total = [responseObject [@"total"] integerValue ];
        //判断是否最后一次请求
        if (self.parameters != parameters) return ;
        //刷新表
        [self.rightTable reloadData];
        [self.rightTable.mj_header endRefreshing];
        //加载状态更新
        [self checkFooterState];
        
         [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //判断是否是最后一次请求
        if (self.parameters != parameters) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 结束刷新
        [self.rightTable.mj_footer endRefreshing];
         [SVProgressHUD dismiss];
    }];

}
#pragma mark － 加载更多
-(void)loadMoreData{
    //找到所选中的对应的Cell
    SWCategoryItem * categoryItem = self.caregroyItems[self.leftTable.indexPathForSelectedRow.row];
    //加载数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(categoryItem.ID);
    //页数加1 新的数据会出现
    parameters[@"page"] = @(++categoryItem.currentPage);
    self.parameters = parameters;
    [_manager GET:SWUrl_ parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * users = [SWUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryItem.users addObjectsFromArray:users];
        
        //判断是否最后一次请求
        if (self.parameters != parameters) return ;
        //刷新表
        [self.rightTable reloadData];
        
        //加载状态更新
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (self.parameters != parameters) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self.rightTable.mj_footer endRefreshing];
    }];

}
#pragma mark － 加载控制
-(void)checkFooterState{
    //找到所选中的Cell
    SWCategoryItem * categoryItem = self.caregroyItems[self.leftTable.indexPathForSelectedRow.row];
    
    //每次刷新右边的数据,(有数据不隐藏，没数据就隐藏，通过模型数据控制)
    self.rightTable.mj_footer.hidden = (categoryItem.users.count == 0);
    if (categoryItem.users.count == categoryItem.total) {
        //加载完毕
        [self.rightTable.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTable.mj_footer endRefreshing];
    }

}
#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
