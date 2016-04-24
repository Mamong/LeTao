//
//  VideoPlayerViewController.m
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "VideoPlayerViewController.h"

@implementation ZDDPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end

@interface VideoPlayerViewController (){
    BOOL _played;
    NSString *_totalTime;
    float mRestoreAfterScrubbingRate;
    BOOL isSeeking;
    BOOL seekToZeroBeforePlay;
}
@property(nonatomic,strong)id playbackTimeObserver;

- (IBAction)stateButtonTouched:(id)sender;
- (IBAction)videoSlierChangeValue:(id)sender;
- (IBAction)videoSlierChangeValueEnd:(id)sender;
@end

@interface VideoPlayerViewController (Player)
- (void)removePlayerTimeObserver;
- (CMTime)playerItemDuration;
- (BOOL)isPlaying;
- (void)playerItemDidReachEnd:(NSNotification *)notification ;
- (void)observeValueForKeyPath:(NSString*) path ofObject:(id)object change:(NSDictionary*)change context:(void*)context;
- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys;
@end

@implementation VideoPlayerViewController

- (void)dealloc {
    NSLog(@"dealloc");
    [self.player pause];

    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.player removeTimeObserver:self.playbackTimeObserver];

    self.playerItem = nil;
    self.player = nil;
    [self.playerView removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *videoUrl = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];

    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    AVPlayerLayer *layer = (AVPlayerLayer*)self.playerView.layer;
    layer.player = self.player;
    self.stateButton.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    
    isSeeking = NO;
    //[self initScrubberTimer];
    
    [self syncScrubber];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player pause];
    //[self.player.currentItem cancelPendingSeeks];
    //[self.player.currentItem.asset cancelLoading];

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.stateButton.enabled = YES;
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            //[self monitoringPlayback:self.playerItem];// 监听播放状态
            [self syncScrubber];
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    if (loadedTimeRanges.count == 0) {
        return 0.0;
    }
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

/*
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    NSLog(@"Monitoring");
    __weak typeof(self) weakSelf = self;
    NSString *totalTime = _totalTime;
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf updateVideoSlider:currentSecond];
        NSString *timeString = [weakSelf convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,totalTime];
    }];
}*/

- (void)customVideoSlider:(CMTime)duration {
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

- (IBAction)stateButtonTouched:(id)sender {
    if (!_played) {
        if (YES == seekToZeroBeforePlay)
        {
            seekToZeroBeforePlay = NO;
            [self.player seekToTime:kCMTimeZero];
        }
        [self.playerView.player play];
        [self.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.playerView.player pause];
        [self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    _played = !_played;
}

/*
- (IBAction)videoSlierChangeValue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value change:%f",slider.value);
    
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.playerView.player play];
        }];
    }
}

- (IBAction)videoSlierChangeValueEnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.playerView.player play];
        [weakSelf.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
    }];
}*/


#pragma mark -
#pragma mark Movie scrubber control
/* Set the scrubber based on the player current time. */
- (void)syncScrubber
{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        _videoSlider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        float minValue = [self.videoSlider minimumValue];
        float maxValue = [self.videoSlider maximumValue];
        double time = CMTimeGetSeconds([self.player currentTime]);
        
        [self.videoSlider setValue:(maxValue - minValue) * time / duration + minValue];
        
        CGFloat currentSecond = _playerItem.currentTime.value/_playerItem.currentTime.timescale;// 计算当前在第几秒
        NSString *timeString = [self convertTime:currentSecond];
        self.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
    }
}

/* The user is dragging the movie controller thumb to scrub through the movie. */
- (IBAction)beginScrubbing:(id)sender
{
    mRestoreAfterScrubbingRate = [self.player rate];
    [self.player setRate:0.f];
    
    /* Remove previous timer. */
    [self removePlayerTimeObserver];
}

/* Set the player current time to match the scrubber position. */
- (IBAction)scrub:(id)sender
{
    if ([sender isKindOfClass:[UISlider class]] && !isSeeking)
    {
        isSeeking = YES;
        UISlider* slider = sender;
        
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration)) {
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration))
        {
            float minValue = [slider minimumValue];
            float maxValue = [slider maximumValue];
            float value = [slider value];
            
            double time = duration * (value - minValue) / (maxValue - minValue);
            
            [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    isSeeking = NO;
                });
            }];
        }
    }
}

/* The user has released the movie thumb control to stop scrubbing through the movie. */
- (IBAction)endScrubbing:(id)sender
{
    if (!_playbackTimeObserver)
    {
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration))
        {
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration))
        {
            CGFloat width = CGRectGetWidth([self.videoSlider bounds]);
            double tolerance = 0.5f * duration / width;
            
            __weak typeof(self) weakSelf = self;
            _playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(tolerance, NSEC_PER_SEC) queue:NULL usingBlock:
                             ^(CMTime time)
                             {
                                 [weakSelf syncScrubber];
                             }];
        }
    }
    
    if (mRestoreAfterScrubbingRate)
    {
        [self.player setRate:mRestoreAfterScrubbingRate];
        mRestoreAfterScrubbingRate = 0.f;
    }
}

- (BOOL)isScrubbing
{
    return mRestoreAfterScrubbingRate != 0.f;
}

-(void)enableScrubber
{
    self.videoSlider.enabled = YES;
}

-(void)disableScrubber
{
    self.videoSlider.enabled = NO;
}

- (void)updateVideoSlider:(CGFloat)currentSecond {
    [self.videoSlider setValue:currentSecond animated:NO];
}


- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf updateVideoSlider:0.0];
        [weakSelf.stateButton setTitle:@"Play" forState:UIControlStateNormal];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation VideoPlayerViewController (Player)

#pragma mark Player Item

- (BOOL)isPlaying
{
    return mRestoreAfterScrubbingRate != 0.f || [self.player rate] != 0.f;
}

/* Called when the player item has played to its end time. */
- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    /* After the movie has played to its end time, seek back to time zero
     to play it again. */
    seekToZeroBeforePlay = YES;
}

/* ---------------------------------------------------------
 **  Get the duration for a AVPlayerItem.
 ** ------------------------------------------------------- */

- (CMTime)playerItemDuration
{
    AVPlayerItem *playerItem = [self.player currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        return([playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}


/* Cancels the previously registered time observer. */
-(void)removePlayerTimeObserver
{
    if (_playbackTimeObserver)
    {
        [self.player removeTimeObserver:_playbackTimeObserver];
        _playbackTimeObserver = nil;
    }
}
@end
