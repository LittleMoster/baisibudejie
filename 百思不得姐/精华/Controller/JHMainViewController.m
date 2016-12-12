//
//  JHMainViewController.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "JHMainViewController.h"
#import "RecommendTagsViewController.h"
#import "JHbaseTableViewController.h"
#import "ProgressView.h"
typedef NSString mustring;
@interface JHMainViewController ()<UIScrollViewDelegate>
{
    
}
/** 选择框*/
@property(nonatomic,strong)UIView *titlesView;
/** 底部滑块*/
@property(nonatomic,strong)UIView *indicatorView;
/** 选择框按钮*/
@property(nonatomic,strong)UIButton *selectedButton;
/** 底部scroreView*/
@property(nonatomic,strong)UIScrollView *downScroller;
@end

@implementation JHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //设置导航
    [self initNav];
    // 初始化子控制器
    [self setupChildVces];
    //设置选择条
    [self setupTitlesView];
    
    //设置ScrollerView
    [self setUpScrollerView];
    mustring *my=@"djhgsfjhdh";
    NSLog(@"%@",my);

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden=NO;
}


-(void)setUpScrollerView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *downScroller=[[UIScrollView alloc]init];
  
//    CGFloat top=CGRectGetMaxY(self.titlesView.frame);
//    NSLog(@"%f",top);
//    CGFloat buttom=self.tabBarController.tabBar.height;
    
//    downScroller.backgroundColor=[UIColor redColor];
//    downScroller.frame=CGRectMake(0, 64, self.view.width, self.view.height-buttom+64);
    downScroller.frame=self.view.bounds;
    downScroller.delegate=self;
    downScroller.pagingEnabled=YES;
    [self.view insertSubview:downScroller atIndex:0];
    downScroller.contentSize = CGSizeMake(downScroller.width * self.childViewControllers.count, 0);
   
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:downScroller];
    self.downScroller=downScroller;
}


/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    JHbaseTableViewController *all = [[JHbaseTableViewController alloc] init];
    all.type=TopicTypeAll;
    [self addChildViewController:all];
    
    JHbaseTableViewController *video = [[JHbaseTableViewController alloc] init];
     video.type=TopicTypeVideo;
    [self addChildViewController:video];
   
    
    JHbaseTableViewController *voice = [[JHbaseTableViewController alloc] init];
       voice.type=TopicTypeVoice;
    [self addChildViewController:voice];
 
    
    JHbaseTableViewController *picture = [[JHbaseTableViewController alloc] init];
    picture.type=TopicTypePicture;
    [self addChildViewController:picture];
    
    JHbaseTableViewController *word = [[JHbaseTableViewController alloc] init];
    word.type=TopicTypeWord;
    [self addChildViewController:word];
}
/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TitilesViewH;
    titlesView.y = TitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    //    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.backgroundColor=[UIColor redColor];
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag=i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            //            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }

}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    CGPoint offset=self.downScroller.contentOffset;
    offset.x=button.tag*self.downScroller.width;
    [self.downScroller setContentOffset:offset animated:YES];
    
}


-(void)initNav
{
    self.view.backgroundColor=RGBColor(233, 233, 233);
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"MainTagSubIcon" WithHeight:@"MainTagSubIconClick" target:self action:@selector(leftClick)];
}

-(void)leftClick
{
    NSLog(@"左边按钮点击");
    RecommendTagsViewController *vc=[[RecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--downScrollerDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
        [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"%ld",index);
    [self titleClick:self.titlesView.subviews[index+1]];
}
@end
