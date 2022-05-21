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
    //self.listVideo.delegate = self;
    //self.listVideo.dataSource = self;
    _arr = [[NSMutableArray alloc] init];
    _imageArr = [[NSMutableArray alloc] init];
    _videoArr = [[NSMutableArray alloc] init];
    [self connection];
    //[self.listVideo reloadData];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCellCustom";
    TableViewCellCustom *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *stringCell = [self.arr objectAtIndex: indexPath.row];
    _videoName = self.videoArr[indexPath.row];
    [cell setPlayer: self.videoName];
    [cell SetLabelText: stringCell];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"Hello World");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[av pause];
}

//- (void)playerView{
//    //set UIView
//    _viewPlayer = [[UIView alloc]init];
//    [_viewPlayer setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    [self.view addSubview: _viewPlayer];
//
//    //set avplayer
//    NSURL *url = [NSBundle.mainBundle URLForResource: _videoName withExtension: @"mp4"];
//    _av = [[AVPlayer alloc] initWithURL: url];
//    _player = [[AVPlayerViewController alloc] init];
//    _player.player = _av;
//    _player.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4);
//    _player.videoGravity = AVLayerVideoGravityResizeAspectFill;
//
//    //set back button
//    UIImage *image = [UIImage systemImageNamed: @"arrow.backward"];
//    UIButton* btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
//    [btnBack setImage: image forState: UIControlStateNormal];
//    btnBack.tintColor = [UIColor whiteColor];
//    [btnBack addTarget:self action:@selector(backToMainScreen:) forControlEvents: UIControlEventTouchDown];
//    [_viewPlayer addSubview: _player.view];
//    [_viewPlayer addSubview: btnBack];
//
//    [_av play];
//}

- (IBAction)backToMainScreen:(UIButton*)sender
{
    [self.viewPlayer removeFromSuperview];
}

-(void)connection{
    NSURL *URL = [NSURL URLWithString:[@"https://b11.cnnd.vn/kenh14-api/app/video/hot/" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *requestURL = [[NSMutableURLRequest alloc] initWithURL:URL];
        [requestURL setHTTPMethod:@"POST"];
    NSString *myString = [NSString stringWithFormat:@"secret_key=gU4mI9lX8jM7kM6t&page_index=%d",1];
        [requestURL setHTTPBody:[myString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:requestURL queue:NSOperationQueue.mainQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray<NSDictionary *> *videos = dict[@"Videos"];
            for (NSDictionary *item in videos) {
                //NSLog(@"%@", item);
                NSString *valueVideos = [item objectForKey: @"FileName"];
                NSLog(@"%@", valueVideos);
                valueVideos = [self hanleStringVideo: valueVideos];
                [self.videoArr addObject: valueVideos];
                NSString *valueTitle = [item objectForKey:@"Name"];
                [self.arr addObject: valueTitle];
                NSLog(@"%@", valueTitle);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listVideo reloadData];
            });
            //NSLog(@"%@", dict.description);
        }
    }];
}

-(NSString*)hanleStringVideo:(NSString *)stringInput
{
    NSInteger location = [stringInput rangeOfString:@"/master"].location;
    NSRange range = NSMakeRange(0, location);
    stringInput = [stringInput substringWithRange:range];    
    return stringInput;
}

@end
