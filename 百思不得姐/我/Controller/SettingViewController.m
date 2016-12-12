//
//  SettingViewController.m
//  百思不得姐
//
//  Created by user on 16/9/19.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "SettingViewController.h"
#import "FileUtil.h"
@interface SettingViewController ()

@end

@implementation SettingViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"清除缓存";

    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(200, 300, 100, 30);
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    float size=[FileUtil getSize:@"/Users/user/Desktop/图片/Image"];
    NSLog(@"%.2f",size);
}
-(void)BtnClick
{
//
    [FileUtil deleteSize:@"/Users/user/Desktop/图片/Image" complete:^{
        NSLog(@"已删除");
    }];
    float size=[FileUtil getSize:@"/Users/user/Desktop/图片/Image"];
    NSLog(@"%.2f",size);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
