//
//  PlayerTool.h
//  百思不得姐
//
//  Created by user on 16/9/21.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerTool : NSObject


+ (void)playMusicWithUrlname:(NSString  *)urlname;


// 根据音乐文件名称停止音乐
+ (void)stopMusicWithUrlname:(NSString  *)urlname;
// 根据音乐文件名称暂停音乐
+ (void)pauseMusicWithUrlname:(NSString  *)urlname;

// 根据音乐文件名称播放音乐
+ (void)startMusicWithUrlname:(NSString  *)urlname;

@end
