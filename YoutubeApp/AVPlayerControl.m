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
//@property (strong, nonatomic) UIProgressView *progress;//Playback progress
@property (nonatomic) UISlider *sliderTime;
- (IBAction)btnPlayTouchDown:(id)sender;
- (IBAction)btnFullScreenTouchDown:(id)sender;

@end

@implementation AVPlayerControl

- (void)viewDidLoad {
    [super viewDidLoad];
    _control.delegate = self;
    //NSString *idVideo = [[NSString alloc]init];
    // Do any additional setup after loading the view.
    // remote file from server:
    //NSURL *url = [[NSURL alloc] initWithString:@""];
    NSURL* url = [[NSURL alloc]initWithString: self.idVideo];
    _av = [[AVPlayer alloc] initWithURL: url];
    _avC = [AVPlayerLayer playerLayerWithPlayer: self.av];
    _avC.videoGravity = AVLayerVideoGravityResizeAspect;
    _avC.frame = _stackView.frame;
    [_stackView.layer addSublayer:self.avC];
    //_progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/12)];
    //[self.view addSubview: self.progress];
    //_sliderTime = [[UISlider alloc]init];
    _sliderTime = [[UISlider alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/12)];
    
    [self.view addSubview: self.sliderTime];
    //[self.sliderTime addTarget:self action:@selector(handleSliderChangeValue:event:) forControlEvents:UIControlEventTouchUpInside];
    //[self addProgressObserver];
    [_av play];
    [self createSlider];  
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
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController willEndFullScreenPresentationWithAnimationCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

        [self.av play];

        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {


        }];
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
//    [super viewDidAppear:animated];
//    [_av play];
//}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [_av play];
//}

//- (void)viewWillDisappear:(BOOL)animatedillDisappear
//{
//    [super viewWillDisappear:animatedillDisappear];
//    [_av play];
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear: animated];
//    [self.av play];
//}



-(IBAction)sliding:(id)sender {
    CMTime newTime = CMTimeMakeWithSeconds(self.sliderTime.value, 1);
    [self.av seekToTime:newTime];
    [self.av play];
}

- (void)createSlider{
    //AVPlayerItem *item = self.av.currentItem;
    [self.av addPeriodicTimeObserverForInterval: CMTimeMake(1, 1) queue: dispatch_get_main_queue() usingBlock:^(CMTime time){
        AVPlayerItem *item = self.av.currentItem;
        self.sliderTime.value = CMTimeGetSeconds([self.av currentTime]);
        self.sliderTime.maximumValue = CMTimeGetSeconds([item duration]);
        [self.sliderTime addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
        self.sliderTime.minimumValue = 0.0;
        self.sliderTime.continuous = YES;
    }];
}

@end
