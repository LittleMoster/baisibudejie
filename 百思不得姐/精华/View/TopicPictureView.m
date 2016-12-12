//
//  TopicPictureView.m
//  百思不得姐
//
//  Created by user on 16/8/30.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "ToPicModel.h"
#import "ShowPictureViewController.h"

#import "ProgressView.h"


@interface TopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *SeebigpictureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@end
@implementation TopicPictureView

+(instancetype)setPictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
-(void)setTopic:(ToPicModel *)topic
{
    _topic=topic;
        // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)

     [self.progressView setProgress:topic.pictureProgress animated:YES];
    
[self.pictureView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    self.progressView.hidden=NO;
    topic.pictureProgress=1.0*receivedSize/expectedSize;
   
    [self.progressView setProgress:topic.pictureProgress animated:YES];
} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    self.progressView.hidden=YES;
    
    if (topic.isBigPicture==NO) return ;
    
    //开始图片上下文
    UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
    
//    将下载好的图片对象绘制到图片上下文中
    CGFloat width=topic.pictureF.size.width;
    CGFloat height=width*image.size.height/image.size.width;
    
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    //    获得新的图片
    self.pictureView.image=UIGraphicsGetImageFromCurrentImageContext();

//    结束上下文
    UIGraphicsEndImageContext();
    
}];
    
    //判断是否是GIF图
    NSString *extension=topic.large_image.pathExtension;
    
    self.gifImageView.hidden=![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.SeebigpictureBtn.hidden=NO;
    }else
    {
        self.SeebigpictureBtn.hidden=YES;

        
    }
    
    
    
}
-(void)showpicture
{
    if (self.pictureView.image==nil) return;
   
    ShowPictureViewController *showViewController=[[ShowPictureViewController alloc]init];
    
    showViewController.topic=_topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showViewController animated:YES completion:nil];
    
}
-(void)awakeFromNib
{
    self.pictureView.userInteractionEnabled=YES;
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpicture)]];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [super awakeFromNib];
    
}
@end
