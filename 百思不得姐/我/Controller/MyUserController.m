 //
//  MyUserController.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "MyUserController.h"
#import "MeViewCell.h"
#import "MefooterView.h"
#import "SettingViewController.h"
@interface MyUserController ()<UITableViewDelegate,UITableViewDataSource>

@end
static NSString *const CellID=@"meCell";
@implementation MyUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"我的";
     self.view.backgroundColor=RGBColor(233, 233, 233);
    UIBarButtonItem *moonBar=[UIBarButtonItem itemWithImageName:@"mine-sun-icon" WithHeight:@"mine-sun-icon-click" target:self action:@selector(moonClick)];
       UIBarButtonItem *setBar=[UIBarButtonItem itemWithImageName:@"mine-setting-icon" WithHeight:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems=@[setBar,moonBar];
    
    [self setuptableview];
  

}
-(void)setuptableview
{
    self.tableView.separatorStyle=UITableViewCellAccessoryNone;
    [self.tableView registerClass:[MeViewCell class] forCellReuseIdentifier:CellID];
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = TopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(TopicCellMargin - 35, 0, 0, 0);
    self.tableView.tableFooterView=[[MefooterView alloc]init];
    
}
-(void)moonClick
{
    NSLog(@"月亮点击");
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
}
-(void)settingClick
{
    SettingViewController *vc=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"defaultUserIcon"];
        cell.textLabel.text=@"登录/注册";
    }else if(indexPath.section==1)
    {
        cell.textLabel.text=@"离线下载";
    }
    
    return cell;
    
}

@end
