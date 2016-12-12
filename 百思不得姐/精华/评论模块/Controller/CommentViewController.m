//
//  CommentViewController.m
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "CommentViewController.h"
#import "TopicCell.h"
#import "ToPicModel.h"
#import <MJRefresh.h>
#import "AFNetworking.h"
#import "CommentModel.h"
#import "MJExtension.h"
#import "CommentHeaderTitle.h"
#import "CommentCell.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**底部工具条间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;

/** 最热评论*/
@property(nonatomic,strong)NSArray *hotComments;
/** 最新评论*/
@property(nonatomic,strong)NSMutableArray *latestComments;
/**保存帖子的top_cmt */
@property(nonatomic,strong)NSArray *saveTop_cmt;
/** 保存当前页码*/
@property(nonatomic,assign)NSInteger page;
/** 网络请求对象*/
@property(nonatomic,strong)AFHTTPSessionManager *manager;
/** */
@property(nonatomic,strong)NSURLSessionDataTask *req;
@end
static NSString *const CellId=@"comment";
@implementation CommentViewController


-(AFHTTPSessionManager *)manager
{
    if (_manager==nil) {
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self AFNetworkStatus];
    [self setUpbase];
    [self setTableViewHeader];
    
    [self setRefresh];
}
-(void)setRefresh
{
    self.tableView.mj_header=[MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewDataComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    
}
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}
-(void)loadMoreData
{
    //启动系统风火轮
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    //取消所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.req cancel];
//   [self.manager.tasks
    NSInteger page=self.page+1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"]=@(page);
    CommentModel *com=[self.latestComments lastObject];
    params[@"lastcid"]=com.ID;
    // 超时时间
    self.manager.requestSerializer.timeoutInterval=5.0;
   self.req= [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        if(responseObject==nil)
            return ;
        NSLog(@"%@",responseObject);
        self.page=page;
        NSArray *arr = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:arr];
  
        [self.tableView reloadData];
        NSInteger total=[responseObject[@"total"] integerValue];
        if (self.latestComments.count>=total) {
            self.tableView.mj_footer.hidden=YES;
        }else
        {
            [self.tableView.mj_footer endRefreshing];

        }
        
        //        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.tableView.mj_footer endRefreshing];
    }];
  
}
-(void)LoadNewDataComment
{
    //取消所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.page=1;
        [self.tableView.mj_header endRefreshing];
        
    self.hotComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        NSLog(@"%ld",self.hotComments.count);
        
        // 最新评论
        self.latestComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.latestComments addObject:arr];
        NSLog(@"%ld",self.latestComments.count);
        
        [self.tableView reloadData];
        NSInteger total=[responseObject[@"total"] integerValue];
        if (self.latestComments.count>=total) {
            self.tableView.mj_footer.hidden=YES;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];

}
-(void)setTableViewHeader
{
    UIView *header=[[UIView alloc]init];
    
    if (self.topic.top_cmt!=nil) {
        self.saveTop_cmt=self.topic.top_cmt;
        self.topic.top_cmt=nil;
        [self.topic setValue:@0 forKey:@"cellheight"];
        
    }
    TopicCell *cell=[TopicCell GetCell];
    
   
    cell.topic=self.topic;
    cell.size=CGSizeMake(UIWidth, self.topic.cellheight);
    [header addSubview:cell];
   
//    设置header高度
    header.height=self.topic.cellheight+TopicCellMargin;
    
    self.tableView.tableHeaderView=header;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TopicCellMargin, 0);
    
}


-(void)setUpbase
{
    self.title=@"评论";
    self.edgesForExtendedLayout=UIRectEdgeLeft;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" WithHeight:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor=RGBColor(223, 223, 223);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:CellId];
    
    // cell的高度设置
    self.tableView.estimatedRowHeight=44;
    self.tableView.rowHeight=UITableViewAutomaticDimension; 
}
-(void)keyboardWillChangeFrame:(NSNotification*)note
{
// 、显示或隐藏键盘时的高度
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSapce.constant=UIHight-frame.origin.y;
    //动画时间
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)dealloc
{
    //取消通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.topic.top_cmt.count) {
       self.topic.top_cmt= self.saveTop_cmt;
  
        [self.topic setValue:@0 forKey:@"cellheight"];
        
    }
    //取消所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    tableView.mj_footer.hidden=(latestCount==0);
    if (section==0) {
        if (hotCount)
            return hotCount;
        return latestCount;
        
    }
    return latestCount;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section==0) {
//        if (hotCount)
//            return @"最热评论";
//        return @"最新评论";
//       
//    }
//    return @"最新评论";
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    static NSString *ID=@"header";
//    UITableViewHeaderFooterView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    UILabel *label=nil;
//    if (header==nil) {
//        header=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor=RGBColor(223, 223, 223);
//        //创建label
//        label=[[UILabel alloc]init];
//        label.textColor=RGBColor(67,67,67);
//        label.width=200;
//        label.x=TopicCellMargin;
//        label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
//        label.tag=223;
//        [header.contentView addSubview:label];
//    }else
//    {
//        label=(UILabel *)[header viewWithTag:223];
//    }
    CommentHeaderTitle *header=[CommentHeaderTitle GetHeaderViewWithTableView:tableView];
  
        NSInteger hotCount = self.hotComments.count;
    if (section==0) {
                if (hotCount)
                {
                    header.title= @"最热评论";
                }else
                {
                 header.title= @"最新评论";
                }
        
            }else
            {
         header.title= @"最新评论";
            }

    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
//    }
//    
    CommentModel *comment = [self commentInIndexPath:indexPath];
    cell.comment=comment;
    
    return cell;
}
-(NSArray *)commentsInSection:(NSInteger)section
{
    if (section==0) {
        if (self.hotComments.count)
        {
            return self.hotComments;
        }else
        {
        return self.latestComments;
        }
        
    }
    return self.latestComments;
}
-(CommentModel*)commentInIndexPath:(NSIndexPath*)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
#pragma mark--TableView代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu=[UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else
    {
        CommentCell *cell=(CommentCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        
        // 显示MenuController
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}
#pragma mark - MenuItem处理
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}
@end
