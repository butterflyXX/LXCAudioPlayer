//
//  LXCAudioPlayerManager.m
//  audioPlayer
//
//  Created by Sven on 2017/6/27.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "LXCAudioPlayerManager.h"

@interface LXCAudioPlayerManager ()

@property(nonatomic,strong)NSTimer *time;

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,assign)BOOL isPlayer;

@end

@implementation LXCAudioPlayerManager

+(instancetype)sharedAudioPlayerManager {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
        [manager setManager];
    });
    return manager;
}

-(void)setManager {
    self.audioPlayer = [[AVPlayer alloc] init];
    self.delegateArray = [NSMutableArray array];
}

-(void)playerItemWithUrlString:(NSString *)urlString {
    self.isPlayer = YES;
    self.urlString = urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    [self.audioPlayer replaceCurrentItemWithPlayerItem:item];
    
    if (self.time) {
        
    } else {
        
        self.time = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            for (id<LXCAudioPlayerManagerDelegate> delegate in self.delegateArray) {
                if ([delegate respondsToSelector:@selector(playerWithcurrentTime:andTotalTime:)]) {
                    [delegate playerWithcurrentTime:CMTimeGetSeconds(self.audioPlayer.currentTime) andTotalTime:CMTimeGetSeconds(self.audioPlayer.currentItem.duration)];
                }
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemEndPlayer) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    
    [self.audioPlayer play];
}

-(void)changeCurrentTime:(CGFloat)currenTime {
  
    [self.audioPlayer seekToTime:CMTimeMake(currenTime * CMTimeGetSeconds(self.audioPlayer.currentItem.duration), 1)];
    
}

-(void)itemEndPlayer {
    NSLog(@"sd");
    
    //这个方法中取切换下一首曲目
    [self playerItemWithUrlString:_urlString];
    
}

-(void)pause {
    [self.audioPlayer pause];
    [self.time setFireDate:[NSDate distantFuture]];
    self.isPlayer = NO;
}

-(void)player {
    [self.time setFireDate:[NSDate date]];
    [self.audioPlayer play];
    self.isPlayer = YES;
}

-(BOOL)isPlayering {
    return self.isPlayer;
}

-(void)setIsPlayer:(BOOL)isPlayer {
    _isPlayer = isPlayer;
    
    for (id<LXCAudioPlayerManagerDelegate>delegate in self.delegateArray) {
        if ([delegate respondsToSelector:@selector(playerstateDidChanged:)]) {
            [delegate playerstateDidChanged:isPlayer];
        }
    }
}

-(void)addDelegate:(id<LXCAudioPlayerManagerDelegate>)delegate {
    __weak id<LXCAudioPlayerManagerDelegate> weakDelegate = delegate;

    [self.delegateArray addObject:weakDelegate];
}



@end
