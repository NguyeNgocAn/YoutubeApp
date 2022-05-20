//
//  TableViewCellCustom.m
//  YoutubeApp
//
//  Created by MacMini on 19/05/2022.
//

#import "TableViewCellCustom.h"
@interface TableViewCellCustom()

@property (weak, nonatomic) IBOutlet UIView *viewPlayer;
//@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
//@property (nonatomic) UIView* viewPlayer;

@end

@implementation TableViewCellCustom

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setPlayer:(NSString*)videoName{
    _viewPlayer.frame = self.contentView.frame;
    NSURL * url = [NSBundle.mainBundle URLForResource:videoName withExtension:@"mp4"];
    _avP = [[AVPlayer alloc] initWithURL:url];
    _avLayer = [AVPlayerLayer playerLayerWithPlayer:_avP];
    _avLayer.player = _avP;
    _avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _avLayer.frame = CGRectMake(0, 0, self.viewPlayer.frame.size.width, self.viewPlayer.frame.size.height*2/3);
    [self.viewPlayer.layer addSublayer:_avLayer];
}

- (void)SetLabelText:(NSString*)strTitle
{
    UILabel* lb = [[UILabel alloc]initWithFrame:CGRectMake(0, _avLayer.frame.size.height, _viewPlayer.frame.size.width, _viewPlayer.frame.size.height - _avLayer.frame.size.height)];
    lb.text = strTitle;
    lb.textColor = [UIColor blueColor];
    [self.viewPlayer addSubview: lb];
}

@end
