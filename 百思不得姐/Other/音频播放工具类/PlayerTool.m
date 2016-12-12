//
//  PlayerTool.m
//  百思不得姐
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "PlayerTool.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerTool ()

//@property(nonatomic,retain)AVPlayerItem *songItem;
//@property(nonatomic,retain)AVPlayer *myplayer;
@end
@implementation PlayerTool


static NSMutableDictionary *_soundIDs;

static NSMutableDictionary *_players;

+ (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
+ (NSMutableDictionary *)players
{
    if (!_players) {
        _players = [NSMutableDictionary dictionary];
    }
    return _players;
}

// 根据音乐文件名称播放音乐
+ (void)playMusicWithUrlname:(NSString  *)urlname
{
    // 0.判断文件名是否为nil
    if (urlname == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
   AVPlayer* player = [self players][urlname];
    
    // 2.判断播放器是否为nil
    if (!player) {
        NSLog(@"创建新的播放器");
        
        // 2.1根据文件名称加载音效URL
//        NSURL *url = [[NSBundle mainBundle] URLForResource:urlname withExtension:nil];
        NSURL *url=[NSURL URLWithString:urlname];
//
//        [_player play];
        // 2.2判断url是否为nil
        if (!url) {
            return;
        }
        
        // 2.3创建播放器
//        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
       AVPlayerItem* songItem=[AVPlayerItem playerItemWithURL:url];
        player=[AVPlayer playerWithPlayerItem:songItem];
        
        // 2.4准备播放
//        if(![player prepareToPlay])
//        {
//            return;
//        }
        // 允许快进
        //   player.enableRate = YES;
        //   player.rate = 3;
        
        // 2.5将播放器添加到字典中
        [self players][urlname] = player;
        
    }
    // 3.播放音乐
//    if (!player.playing)
//    {
        [player play];
//    }
    
}

// 根据音乐文件名称暂停音乐
+ (void)pauseMusicWithUrlname:(NSString  *)urlname
{
    // 0.判断文件名是否为nil
    if (urlname == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVPlayer *player = [self players][urlname];
    
    // 2.判断播放器是否存在
    if(player)
    {
        // 2.1判断是否正在播放
        
            // 暂停
            [player pause];
       
    }
    
}
// 根据音乐文件名称播放音乐
+ (void)startMusicWithUrlname:(NSString  *)urlname
{
    // 0.判断文件名是否为nil
    if (urlname == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVPlayer *player = [self players][urlname];
    
    // 2.判断播放器是否存在
    if(player)
    {
        
        // b播放
        [player play];
        
    }
    
}

// 根据音乐文件名称停止音乐
+ (void)stopMusicWithUrlname:(NSString  *)urlname
{
    // 0.判断文件名是否为nil
    if (urlname == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVPlayer *player = [self players][urlname];
    
    // 2.判断播放器是否为nil
    if (player) {
        // 2.1停止播放
        [player pause];
        // 2.2清空播放器
        player = nil;
        // 2.3从字典中移除播放器
        [[self players] removeObjectForKey:urlname];
    }
}
@end
