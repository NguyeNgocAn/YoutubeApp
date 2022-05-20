//
//  AVPlayerControl.m
//  YoutubeApp
//
//  Created by MacMini on 16/05/2022.
//

#import "AVPlayerControl.h"


@interface AVPlayerControl ()

@property (nonatomic) AVPlayer *av;
@property (nonatomic) AVPlayerLayer *avC;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (nonatomic) AVPlayerViewController *control;
- (IBAction)btnPlayTouchDown:(id)sender;
- (IBAction)btnFullScreenTouchDown:(id)sender;

@end

@implementation AVPlayerControl

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *idVideo = [[NSString alloc]init];
    // Do any additional setup after loading the view.
    // remote file from server:
    //NSURL *url = [[NSURL alloc] initWithString:@""];
    NSURL* url = [NSBundle.mainBundle URLForResource: _idVideo withExtension:@"mp4"];
    _av = [[AVPlayer alloc] initWithURL: url];
    _avC = [AVPlayerLayer playerLayerWithPlayer: self.av];
    _avC.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //CGFloat srcWidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat srcHeight = [UIScreen mainScreen].bounds.size.height;
    _avC.frame = _stackView.bounds;//self.view.frame;
    //CGRectMake(0, 44, srcWidth, srcHeight/4);
    //[self presentViewController: _avC animated: YES completion: nil];
    [_stackView.layer addSublayer:self.avC];
    [_av play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnFullScreenTouchDown:(id)sender {
    //[_av pause];
    _control = [[AVPlayerViewController alloc] init];
    _control.player = _av;
    self.control.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController: self.control animated: YES completion: nil];
    //[_av play];
    //_avC.frame = self.view.bounds;
}

- (IBAction)btnPlayTouchDown:(id)sender {
    if(_av.rate == 0)
    {
        UIImage *image = [UIImage systemImageNamed:@"pause.fill"];     
        [_btnPlay setImage:image forState:UIControlStateNormal];
        [_av play];
    }
    else{
        UIImage *image = [UIImage systemImageNamed:@"play.fill"];
        [_btnPlay setImage:image forState:UIControlStateNormal];
        [_av pause];
    }
}
//- (void)viewDidAppear:(BOOL)animated{
//    [_av play];
//}
//
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [_av play];
//}

//- (void)viewWillDisappear:(BOOL)animatedillDisappear
//{
//    [_av play];
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    if(_av.rate == 0)
//    {
//        [_av play];
//    }
//}

@end
