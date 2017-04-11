//
//  SWSubscribeViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWSubscribeViewController.h"
#import "SWRecommendItem.h"
#import "SWRecommendCell.h"
#define SWRecommad_URl @"http://d.api.budejie.com/tag/subscribe/bs0315-iphone-4.2.json?appname=bs0315&asid=4D9488FE-E59B-41A2-9323-AC3934759456&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=e3ddce7325bff40f8bb8b2851653e15c03c366c2&udid=&ver=4.2"
//定义标识
static NSString *const ID = @"cell";
@interface SWSubscribeViewController ()
//模型数组
@property (nonatomic,strong) NSArray *recommendItem;
//定义属性
@property (nonatomic,weak) SWHTTPSessionManager * manager;
@end

@implementation SWSubscribeViewController
//懒加载
- (NSArray *)recommendItem
{
    if (_recommendItem == nil) {
        _recommendItem = [NSArray array];
    }
    return _recommendItem;
}
-(SWHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [SWHTTPSessionManager manager];
        
    }return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //取消TableView侧滑栏
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置蒙版 防止加载时其他控件可点击
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载数据。。。"];
    //取消TableView分隔栏样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //在TableView的头部添加一个搜索框
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SWScreenWidth, 44)];
    search.placeholder = @"搜索标签";
    self.tableView.tableHeaderView = search;    //加载数据
    [self loadWeb];
}
//加载数据
- (void)loadWeb
{
    
    //自定义SVProgressHUD显示时背景颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_manager GET:SWRecommad_URl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //当请求完成后，隐藏指示器
        [SVProgressHUD dismiss];
        //将模型保存到数组中
        _recommendItem = [SWRecommendItem mj_objectArrayWithKeyValuesArray:responseObject[@"rec_tags"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
  
}

//设置控制器样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _recommendItem.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [SWRecommendCell SetupRecommendView];
    }
    cell.recommendItem = _recommendItem[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

//当推荐关注页面即将消失是调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //隐藏指示器
    [SVProgressHUD dismiss];
}

//点击tableView的时候会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//开始拖动的时候调用这个方法 取消键盘弹出
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
//设置每个组的头部标题的颜色和样式，但是设置完之后必须设置头部View的高度，否则显示不出来，但是这样设置之后滚动TableView的时候Section会停留，若想静止必须设置TableView的样式为Group
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SWScreenWidth, 30)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    //    titleLabel.textColor= SYCommonBgColor;
    titleLabel.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    
    titleLabel.text= @"推荐标签";
    [myView addSubview:titleLabel];
    return myView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}



@end
