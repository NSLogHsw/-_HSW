//
//  SWRedStartViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/9.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWRedStartViewController.h"
#import "SWRedStartItems.h"
#import "SWRedStatrTableViewCell.h"


static NSString *const ID = @"redStars";
@interface SWRedStartViewController ()
@property(nonatomic,retain)SWHTTPSessionManager * manager;

@property (nonatomic,strong) NSArray *redStarts;
@end

@implementation SWRedStartViewController


-(SWHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [SWHTTPSessionManager manager];
    }
    return _manager;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SWRedStatrTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = 80;
    //取消tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置偏移(滚动＋导航高度)
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, self.tabBarController.tabBar.gf_height, 0);
    [self reloadRefreshing];
}
-(void)reloadRefreshing{
    self.tableView.mj_header = [SWRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark －数据请求
-(void)reloadData{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_manager GET:SWRedStartURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.redStarts = [SWRedStartItems mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.redStarts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRedStatrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    id model = self.redStarts[indexPath.row];
    cell.items = model;
    return cell;
}



@end
