//
//  MainViewController.m

//
//  Created by user on 16/7/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavViewController.h"
#import "MyUserController.h"

#import "JHMainViewController.h"
#import "TieNewViewController.h"
#import "CartLoveViewController.h"
#import "baseTabel.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=[UIColor colorWithRed:37.0/255.0 green:99.0/255.0 blue:243.0/255.0 alpha:1];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initViewWitnNav];
    self.delegate=self;

}
+(void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    UITabBarItem *item=[UITabBarItem appearance];
    //设置tabaritem的正常情况下的属性
    NSMutableDictionary *textArr=[NSMutableDictionary dictionary];
    textArr[NSForegroundColorAttributeName]=[UIColor lightGrayColor];//文字颜色
    
    [item setTitleTextAttributes:textArr forState:UIControlStateNormal];
    
    //设置tabaritem的选中情况下的属性
    NSMutableDictionary *selecttextArr=[NSMutableDictionary dictionary];
    selecttextArr[NSFontAttributeName] = textArr[NSFontAttributeName];
    selecttextArr[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    [item setTitleTextAttributes:selecttextArr forState:UIControlStateSelected];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initViewWitnNav
{
    JHMainViewController *fristView=[[JHMainViewController alloc]init];
    [self addChildVc:fristView title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    TieNewViewController *secondView=[[TieNewViewController alloc]init];
    [self addChildVc:secondView title:@"发帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    CartLoveViewController *threeView=[[CartLoveViewController alloc]init];
    [self addChildVc:threeView title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    MyUserController *fourView=[[MyUserController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:fourView title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置子控制器的文字
//    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.title=title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // //使用指定渲染模式---总是绘制原始图像，而不将它视为模板(搞掉系统默认)
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    //    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:37.0/255.0 green:99.0/255.0 blue:243.0/255.0 alpha:1];
    //    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    

    [self setValue:[[baseTabel alloc]init] forKey:@"tabBar"];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:childVc];
    
    // 添加为子控制器
    [self addChildViewController:nav];
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
