//
//  TieNewViewController.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TieNewViewController.h"

@interface TieNewViewController ()

@end

@implementation TieNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=RGBColor(233, 233, 233);
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"MainTagSubIcon" WithHeight:@"MainTagSubIconClick" target:self action:@selector(leftClick)];
}
-(void)leftClick
{
    NSLog(@"左边按钮点击");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
