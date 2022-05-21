//
//  TableViewCellCustom.m
//  YoutubeApp
//
//  Created by MacMini on 19/05/2022.
//

#import "TableViewCellCustom.h"

@interface TableViewCellCustom()

@property (nonatomic, strong) AVPlayer *avP;
@property (nonatomic, strong) AVPlayerLayer *avLayer;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UILabel* lb;
//@property (nonatomic) UIView* viewPlayer;

@end

@implementation TableViewCellCustom

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _avLayer = [AVPlayerLayer playerLayerWithPlayer:nil];
    _avLayer.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height/2);//self.contentView.bounds;
    _avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _lb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 44, self.contentView.bounds.size.width, 48)];
    _lb.lineBreakMode = NSLineBreakByWordWrapping;
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

- (void)setPlayer:(NSString*)videoName{
    
    //_url = [[NSURL alloc] initWithString: videoName];
    _url = videoName;
    NSURL * url = [[NSURL alloc]initWithString: self.url];
   // NSURL *strURL = ;
    _avP = [[AVPlayer alloc] initWithURL: url];
    _avLayer.player = _avP;
    
}

- (void)SetLabelText:(NSString*)strTitle
{
    _lb.text = strTitle;
}

- (void)play {
    NSLog( @"%@", self.url);
    [self.avP play];
}

@end
