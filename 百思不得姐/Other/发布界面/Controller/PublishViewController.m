//
//  PublishViewController.m
//  百思不得姐
//
//  Created by user on 16/8/31.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "PublishViewController.h"
#import "ImageAndLabelButton.h"
#import "POP.h"
#import "PubilshWordViewController.h"
#import "BaseNavViewController.h"
@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.userInteractionEnabled=NO;
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    //中间的六个按钮
    int maxCols=3;
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+30;
    CGFloat buttonStartX=20;
    CGFloat buttonStartY=([UIScreen mainScreen].bounds.size.height-2*buttonH)/2;
    CGFloat XMargin=([UIScreen mainScreen].bounds.size.width-maxCols*buttonW-2*buttonStartX)/(maxCols-1);
    for (int i=0; i<images.count; i++) {
        ImageAndLabelButton *button=[[ImageAndLabelButton alloc]init];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        button.tag=i;
//        button.width=buttonW;
//        button.height=buttonH;
        int row=i/maxCols;
        int col=i%maxCols;
         float buttonx=buttonStartX+col*(XMargin+buttonW);
          float buttony=buttonStartY+row*buttonH;
        float buttonYStart=buttony-[UIScreen mainScreen].bounds.size.height;
        [self.view addSubview:button];
        
        //添加按钮动画
        POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue=[NSValue valueWithCGRect:CGRectMake(buttonx, buttonYStart, buttonW, buttonH)];
        anim.toValue=[NSValue valueWithCGRect:CGRectMake(buttonx, buttony, buttonW, buttonH)];
        anim.springSpeed=10;
        anim.springBounciness=10;
        anim.beginTime=CACurrentMediaTime() +0.1*i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
       //添加文字View动画
    UIImageView *textImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
   float centerY=UIHight*0.2;
   float centerX=UIWidth*0.5;
    float StartY=centerY-UIHight;
    textImageView.centerY=StartY;
    POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(centerX, StartY)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springSpeed=10;
    anim.springBounciness=10;
    anim.beginTime=CACurrentMediaTime() +images.count*0.1;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [textImageView pop_addAnimation:anim forKey:nil];
    [self.view addSubview:textImageView];
    
}
-(void)buttonClick:(UIButton*)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag==0) {
            NSLog(@"0");
            
        }
        if (button.tag==1) {
            
            NSLog(@"1");
        }
        if (button.tag==2) {
            
            UIViewController *tab=[UIApplication sharedApplication].keyWindow.rootViewController;
            PubilshWordViewController *vc=[[PubilshWordViewController alloc]init];
            BaseNavViewController *nav=[[BaseNavViewController alloc]initWithRootViewController:vc];
            [tab presentViewController:nav animated:YES completion:nil];
            
        }
        if (button.tag==3) {
            
            NSLog(@"3");
        }
        if (button.tag==4) {
            
            NSLog(@"4");
        }if (button.tag==5) {
            
            NSLog(@"5");
        }
        if (button.tag==6) {
            
            NSLog(@"6");
        }
    }];
}
-(void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    self.view.userInteractionEnabled=NO;
    int beginIndex=2;
    for (int i=beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + UIHight;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                //                if (completionBlock) {
                //                    completionBlock();
                //                }
                !completionBlock ? : completionBlock();
            }];
        }
    }
    
}
- (IBAction)QuxiaoAction:(id)sender {
    
       [self cancelWithCompletionBlock:nil];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self QuxiaoAction:nil];

}


@end
