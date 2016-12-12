//
//  AddTagViewController.m
//  百思不得姐
//
//  Created by user on 16/9/18.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "AddTagViewController.h"
#import "TagButton.h"
#import "TagTextField.h"
#import "SVProgressHUD.h"
@interface AddTagViewController ()<UITextFieldDelegate>


/** 中间内容容器View*/
@property(nonatomic,strong)UIView *winView;
/** 添加按钮*/
@property(nonatomic,strong)UIButton *addButton;
/** 文本框*/
@property(nonatomic,strong)TagTextField *textField;
/** 标签按钮数组*/
@property(nonatomic,strong)NSMutableArray *tagButtons;
@end

@implementation AddTagViewController


-(NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons=[NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.winView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, TextMargin, 0, TextMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = RGBColor(74, 139, 209);
        [self.winView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setwinView];
//    [self setTextView];
    [self setTags];
}
-(void)setwinView
{
    UIView *winView=[[UIView alloc]init];
    winView.x=TextMargin;
    winView.y=TextMargin+64;
    winView.width=UIWidth-2*TextMargin;
    winView.height=UIHight;
    [self.view addSubview:winView];
    self.winView=winView;
    [self setTextView];
}

-(void)setTextView
{
    __weak typeof (self)weakSelf=self;
    TagTextField *textField=[[TagTextField alloc]init];
    textField.cleanblock=^{
        if ([weakSelf.textField hasText]) return ;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.winView addSubview:textField];
    self.textField=textField;
    self.textField.delegate=self;
    
}
/**
 *  页面跳转时设置标签button
 *
 */
-(void)setTags
{
    for (NSString *tags in self.tagsArr) {
        self.textField.text=tags;
        [self addButtonClick];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.textField becomeFirstResponder];
}

-(void)setupNav
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"添加标签";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick)];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}
-(void)barButtonClick
{
    //kvc拿出对应的属性的值
    NSArray *tagsArr=[self.tagButtons valueForKeyPath:@"currentTitle"];
    if (self.tagsBlock) {
        self.tagsBlock(tagsArr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.textField hasText]) {
        [self addButtonClick];
    }
    return YES;
}
/**
 *  输入文字发生改变
 */
-(void)textChange
{
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + TextMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","]
            || [lastLetter isEqualToString:@"，"]) {
            // 去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            
            [self addButtonClick];
        }
    } else { // 没有文字
        // 隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    [self updateTagButtonFrame];
}
/**
 *  添加标签按钮的点击
 */
-(void)addButtonClick
{
    
    if (self.tagButtons.count ==5) {
        [SVProgressHUD showErrorWithStatus:@"最多五个标签"];
        return;
    }
    TagButton *tagButton=[TagButton buttonWithType:UIButtonTypeCustom];
  
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchDown];
  
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
 
      tagButton.height=self.textField.height;
    [self.winView addSubview:tagButton];
    
    [self.tagButtons addObject:tagButton];
    
    [self updateTagButtonFrame];
    
    self.textField.text=nil;
    self.addButton.hidden=YES;
    
    
}
/**
 *  更新frame
 */
-(void)updateTagButtonFrame
{
    for (int i=0; i<self.tagButtons.count; i++) {
        UIButton *tagButtom=self.tagButtons[i];
        if (i==0) {
            tagButtom.x=0;
            tagButtom.y=0;
        }else
        {
            TagButton *lastTagButton=self.tagButtons[i-1];
            CGFloat leftwidth=CGRectGetMaxX(lastTagButton.frame)+TextMargin;
            CGFloat rightwidth=self.winView.width-leftwidth;
            if (rightwidth>=tagButtom.width) {
                tagButtom.y=lastTagButton.y;
                tagButtom.x=leftwidth;
            }else
            {
                tagButtom.x=0;
                tagButtom.y=CGRectGetMaxY(lastTagButton.frame)+TextMargin;
            }
        }
    }
    TagButton *lastButton=[self.tagButtons lastObject];
    CGFloat leftwidth=CGRectGetMaxX(lastButton.frame)+TextMargin;
    
    if (self.winView.width-leftwidth>=[self textFieldtextWidth]) {
        self.textField.x=leftwidth;
        self.textField.y=lastButton.y;
    }else
    {
    //更新textfiled的frame
    self.textField.x=0;
    self.textField.y=CGRectGetMaxY([[self.tagButtons lastObject]frame])+TextMargin;
    }
}

-(CGFloat)textFieldtextWidth
{
    CGFloat textwidth=[self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(50, textwidth);
}
-(void)tagButtonClick:(TagButton*)button
{
    [button removeFromSuperview];
    [self.tagButtons removeObject:button];
    
    [UIView animateWithDuration:0.25 animations:^{
         [self updateTagButtonFrame];
    }];
   
}
@end
