//
//  TableViewCellCustom.h
//  YoutubeApp
//
//  Created by MacMini on 19/05/2022.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TableViewCellCustom : UITableViewCell
@property (nonatomic) AVPlayer *avP;
@property (nonatomic) AVPlayerLayer *avLayer;

- (void)setPlayer:(NSString*)videoName;

- (void)SetLabelText:(NSString*)strTitle;

@end


