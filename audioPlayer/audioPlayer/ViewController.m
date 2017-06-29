//
//  ViewController.m
//  audioPlayer
//
//  Created by Sven on 2017/6/27.
//  Copyright © 2017年 Sven. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import "LXCAudioPlayerManager.h"


@interface ViewController ()<LXCAudioPlayerManagerDelegate>

@property(nonatomic,strong)TwoViewController *twoVc;
@property(nonatomic,strong)LXCAudioPlayerManager *audioPlayerManager;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIStoryboard *sty = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.twoVc = [sty instantiateViewControllerWithIdentifier:@"twoVc"];
    
    
    self.audioPlayerManager = [LXCAudioPlayerManager sharedAudioPlayerManager];
    [self.audioPlayerManager addDelegate:self];
    
//    self.twoVc = [TwoViewController new];
}

-(void)playerstateDidChanged:(BOOL)isplayer {
    self.stateButton.selected = !isplayer;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.audioPlayerManager) {
        self.stateButton.selected = ![self.audioPlayerManager isPlayering];
    }
}

- (IBAction)playerStatus:(UIButton *)sender {
    
//    sender.selected = !sender.selected;
    
    if (!sender.selected) {
        [self.audioPlayerManager pause];
    } else {
        [self.audioPlayerManager player];
    }

}


- (IBAction)gotoAudioPlayerViewController:(id)sender {
    
    [self presentViewController:self.twoVc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)beforeItem:(id)sender {
    [self.audioPlayerManager playerItemWithUrlString:@"http://7xviwa.com1.z0.glb.clouddn.com/elcs.mp3"];
}


- (IBAction)afterItem:(id)sender {
    
    [self.audioPlayerManager playerItemWithUrlString:@"http://7xviwa.com1.z0.glb.clouddn.com/elcs.mp3"];
    
}



@end
