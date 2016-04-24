//
//  HomeViewController.m
//  LeTao
//
//  Created by marco on 4/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductDetailViewController.h"

#import "PushAnimator.h"

@interface HomeViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //self.tabBarItem.selectedImage = image;
   [self.navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
   //[self setupInteractivePopGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endEditing:(id)sender
{
    
}

//- (void)setupInteractivePopGestureRecognizer {
//    // 获取手势代理
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//}


- (void)supportBtnTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    UIButton *supportBtn = (UIButton *)sender;
    supportBtn.selected = !supportBtn.selected;
    
    //send request and update local identifier
}

- (void)collectBtnTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    UIButton *collectBtn = (UIButton *)sender;
    collectBtn.selected = !collectBtn.selected;
    
    //send request and update local identifier

}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     ProductDetailViewController *productVC = (ProductDetailViewController*)segue.destinationViewController;
     productVC.productId = self.tableView.indexPathForSelectedRow.row;
 }


#pragma UITableview DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    UILabel *publisher = (UILabel*)[cell viewWithTag:1];
    publisher.text = [NSString stringWithFormat:@"码农某某%ld",indexPath.row];
    UIButton *supportBtn = (UIButton*)[cell viewWithTag:3];
    [supportBtn addTarget:self action:@selector(supportBtnTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *collectBtn = (UIButton*)[cell viewWithTag:4];
    [collectBtn addTarget:self action:@selector(collectBtnTapped:event:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

//#pragma mark - 动画代理
//- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                fromViewController:(UIViewController *)fromVC
//                                                  toViewController:(UIViewController *)toVC{
//    
//    if ([toVC isKindOfClass:[ProductDetailViewController class]]) {
//        
//        PushAnimator *transition = [[PushAnimator alloc] init];
//        return transition;
//        
//    }else{
//        
//        return nil;
//    }
//}
//


















@end
