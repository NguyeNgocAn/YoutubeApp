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
@property (nonatomic, strong) NSString *idVideo;
@property (nonatomic, strong) NSString *idImage;

- (void)setPlayer;

- (void)SetLabelText:(NSString*)strTitle;

- (void)play;

- (void)pause;
@end


