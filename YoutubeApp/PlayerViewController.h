//
//  PlayerViewController.h
//  YoutubeApp
//
//  Created by MacMini on 23/05/2022.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface PlayerViewController : UIViewController
@property (nonatomic, strong) NSString* urlVideo;
//@property (nonatomic, strong) NSString* titleVideo;
//@property (nonatomic, strong) NSString* imageVideo;
@property (nonatomic) CGRect rect;
@end

