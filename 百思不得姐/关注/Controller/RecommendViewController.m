//
//  RecommendViewController.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "RecommendCategoryCell.h"
#import "RecommendCategory.h"
#import "MJExtension.h"
#import "RecommendUserTableViewCell.h"
#import "CategoryUserModel.h"
#import <MJRefresh.h>
#define SelectedCategory self.CategoryArr[self.CategoryTableView.indexPathForSelectedRow.row]
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边类别tableView*/
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;
/** 左边类别数据*/
@property(nonatomic,strong)NSArray *CategoryArr;
/** 右边用户数据*/
@property(nonatomic,strong)NSArray *UsersArr;
/** 右边用户tableView*/
@property (weak, nonatomic) IBOutlet UITableView *UserTabelView;
/** 请求参数字典*/
@property(nonatomic,strong)NSMutableDictionary *params;
/** */
@property(nonatomic,strong)NSProgress *progress;
/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation RecommendViewController
static NSString * const CategoryCellId=@"Categorycell";
static NSString * const UserCellId=@"UsreCell";


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetuptableView];
    
    //添加刷新空间
    [self setupRefresh];
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
   
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gkfjdkghfkjgjg");
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //
        self.CategoryArr=[RecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.CategoryTableView reloadData];
        
        [self.CategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.UserTabelView.mj_header beginRefreshing];
        [self.UserTabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
 
//
   
    
}
-(void)SetuptableView
{
    self.view.backgroundColor=RGBColor(233, 233, 233);
    
    //注册tableView
    [self.CategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellId];
    [self.UserTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:UserCellId];
      self.UserTabelView.pagingEnabled = false;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.CategoryTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.UserTabelView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.UserTabelView.rowHeight=60;
    self.title=@"推荐关注";
}
-(void)setupRefresh
{
//   __weak  weakself=self;
    self.UserTabelView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewUsers];
    }];
    self.UserTabelView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.UserTabelView.mj_footer.hidden=YES;

    
}
-(void)loadNewUsers
{
    
  
    RecommendCategory *rc=SelectedCategory;
    // 设置当前页码为1
    rc.currentPage = 1;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
     self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        // 字典数组 -> 模型数组
        NSArray *users = [CategoryUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
     
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];

        // 不是最后一次请求
        if (self.params != params) return;
        
      
        // 刷新右边的表格
        [self.UserTabelView reloadData];
        
        // 结束刷新
        [self.UserTabelView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.UserTabelView.mj_header endRefreshing];
    }];
}
//上拉刷新
-(void)loadMoreUsers
{
    
    
    RecommendCategory *category = SelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    
  
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"  parameters:params  progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [CategoryUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.UserTabelView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.UserTabelView.mj_footer endRefreshing];
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.CategoryTableView) {
         return self.CategoryArr.count;
    }else
    {
        // 右边的用户表格
        // 左边被选中的类别模型
        [self checkFooterState];
        //每次刷新数据时，控制footer显示或隐藏
    return [SelectedCategory users].count;
    }
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    RecommendCategory *rc = SelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.UserTabelView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.UserTabelView.mj_footer resetNoMoreData];
    } else { // 还没有加载完毕
        [self.UserTabelView.mj_footer endRefreshing];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.CategoryTableView) {
        RecommendCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:CategoryCellId];
        cell.categoty=self.CategoryArr[indexPath.row];
     return  cell;
    }else
    {
        RecommendUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:UserCellId];
      
       
        cell.UserModel=[SelectedCategory users][indexPath.row];
        
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCategory *c = self.CategoryArr[indexPath.row];
    // 结束刷新
    [self.UserTabelView.mj_header endRefreshing];
    [self.UserTabelView.mj_footer endRefreshing];
    
    if (c.users.count) {
         // 显示曾经的数据
        [self.UserTabelView reloadData];
    }else
    {
        [self.UserTabelView reloadData];
        [self.UserTabelView.mj_header beginRefreshing];
      }
    
}
-(void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
