//
//  VideoPlayerViewController.h
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ZDDPlayerView : UIView
@property (nonatomic ,weak) AVPlayer *player;
@end



@interface VideoPlayerViewController : UIViewController

@property (nonatomic, copy) NSURL* URL;



@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,weak) IBOutlet ZDDPlayerView *playerView;
@property (nonatomic, weak) IBOutlet UISlider *videoSlider;
@property (nonatomic, weak) IBOutlet UIProgressView *videoProgress;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIButton *stateButton;


@end
