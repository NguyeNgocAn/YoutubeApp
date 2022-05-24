//
//  PlayerViewController.m
//  YoutubeApp
//
//  Created by MacMini on 23/05/2022.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[NSURL alloc]initWithString: self.urlVideo];
    _player = [[AVPlayer alloc]initWithURL: url];
    _playerLayer = [[AVPlayerLayer alloc]initWithLayer:self.player];
    //_playerLayer.frame = *(_rect);
}

- (void) play
{
    if(self.player.rate == 0)
    {
        [self.player play];
    }
    else {
        [self.player pause];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
