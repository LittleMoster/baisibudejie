//
//  MusicTool.m
//  音频播放
//
//  Created by user on 16/9/20.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "MusicTool.h"
#import <AVFoundation/AVFoundation.h>


@interface MusicTool ()

@property(nonatomic,retain)AVPlayerItem *songItem;
@property(nonatomic,retain)AVPlayer *player;

@property(nonatomic,copy)NSArray *songArr;//歌曲的数组

@property(nonatomic,assign)NSInteger tapCount;//点击次数
@property(nonatomic,retain)id timeObserver;//时间观察
/** 临时的歌曲数组*/
@property(nonatomic,strong)NSMutableArray *musicArr;

@end

@implementation MusicTool
-(NSMutableArray *)musicArr
{
    if (_musicArr==nil) {
        _musicArr=[NSMutableArray array];
    }
    return _musicArr;
}
-(instancetype)initWithSongUrl:(NSString *)url
{
    if (self=[super init]) {
        
        [self.musicArr addObject:url];
        NSURL *Musicurl=[NSURL URLWithString:url];
        _songItem=[AVPlayerItem playerItemWithURL:Musicurl];
        _player=[AVPlayer playerWithPlayerItem:_songItem];
        [_player play];
        //声音设置为0.5;
        _volume=0.5;
        //添加播放器状态的监听
        [self addAVPlayerStatusObserver];
        //添加数据缓存的监听
        [self addNetDataStatusObserver];
        
    }
    return self;
}

-(void)deletePlayer
{
    _player=nil;
}
#pragma mark----KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //播放器缓冲状态
    if ([keyPath isEqualToString:@"status"]) {
        switch (_player.status) {
            case AVPlayerStatusUnknown:{
                NSLog(@"未知状态，此时不能播放");
            }
                break;
            case AVPlayerStatusReadyToPlay:{
                NSLog(@"准备完毕，可以播放");
                //添加时间的监听
                [self addTimeObserve];
                //添加播放完成的通知
                [self addPlayToEndObserver];
            }
                break;
            case AVPlayerStatusFailed:{
                NSLog(@"加载失败，网络或者服务器出现问题");
            }
                break;
            default:
                break;
        }
    }
    
    //数据缓冲状态
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //缓冲时间的数组
        NSArray *array=_songItem.loadedTimeRanges;
        //本次缓冲的时间范围
        CMTimeRange timeRange=[array.firstObject CMTimeRangeValue];
        NSTimeInterval totalBuffer=CMTimeGetSeconds(timeRange.start)+CMTimeGetSeconds(timeRange.duration);//缓冲总长度
                NSLog(@"共缓冲%.2f",totalBuffer);
    }
}
-(instancetype)initWithSongUrlArr:(NSArray *)urlArr
{
    
    if (self=[super init]) {
        _songArr=urlArr;
        NSString *urlStr=urlArr[0];
        NSURL *Musicurl=[NSURL URLWithString:urlStr];
        _songItem=[AVPlayerItem playerItemWithURL:Musicurl];
        _player=[AVPlayer playerWithPlayerItem:_songItem];
        [_player play];
        //声音设置为0.5;
        _volume=0.5;
        //添加播放器状态的监听
        [self addAVPlayerStatusObserver];
        //添加数据缓存的监听
        [self addNetDataStatusObserver];
        

    }
    return self;
}
#pragma mark----监听播放器的加载状态
-(void)addAVPlayerStatusObserver
{
    [_songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark----数据缓冲状态的监听
-(void)addNetDataStatusObserver
{
    [_songItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark---开始播放
-(void)startPlay
{
    [_player play];
    
}
#pragma mark---暂停播放
-(void)puasePlay
{
    [_player pause];
}
#pragma mark----播放下一首
-(void)nextSong
{
    //移除所有监听
    [self removeAllNotice];
    _tapCount++;
    if (_tapCount>=_songArr.count) {
        _tapCount=0;
    }
    NSLog(@"当前播放第%ld首歌",_tapCount);
    //替换songItem
    [self playerWithItem];
    //添加播放器状态的监听
    [self addAVPlayerStatusObserver];
    //添加数据缓存的监听
    [self addNetDataStatusObserver];
}
#pragma mark---播放上一首
-(void)lastSong
{
    //移除所有监听
    [self removeAllNotice];
    _tapCount--;
    if (_tapCount<0) {
        _tapCount=_songArr.count-1;
    }
    NSLog(@"当前播放第%ld首歌",_tapCount);
    //替换songItem
    [self playerWithItem];
    //添加播放器状态的监听
    [self addAVPlayerStatusObserver];
    //添加数据缓存的监听
    [self addNetDataStatusObserver];
}

#pragma mark---根据点击次数切换songItem
-(void)playerWithItem
{
    NSString *urlStr=_songArr[_tapCount];
    NSURL *url=[NSURL URLWithString:urlStr];
    _songItem=[AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_songItem];
    [_player play];
}
#pragma mark---移除数据加载状态的监听
-(void)removeNetDataObserver
{
    [_songItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
#pragma mark----移除通知
-(void)removePlayToEndNotice
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark-----移除所有监听
-(void)removeAllNotice
{
    //移除时间进度的监听
    [self removeTimeObserver];
    //移除播放完成的通知
    [self removePlayToEndNotice];
    //移除播放器状态的监听
    [self removeAVPlayerObserver];
    //移除数据缓存的监听
    [self removeNetDataObserver];
}
-(void)OtherSong:(NSString *)url
{
    
    //移除所有监听
    [self removeAllNotice];
   
    //替换songItem
    [self playerOtherItem];
    //添加播放器状态的监听
    [self addAVPlayerStatusObserver];
    //添加数据缓存的监听
    [self addNetDataStatusObserver];
}
-(void)playerOtherItem
{
    NSString *urlStr=[self.musicArr lastObject];
    NSURL *url=[NSURL URLWithString:urlStr];
    _songItem=[AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_songItem];
    [_player play];
}
#pragma mark----播放完成后发送通知
-(void)addPlayToEndObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_songItem];
}
#pragma mark---通知的方法
-(void)playFinished:(NSNotification *)notice
{
    NSLog(@"播放完成，自动进入下一首");
    //播放下一首
    [self nextSong];
}
#pragma mark---移除媒体加载状态的监听
-(void)removeAVPlayerObserver
{
    [_songItem removeObserver:self forKeyPath:@"status"];
}
#pragma mark---移除时间观察者
-(void)removeTimeObserver
{
    if (_timeObserver) {
        [_player removeTimeObserver:_timeObserver];
        _timeObserver=nil;
    }
}
#pragma mark----设置player的volume
-(void)setPlayerVolume
{
    _player.volume=_volume;
}
- (NSString *)formatTime:(float)num{
    
    int sec =(int)num%60;
    int min =(int)num/60;
    if (num < 60) {
        return [NSString stringWithFormat:@"00:%02d",(int)num];
    }
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}
#pragma mark----添加观察者获取当前时间,总共时间,进度
-(void)addTimeObserve
{
    __block  AVPlayerItem *songItem=_songItem;
    __block typeof(self) bself = self;
    _timeObserver=[_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //设置player的声音
        [bself setPlayerVolume];
    
        //当前时间
        float current=CMTimeGetSeconds(time);
        //总共时间
        float total=CMTimeGetSeconds(songItem.duration);
        //进度
        float progress=current/total;
        //将值传入知道delegate方法中
        [bself.delegate getSongCurrentTime:[bself formatTime:current]  andTotalTime:[bself formatTime:total] andProgress:progress andTapCount:bself.tapCount];
    }];
}





@end
