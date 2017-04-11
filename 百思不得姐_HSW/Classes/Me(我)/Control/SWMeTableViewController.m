//
//  SWMeTableViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/4.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWMeTableViewController.h"
#import "SWSquareItem.h"
#import "SWMeCollectionCell.h"
#import "SWSettingViewController.h"
#import "SWMeSendVc.h"

static NSString *const ID = @"ID";
static NSInteger const cols = 4;
static CGFloat  const margin = 1;
#define itemHW  (SWScreenWidth - (cols - 1) * margin ) / cols
@interface SWMeTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/*数据*/
@property (strong , nonatomic)NSMutableArray *squareItems;

/**
 collectionView
 */
@property (weak ,nonatomic) UICollectionView *collectionView;

@end

@implementation SWMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNavBar];
    //设置tableview底部视图
    [self setUpFooterView];
     //请求数据
    [self loadData];
    
    [self uptable];
    
}

-(void)uptable{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - 请求数据
-(void)loadData
{
    
    [SVProgressHUD show];
    //1.创建请求对话管理者
    SWHTTPSessionManager *manager = [SWHTTPSessionManager manager];
    
    //2.凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [manager GET:SWBSURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        
        NSArray *dictArray = responseObject[@"square_list"];
        //字典数组转成模型数组
        _squareItems = [SWSquareItem mj_objectArrayWithKeyValuesArray:dictArray];
        
        //处理数据
        [self resoveData];
        
        //设置collectionview高度 = rows * itemWH
        //Rows = (count - 1) / cols + 1
        NSInteger rows = (_squareItems.count - 1) /  cols + 1;
        self.collectionView.gf_height = rows * itemHW + cols * margin ;
        
        //设置tableview滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
    
        //刷新表格
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD dismiss];
    }];
}
#pragma mark - 数据处理
-(void)resoveData
{
    NSInteger count = _squareItems.count;
    NSInteger exter = count % cols;
    
    if (exter) {
        exter = cols - exter;
        for (NSInteger i = 0; i<exter; i++) {
            SWSquareItem *item = [[SWSquareItem alloc]init];
            [self.squareItems addObject:item];
        }
    }
}

#pragma mark - 设置导航条
-(void)setUpNavBar
{
    //右边
    UIBarButtonItem *item1 = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] WithHighlighted:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(setting)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] WithSelected:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(moon:)];
    
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    
    //Titie
    self.navigationItem.title = @"NSLogHsw";
}
-(void)setting
{
    [self.navigationController pushViewController:[SWSettingViewController new] animated:YES];
}

-(void)moon:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

#pragma mark - 设置tableview底部视图
-(void)setUpFooterView
{
    
    //运用UICollectionView，因为UICollectionView默认具有循环引用的功能，在UItableView上添加UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
     //因为底部view可以穿透导航栏所以设置其尺寸跟屏幕一样大小
    //设置尺寸
    layout.itemSize = CGSizeMake(itemHW, itemHW);
    
    //设置UICollectionView每个Cell之间的间距
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    //设置UICollectionView在什么方向可以滚动
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.collectionView = collectionView;
    self.tableView.tableFooterView = collectionView;
    //关闭滚动
    collectionView.scrollEnabled = NO;
    
    //设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //取消滑动提示栏
    collectionView.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    collectionView.bounces = NO;
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SWMeCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _squareItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWMeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.squareItems[indexPath.item];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SWMeSendVc * send = [SWMeSendVc new];
    send.itemData = self.squareItems[indexPath.item];;
    [self.navigationController pushViewController:send animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  section = 0 ? 1 :1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"hsw"];
        cell.textLabel.text = @"HuangSW_菜鸟";
    }else{
        cell.textLabel.text = @"点击联系作者QQ392287145";
    }
    return cell;
}



@end
