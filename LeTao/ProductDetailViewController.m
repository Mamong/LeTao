//
//  ProductDetailViewController.m
//  LeTao
//
//  Created by marco on 4/9/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "HomeViewController.h"
#import "AVPlayerDemoPlaybackViewController.h"

#import "PopAnimator.h"

@interface ProductDetailViewController ()//<UINavigationControllerDelegate>

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PlaybackSegue"]) {
        AVPlayerDemoPlaybackViewController *avPlayer = (AVPlayerDemoPlaybackViewController*)segue.destinationViewController;
        NSURL *videoUrl = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
        avPlayer.URL = videoUrl;
    }
}



//#pragma mark - 动画代理 (导航栏控制器动画代理)
//- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                fromViewController:(UIViewController *)fromVC
//                                                  toViewController:(UIViewController *)toVC {
//    
//    if ([toVC isKindOfClass:[HomeViewController class]]) {
//        
//        PopAnimator *transition = [[PopAnimator alloc] init];
//        return transition;
//        
//    }else{
//        
//        return nil;
//    }
//}

@end
