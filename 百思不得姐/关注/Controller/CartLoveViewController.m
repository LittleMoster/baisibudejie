//
//  CartLoveViewController.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "CartLoveViewController.h"
#import "RecommendViewController.h"
#import "loginRegisterViewController.h"
@interface CartLoveViewController ()

@end

@implementation CartLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=RGBColor(233, 233, 233);
    self.navigationItem.title=@"我的关注";
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" WithHeight:@"friendsRecommentIcon-click" target:self action:@selector(leftCart)];

}
-(void)leftCart
{
    NSLog(@"关注");
    RecommendViewController *vc=[[RecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginAction:(id)sender {
    
    loginRegisterViewController *vc=[[loginRegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
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
