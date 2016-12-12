//
//  TopicVoiceView.m
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TopicVoiceView.h"
#import "ToPicModel.h"
#import <UIImageView+WebCache.h>
#import "ShowPictureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicTool.h"
#import "PlayerTool.h"
@interface TopicVoiceView ()<MusicToolDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pictureBGimageView;
@property (weak, nonatomic) IBOutlet UILabel *voicePlayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;
/** 音乐播放工具类*/
@property(nonatomic,strong)MusicTool *player;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;
/** 保存音频URL*/
@property(nonatomic,strong)NSString *url;
/** 保存音频数组*/

@end
@implementation TopicVoiceView


+(instancetype)setVoiceView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)showpicture
{
    
   
        

    if ([self.topic.voiceuri isEqualToString:self.url]) {
         [self PlayMusic];
    }else
    {
         [self PlayMusic];
        NSLog(@"%@",self.url);
        self.PlayButton.highlighted=YES;
        _player =[[MusicTool alloc]initWithSongUrl:self.topic.voiceuri];
        [_player OtherSong:self.topic.voiceuri];
    }
    self.url=self.topic.voiceuri;
    NSLog(@"%@",self.url);
 

}
-(void)awakeFromNib
{
    self.pictureBGimageView.userInteractionEnabled=YES;
    [self.pictureBGimageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpicture)]];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [super awakeFromNib];
    
}

-(void)setTopic:(ToPicModel *)topic
{
    _topic=topic;
    //图片
    [self.pictureBGimageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.voicePlayCountLabel.text=[NSString stringWithFormat:@"%ld次播放",topic.playcount];
    //时长
    NSInteger minute=topic.voicetime/60;
    NSInteger second=topic.voicetime%60;
    self.voiceTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}
-(void)PlayMusic
{
    if (self.PlayButton.highlighted==YES) {
        self.PlayButton.highlighted=NO;
//       [ PlayerTool pauseMusicWithUrlname:self.url];
        [_player puasePlay];
        
    }else if(self.PlayButton.highlighted==NO)
    {
        self.PlayButton.highlighted=YES;
//        [PlayerTool startMusicWithUrlname:self.url];
        [_player startPlay];
    }
}
-(void)getSongCurrentTime:(NSString *)currentTime andTotalTime:(NSString *)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount
{
    [self.progressV setProgress:progress];
}
@end
