//
//  ViewController.m
//  YoutubeApp
//
//  Created by MacMini on 12/05/2022.
//

#import "ViewController.h"
#import "AVPlayerControl.h"
#import "TableViewCellCustom.h"
#import "PlayerViewController.h"

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
@property (nonatomic) NSString *stringURLImage;
@property (nonatomic) NSData *imageData;
@property (nonatomic) NSInteger totalRow;
//@property (nonatomic) UIImage* imageView;
@property (nonatomic) UIView* viewPlayer;
@property (nonatomic) NSIndexPath *indexPath;
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
    [self connection: 1];
    // _imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString: self.stringURLImage]];
    //double screenHeigh = [UIScreen mainScreen].bounds.size.height;
    //NSLog (@"heigh screen: %f ", screenHeigh);
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
    NSString *stringURLImage = [self.imageArr objectAtIndex: indexPath.row];
    _videoName = self.videoArr[indexPath.row];
    //NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString: stringURLImage]];
    //cell.imageView.image = [UIImage imageWithData: imageData];
    cell.idVideo = self.videoName;
    cell.idImage = stringURLImage;
    [cell SetLabelText: stringCell];
    if(indexPath.row == 0)//|| indexPath.row == totalRow - 1)
    {
        [cell play];
    }
    return cell;
}

- (void)tableView:(UITableView*) tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCellCustom * theCell = (TableViewCellCustom*)cell;
    _totalRow = [self.listVideo numberOfRowsInSection: indexPath.section];
    static int index = 2;
    
    if(indexPath.row == self.totalRow - 1){
        NSLog(@"Load the table");
        [self connection: index];
    }
    [theCell setPlayer];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //NSLog(@"Hello World");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AVPlayerControl *singleView = [storyBoard instantiateViewControllerWithIdentifier:@"AVPlayerControl"];
    singleView.idVideo = self.videoName;
    [self.navigationController pushViewController: singleView animated: YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double screenHeigh = [UIScreen mainScreen].bounds.size.height;
    return screenHeigh/3;
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
//    if (@available(iOS 13.0, *)) {
//        UIImage *image = [UIImage systemImageNamed: @"arrow.backward"];
//
//        UIButton* btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
//        [btnBack setImage: image forState: UIControlStateNormal];
//        //[btnBack setTitle:@"X" forState:UIControlStateNormal];
//        btnBack.tintColor = [UIColor whiteColor];
//        [btnBack addTarget:self action:@selector(backToMainScreen:) forControlEvents: UIControlEventTouchDown];
//        [_viewPlayer addSubview: _player.view];
//        [_viewPlayer addSubview: btnBack];
//    } else {
//        // Fallback on earlier versions
//        UIButton* btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
//        //[btnBack setImage: image forState: UIControlStateNormal];
//        [btnBack setTitle:@"X" forState:UIControlStateNormal];
//        btnBack.tintColor = [UIColor whiteColor];
//        [btnBack addTarget:self action:@selector(backToMainScreen:) forControlEvents: UIControlEventTouchDown];
//        [_viewPlayer addSubview: _player.view];
//        [_viewPlayer addSubview: btnBack];
//    }
//
//
//    [_av play];
//}

- (IBAction)backToMainScreen:(UIButton*)sender
{
    [self.viewPlayer removeFromSuperview];
    
}

-(void)connection:(int)index{
    NSURL *URL = [NSURL URLWithString:[@"https://b11.cnnd.vn/kenh14-api/app/video/hot/" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *requestURL = [[NSMutableURLRequest alloc] initWithURL:URL];
        [requestURL setHTTPMethod:@"POST"];
    NSString *myString = [NSString stringWithFormat:@"secret_key=gU4mI9lX8jM7kM6t&page_index=%d", index];
        [requestURL setHTTPBody:[myString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:requestURL queue:NSOperationQueue.mainQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray<NSDictionary *> *videos = dict[@"Videos"];
            for (NSDictionary *item in videos) {
                //NSLog(@"%@", item);
                NSString *valueVideos = [item objectForKey: @"FileName"];
                valueVideos = [self hanleStringVideo: valueVideos];
                [self.videoArr addObject: valueVideos];
                NSString *valueTitle = [item objectForKey:@"Name"];
                [self.arr addObject: valueTitle];
                NSString *valueAvarta = [item objectForKey:@"Avatar"];
                [self.imageArr addObject:valueAvarta];
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

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    
  //executes when you scroll the scrollView
    //tableView.indexPathsForSelectedRows.lastObject
    for (UITableViewCell *cell in [self.listVideo visibleCells]) {
        _indexPath = [self.listVideo indexPathForCell:cell];
        _stringURLImage = [self.imageArr objectAtIndex: self.indexPath.row];
        CGRect rect = [self.listVideo convertRect:[self.listVideo rectForRowAtIndexPath: self.indexPath] toView: [self.listVideo superview]];
        TableViewCellCustom * theCell = (TableViewCellCustom *)[self.listVideo cellForRowAtIndexPath: self.indexPath];
        
        double locationPlay = [UIScreen mainScreen].bounds.size.height/2 - rect.origin.y;
        if((locationPlay >= 0 && locationPlay < [UIScreen mainScreen].bounds.size.height/3)) {
            [theCell.contentView.layer setBorderColor: [UIColor redColor].CGColor];
            [theCell.contentView.layer setBorderWidth: 1.0f];
            [theCell play];
        }
//      else if ([self.arr lastObject]){
//            static int index = 2;
//            NSLog(@"end dragg");
//            [self connection: index];
//      }
        else{
            [theCell.contentView.layer setBorderColor: [UIColor whiteColor].CGColor];
            [theCell pause];
        }
        //NSLog(@"indexPath1: %@", self.indexPath);
        //NSLog(@"y: %f", rect.size.height);
        //NSLog(@"db: %f", db);
    }
//    if ([self.arr lastObject]){
//        static int index = 2;
//        NSLog(@"end dragg");
//        [self connection: index];
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 // execute when you drag the scrollView
    //[self.av play];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //[self.av play];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"end dragg 1");
//    if(self.indexPath.row == self.totalRow - 1){
//             //this is the last row in section.
//        NSLog(@"end dragg 2");
//        [self connection: index];
//    }
//    NSInteger totalRow = [self.listVideo numberOfSections];
//    NSInteger rowCount = [self.arr count];
//    //NSLog(@"array count: %ld", (long)rowCount);
//    if([self.arr lastObject])
//    {
//        NSLog(@"end dragg last item");
//        [self connection: index];
//    }
//    if()
//    {
//        [self connection: index];
//    }
}

@end
