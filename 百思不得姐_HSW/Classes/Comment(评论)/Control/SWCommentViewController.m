//
//  SWCommentViewController.m
//  百思不得姐_HSW
//
//  Created by  677676  on 17/1/5.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWCommentViewController.h"
#import "SWTopicCell.h"
#import "SWCommentHeaderFooterView.h"


@interface SWCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMagin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieed;
@property(nonatomic,weak)SWHTTPSessionManager * manager;
/** 最热评论数据 */
@property (nonatomic, strong) NSArray<SWComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<SWComment *> *latestComments;
/** 最热评论 */
@property (nonatomic, strong) SWComment *savedTopCmt;

@end
static NSString *const commentID = @"commnet";
static NSString *const headID = @"head";
@implementation SWCommentViewController
#pragma mark  － 请求管理者
-(SWHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [SWHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTableView];
    [self setUpRefresh];
    [self setUpHeadView];
}
//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//}

-(void)setUpNav{
    
     self.title  = @"SW评论BS";
    
    /**
     监听键盘弹出
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

#pragma mark - 监听
-(void)KeyboardWillChangeFrame:(NSNotification *)not
{
    //修改约束
    CGFloat kbY = [not.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;

    self.bottomMagin.constant = SWScreenHeight - kbY;
    
    //做动画
    CGFloat duration = [not.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view  layoutIfNeeded];
    }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
/**
 当用户开始拖拽就会调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //最热评论  这样返回到之前界面会出现最热评论
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

-(void)setUpTableView{
    
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SWCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 64, SWScreenWidth, SWScreenHeight - 64);
    self.tableView.backgroundColor = SWBgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate=self;
    self.tableView.dataSource= self;
//    self.tableView.rowHeight = 80;
    
    
    self.textFieed.delegate=self;
    

}


-(void)setUpRefresh
{
    self.tableView.mj_header = [SWRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    
}

-(void)setUpHeadView{
    // 模型数据处理：把最热评论影藏
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    //注册
    [self.tableView registerClass:[SWCommentHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headID];
    //嵌套一个View
    UIView *head = [[UIView alloc] init];
    SWTopicCell *topicCell = [SWTopicCell gf_viewFromXib];
    topicCell.backgroundColor = [UIColor whiteColor];
    topicCell.topic = self.topic;
    topicCell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    // 设置header的高度
    head.gf_height = topicCell.gf_height + SWMargin * 2;
    
    self.tableView.tableHeaderView = head;
    [head addSubview:topicCell];
    
    //头部View高度
    self.tableView.sectionHeaderHeight = [UIFont systemFontOfSize:13].lineHeight + SWMargin;
    
}
#pragma mark - 加载网络数据
-(void)loadNewComment
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @1;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:SWBSURL parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组转模型数组
        weakSelf.latestComments = [SWComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [SWComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) { // 全部加载完毕
            // 隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}
-(void)loadMoreComment
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:SWBSURL parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        // 字典数组转模型数组
        NSArray *moreComment = [SWComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComment];
        
        [weakSelf.tableView reloadData];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if (weakSelf.latestComments.count ==  total) {
            
            //结束刷新
            weakSelf.tableView.mj_footer.hidden = YES;
            
        }else
        {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark － delegate  tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //最热和最新评论数据判断
    if (self.hotestComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //第0组 并且 有最热评论数
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    return self.latestComments.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = AR4Clor;
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = _hotestComments[indexPath.row];
    }else{
        cell.comment = _latestComments[indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SWCommentHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
    //第0组 并且 有最热评论数
    if (section == 0 && self.hotestComments.count) {
        headView.textLabel.text = @"最热评论";
    }else{
        headView.textLabel.text = @"最新评论";
    }
    return headView;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section && indexPath.section == 0 && self.hotestComments) {
            SWComment * conment = self.hotestComments[indexPath.row];
            return conment.cellHeight;
    }else{
        if (self.latestComments.count != 0) {
            SWComment * conment = self.latestComments[indexPath.row];
            return conment.cellHeight;
        }
        else return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && self.hotestComments.count) {
        SWComment * model = _hotestComments[indexPath.row];
        self.textFieed.placeholder = [NSString stringWithFormat:@"回复%@:",model.user.username];
        [self.textFieed becomeFirstResponder];
    }else{
         SWComment * model = _latestComments[indexPath.row];
        self.textFieed.placeholder = [NSString stringWithFormat:@"回复%@:",model.user.username];
        [self.textFieed becomeFirstResponder];
    }
}

#pragma mark  - textFiledDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
