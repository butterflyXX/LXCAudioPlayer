//
//  LXCAudioPlayerManager.h
//  audioPlayer
//
//  Created by Sven on 2017/6/27.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol LXCAudioPlayerManagerDelegate <NSObject>

-(void)playerWithcurrentTime:(NSInteger)currentTime andTotalTime:(NSInteger)totalTime;

-(void)playerstateDidChanged:(BOOL)isplayer;

@end

@interface LXCAudioPlayerManager : NSObject

//音乐播放器
@property(nonatomic,strong)AVPlayer *audioPlayer;

@property(nonatomic,weak)id<LXCAudioPlayerManagerDelegate> delegate;

@property(nonatomic,strong)NSMutableArray<id<LXCAudioPlayerManagerDelegate>> *delegateArray;

-(void)addDelegate:(id<LXCAudioPlayerManagerDelegate>)delegate;

+(instancetype)sharedAudioPlayerManager;

-(void)playerItemWithUrlString:(NSString *)urlString;

-(void)changeCurrentTime:(CGFloat)currenTime;

-(void)pause;

-(void)player;

-(BOOL)isPlayering;

@end
