//
//  TopicVideoView.m
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TopicVideoView.h"
#import "ToPicModel.h"
#import <UIImageView+WebCache.h>
#import "ShowPictureViewController.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface TopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *BGimageView;
@property (weak, nonatomic) IBOutlet UILabel *videoPlayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@end
@implementation TopicVideoView

+(instancetype)setVideoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
-(void)showpicture
{
    if (self.BGimageView.image==nil) return;
    
//    ShowPictureViewController *showViewController=[[ShowPictureViewController alloc]init];
    
//    showViewController.topic=_topic;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showViewController animated:YES completion:nil];
//    NSString *url = [NSString stringWithFormat:@"http://192.168.1.53:8080/MJServer/%@", model.url];
//    NSLog(@"%@",_topic.videouri);
         NSURL *videoUrl=[NSURL URLWithString:_topic.videouri];
         MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:videoUrl];
        //弹出播放器
        [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:movieVc];
    
}
-(void)awakeFromNib
{
    self.BGimageView.userInteractionEnabled=YES;
    [self.BGimageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpicture)]];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [super awakeFromNib];
    
}
- (IBAction)PlayVoideClick:(id)sender {
    
    [self showpicture];
}

-(void)setTopic:(ToPicModel *)topic
{
    _topic=topic;
    //图片
    [self.BGimageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.videoPlayCountLabel.text=[NSString stringWithFormat:@"%ld次播放",topic.playcount];
    //时长
    NSInteger minute=topic.videotime/60;
    NSInteger second=topic.videotime%60;
    self.videoTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}


@end
