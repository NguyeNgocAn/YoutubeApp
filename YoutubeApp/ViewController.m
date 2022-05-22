//
//  ViewController.m
//  YoutubeApp
//
//  Created by MacMini on 12/05/2022.
//

#import "ViewController.h"
#import "AVPlayerControl.h"
#import "TableViewCellCustom.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnTest;

@property (nonatomic, strong) AVPlayerViewController* player;
@property (nonatomic, strong) AVPlayer* av;
@property (nonatomic, strong) AVPlayerLayer *layer;
@property (nonatomic) NSString *videoName;
@property (nonatomic) NSMutableArray *arr;
@property (nonatomic) NSMutableArray *imageArr;
@property (nonatomic) NSMutableArray *videoArr;
@property (nonatomic) UIImage* imageView;
@property (nonatomic) UIView* viewPlayer;
@end

@implementation ViewController
//@synthesize player;
//@synthesize layer = _layer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.listVideo registerNib:[UINib nibWithNibName: @"TableViewCellCustom" bundle: NSBundle.mainBundle] forCellReuseIdentifier:@"TableViewCellCustom"];
    _arr = [[NSMutableArray alloc] initWithObjects:@"Chicken", @"Dog", nil];
    _imageArr = [[NSMutableArray alloc] initWithObjects:@"image1.jpeg", @"image2.jpeg", nil];
    _videoArr = [[NSMutableArray alloc] initWithObjects:@"video", @"video2", nil];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCellCustom";
    TableViewCellCustom *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[TableViewCellCustom alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *stringCell;
    stringCell = [_arr objectAtIndex: indexPath.row];
    self.videoName = _videoArr[indexPath.row];    
    [cell setPlayer: _videoName];
    [cell SetLabelText: stringCell];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"Hello World");
    self.videoName = _videoArr[indexPath.row];
    [self playerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)playerView{
    //set UIView
    _viewPlayer = [[UIView alloc]init];
    [_viewPlayer setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview: _viewPlayer];
    
    //set avplayer
    NSURL *url = [NSBundle.mainBundle URLForResource: _videoName withExtension: @"mp4"];
    _av = [[AVPlayer alloc] initWithURL: url];
    _player = [[AVPlayerViewController alloc] init];
    _player.player = _av;
    _player.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4);
    _player.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //set back button
    UIImage *image = [UIImage systemImageNamed: @"arrow.backward"];
    UIButton* btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [btnBack setImage: image forState: UIControlStateNormal];
    btnBack.tintColor = [UIColor whiteColor];
    [btnBack addTarget:self action:@selector(backToMainScreen:) forControlEvents:UIControlEventTouchDown];
    
    [_viewPlayer addSubview: _player.view];
    [_viewPlayer addSubview: btnBack];
    
    [_av play];
}

- (IBAction)backToMainScreen:(UIButton*)sender
{
    [self.viewPlayer removeFromSuperview];
}

@end
