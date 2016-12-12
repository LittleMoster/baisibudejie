//
//  JHbaseTableViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "JHbaseTableViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "ToPicModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "TopicCell.h"
#import "CommentViewController.h"
#import "TieNewViewController.h"
@interface JHbaseTableViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 页码*/
@property(nonatomic,assign)int page;
/** 加载更多时要传的参数*/
@property(nonatomic,strong)NSString *maxtime;
/** 请求参数数组*/
@property(nonatomic,strong)NSDictionary *params;
/** 最后一次的index*/
@property(nonatomic,assign)NSInteger index;
@end
static NSString *const topiccellID=@"topic";
@implementation JHbaseTableViewController

-(NSMutableArray *)topics
{
    if (_topics==nil) {
        _topics=[[NSMutableArray alloc]init];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    
    
}
-(NSString *)a
{
    if ([self.parentViewController isKindOfClass:[TieNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}
-(void)setupTableView
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top =TitilesViewY+TitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //取消分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:topiccellID];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableBarClick) name:TabBarDidSelectNotification object:nil];
    
}
-(void)tableBarClick
{
//    BOOL onwindow=self.view.isShowingOnKeyWindow;
//    BOOL wind=[self.view isShowingOnKeyWindow];
//    NSLog(@"gjhdgshj");
    if (/*self.tabBarController.selectedViewController !=self.navigationController &&*/ self.index==self.tabBarController.selectedIndex &&[self.view isShowingOnKeyWindow]) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.index=self.tabBarController.selectedIndex;
}
-(void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewtpic)];
    self.tableView.mj_header.automaticallyChangeAlpha=YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoretopic)];
}
#pragma mark-加载更多数据
-(void)loadMoretopic
{
    [self.tableView.mj_header endRefreshing];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"]=@(self.page);
    params[@"maxtime"]=self.maxtime;
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString*path=@"/Users/user/Desktop/html.plist";
//        [responseObject writeToFile:path atomically:YES];
        self.maxtime=responseObject[@"info"][@"maxtime"];
        NSArray *topArr=[ToPicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
  
        //添加到数组
        [self.topics addObjectsFromArray:topArr];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        if (self.params!=params) return ;
        self.page--;
    }];
    
}
#pragma mark-加载新的数据
-(void)loadNewtpic
{
    
    [self.tableView.mj_footer endRefreshing];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"]=@(self.page);
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params!=params) return ;
        self.maxtime=responseObject[@"info"][@"maxtime"];
        
        self.topics = [ToPicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        NSLog(@"%@",responseObject[@"list"]);
        self.page=0;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topiccellID];
    
    cell.topic = self.topics[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出模型
    ToPicModel *topic=self.topics[indexPath.row];
//    计算文字高度

//    返回Cell高度
    return topic.cellheight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewController *comm=[[CommentViewController alloc]init];
    comm.topic=self.topics[indexPath.row];
    [self.navigationController pushViewController:comm animated:YES];
}

@end
