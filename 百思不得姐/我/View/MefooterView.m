//
//  MefooterView.m
//  百思不得姐
//
//  Created by user on 16/9/13.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "MefooterView.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "SquareModel.h"
#import "squareButton.h"
#import "WebViewController.h"
@implementation MefooterView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
       
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [SquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            NSLog(@"%ld",sqaures.count);
            [self setsqures:sqaures];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
    return  self;
}
//设置背景图片
-(void)drawRect:(CGRect)rect
{
//    [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
}
-(void)setsqures:(NSArray*)arr
{
    int maxCol=4;
    
    CGFloat buttonW=UIWidth/4;
    CGFloat buttonH=buttonW;
    for (int i=0; i<arr.count; i++) {
        SquareModel *model=arr[i];
        squareButton *btn=[squareButton buttonWithType:UIButtonTypeCustom];
        btn.square=model;
        
        // 监听点击
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        //行数
        int row=i%maxCol;
//        列数
        int col=i/maxCol;
        
        btn.x=col*buttonW;
        btn.y=row*buttonH;
        btn.height=buttonH;
        btn.width=buttonW;
        
    }
    
     NSUInteger rows = (arr.count + maxCol - 1) / maxCol;
    self.height=buttonH*rows;
    NSLog(@"%f",self.height);
    
    // 重绘
    [self setNeedsDisplay];
}
-(void)buttonClick:(squareButton*)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    WebViewController *web=[[WebViewController alloc]init];
    
    web.title=button.square.name;
    web.url=button.square.url;
    
    UITabBarController *bat=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav=(UINavigationController*)bat.selectedViewController;
    [nav pushViewController:web animated:YES];
    
    
    
    
    
    
}
@end
