//
//  CartViewController.h
//  LeTao
//
//  Created by marco on 4/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

