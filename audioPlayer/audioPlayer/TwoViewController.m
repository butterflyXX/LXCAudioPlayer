//
//  TwoViewController.m
//  audioPlayer
//
//  Created by Sven on 2017/6/27.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "TwoViewController.h"
//#import "audioPalyerManager.h"
#import "LXCAudioPlayerManager.h"

@interface TwoViewController ()<LXCAudioPlayerManagerDelegate>

@property(nonatomic,strong)LXCAudioPlayerManager *audioManager;

@property (weak, nonatomic) IBOutlet UILabel *currenItemLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalItemLabel;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@end

@implementation TwoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.audioManager) {
        self.stateButton.selected = ![self.audioManager isPlayering];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.audioManager = [LXCAudioPlayerManager sharedAudioPlayerManager];
    [self.audioManager addDelegate:self];
    self.iconImageView.layer.cornerRadius = 150;
    self.iconImageView.layer.masksToBounds = YES;
    
    
    self.audioManager = [LXCAudioPlayerManager sharedAudioPlayerManager];
    
    
}
- (IBAction)sliderAction:(UISlider *)sender {
    [self.audioManager changeCurrentTime:sender.value];
}


- (IBAction)beforeItem:(UIButton *)sender {
    [self.audioManager playerItemWithUrlString:@"http://7xviwa.com1.z0.glb.clouddn.com/elcs.mp3"];
}

- (IBAction)afterItem:(UIButton *)sender {
    [self.audioManager playerItemWithUrlString:@"http://7xviwa.com1.z0.glb.clouddn.com/elcs.mp3"];
}

- (IBAction)changedState:(UIButton *)sender {
    
//    sender.selected = !sender.selected;
    
    if (!sender.selected) {
        [self.audioManager pause];
    } else {
        [self.audioManager player];
    }

}

- (IBAction)dismissViewController:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - LXCAudioPlayerManagerDelegate

-(void)playerWithcurrentTime:(NSInteger)currentTime andTotalTime:(NSInteger)totalTime {
    self.slider.value = 1.0 * currentTime / (totalTime ? totalTime : 1);
    
//    if ([[NSString stringWithFormat:@"%02d:%02d:%02d",(int)currentTime/3600,(int)currentTime%3600/60,(int)currentTime%60] isEqualToString:self.currenItemLabel.text]) {
//        
//    } else {
//        
//    }
    [UIView animateWithDuration:0.1 animations:^{
        self.iconImageView.transform = CGAffineTransformRotate(self.iconImageView.transform, 2 * M_PI/300);
        [self.view layoutIfNeeded];
    }];
    
    
    self.currenItemLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)currentTime/3600,(int)currentTime%3600/60,(int)currentTime%60];
    self.totalItemLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)totalTime/3600,(int)totalTime%3600/60,(int)totalTime%60];
}

-(void)playerstateDidChanged:(BOOL)isplayer {
    self.stateButton.selected = !isplayer;
}


@end
