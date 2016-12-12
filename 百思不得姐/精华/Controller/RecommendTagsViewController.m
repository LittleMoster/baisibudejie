//
//  RecommendTagsViewController.m
//  百思不得姐
//
//  Created by user on 16/8/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "RecommendTagsCell.h"
#import "RecommendTagsModel.h"
#import "MJExtension.h"
@interface RecommendTagsViewController ()
{
    
}
/** 标签模型数组*/
@property(nonatomic,strong)NSArray *TagsArr;
@end
static NSString *const TagCellID=@"TagCell";
@implementation RecommendTagsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setloadData];
} 
-(void)setloadData
{
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //数组转模型
        self.TagsArr=[RecommendTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
  
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];


}
-(void)setupTableView
{
      self.view.backgroundColor=RGBColor(233, 233, 233);
     self.title=@"推荐标签";
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:TagCellID];
    self.tableView.rowHeight=70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(233, 233, 233);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.TagsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:TagCellID];
    
 
    cell.tagsModel=self.TagsArr[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
