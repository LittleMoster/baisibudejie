//
//  PubilshWordViewController.m
//  百思不得姐
//
//  Created by user on 16/9/13.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "PubilshWordViewController.h"

#import "PlaceholderTextView.h"
#import "AddtagToolView.h"
@interface PubilshWordViewController ()<UITextViewDelegate>

/** textView*/
@property(nonatomic,strong)PlaceholderTextView *worldtextView;
/** 工具条View*/
@property(nonatomic,strong)AddtagToolView *tools;
@end

@implementation PubilshWordViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

     [self setupNav];
    [self setTextView];
    [self setupTool];
}
-(void)setupTool
{
    AddtagToolView *tool=[AddtagToolView GetView];
    tool.width=self.view.width;
    tool.y=self.view.height-tool.height;
    [self.view addSubview:tool];
    self.tools=tool;
//    通知监听键盘的显示和隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)keyboardWillChangeFrame:(NSNotification*)note
{
    // 、显示或隐藏键盘时的高度
    CGRect Keyframe = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.tools.transform=CGAffineTransformMakeTranslation(0, Keyframe.origin.y-UIHight);
    //动画时间
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)setTextView
{
    PlaceholderTextView *worldtextView=[[PlaceholderTextView alloc]init];
    worldtextView.frame=self.view.bounds;
    worldtextView.placeholder=@"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    worldtextView.placeholderColor=[UIColor grayColor];
    worldtextView.delegate=self;
    [self.view addSubview:worldtextView];
    
    self.worldtextView=worldtextView;
}
- (void)setupNav {
  self.title = @"发表文字";
//    设置左边按钮文字和点击事件
  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(cancel)];
//    设置右边按钮文字和点击事件
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(post)];
//    设置title字体大少
    NSMutableDictionary *items=[NSMutableDictionary dictionary];
//    items[NSForegroundColorAttributeName]=[UIColor whiteColor];//字体颜色
    items[NSFontAttributeName]=[UIFont systemFontOfSize:20];//字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:items];
    // 设置item
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];

    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
    [self.worldtextView becomeFirstResponder];
    
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    
}
#pragma mark--textView代理
-(void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled=textView.hasText;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES]; 
}

@end
