//
//  MusicTool.h
//  音频播放
//
//  Created by user on 16/9/20.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol MusicToolDelegate <NSObject>


/**
 *
 *  @param currentTime 当前时间
 *  @param totalTime   总共时间
 *  @param progress    歌曲进度
 *  @param tapCount    点击次数(第几首)
 */
-(void)getSongCurrentTime:(NSString *)currentTime andTotalTime:(NSString *)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount;
@end

@interface MusicTool : NSObject

/** 代理*/
@property(nonatomic,assign)id<MusicToolDelegate> delegate;

/**
 *  volume 0.0~1.0 音量
 */
@property(nonatomic,assign)CGFloat volume;


/**
 *  初始化MusicTool
 *
 *  @param frame  AVPlayerLayer的frame
 *  @param urlArr 歌曲网址的数组
 *
 *  @return   MusicTool
 */
-(instancetype)initWithSongUrlArr:(NSArray *)urlArr ;

/**
 *  初始化MusicTool
 *
 *  @param url   歌曲网址
 *
 *  @return MusicTool
 */
-(instancetype)initWithSongUrl:(NSString *)url;
/**
 *  开始播放
 */
-(void)startPlay;
/**
 *  暂停播放
 */
-(void)puasePlay;
/**
 *  播放下一首
 */
-(void)nextSong;
/**
 *  播放上一首
 */
-(void)lastSong;


-(void)deletePlayer;
/**
 *  播放其他歌曲
 *
 */
-(void)OtherSong:(NSString *)url;
@end
