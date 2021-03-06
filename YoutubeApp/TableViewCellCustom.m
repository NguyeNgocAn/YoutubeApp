//
//  TableViewCellCustom.m
//  YoutubeApp
//
//  Created by MacMini on 19/05/2022.
//

#import "TableViewCellCustom.h"
#import "PlayerViewController.h"

@interface TableViewCellCustom()

@property (nonatomic, strong) AVPlayer *avP;
@property (nonatomic, strong) AVPlayerLayer *avLayer;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UILabel* lb;
@property (nonatomic, strong) UIScrollView *srv;
//@property (nonatomic) UIView* viewPlayer;

@end

@implementation TableViewCellCustom

- (void)awakeFromNib {
    [super awakeFromNib];
    _avLayer = [AVPlayerLayer playerLayerWithPlayer:nil];
    _avLayer.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height*2/3);//self.contentView.bounds;
    _avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _lb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height*2/3, self.contentView.frame.size.width, self.contentView.frame.size.height/3)];
    _lb.lineBreakMode = NSLineBreakByWordWrapping;
    _lb.numberOfLines = 4;
    _lb.textAlignment = NSTextAlignmentLeft;
    _lb.textColor = [UIColor blackColor];
    _lb.font = [UIFont fontWithName:@"Arial" size:13];
    [self.contentView.layer addSublayer: self.avLayer];
    [self.contentView addSubview: self.lb];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    //[self.avP play];
}

- (void)setPlayer{
    _url = self.idVideo;
    NSURL * url = [[NSURL alloc]initWithString: self.url];
    _avP = [[AVPlayer alloc] initWithURL: url];
    _avLayer.player = self.avP;
}

- (void)SetLabelText:(NSString*)strTitle
{
    _lb.text = strTitle;
}

- (void)play {
//    if([self checkPlayerStatus] == TRUE){
//        [self.avP play];
//    } else{
//        [self checkPlayerStatus];
//        [self play];
//    }
    NSLog( @"%@", self.url);    
    [self.avP play];
}

-(void)pause{
    NSLog(@"custom pause");
    [self.avP pause];
    //self.avP = nil;
    //self.avLayer = nil;
}
@end
