//
//  ProductDetailViewController.h
//  LeTao
//
//  Created by marco on 4/9/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;

@property (nonatomic, assign) NSUInteger productId;


@end
