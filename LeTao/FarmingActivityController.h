//
//  FarmingActivityController.h
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGridTable.h"

@interface FarmingActivityController : UIViewController<SCGridTableDelegate>

@property (nonatomic, strong) SCGridTable *vinda;

@property (nonatomic, weak) IBOutlet UIScrollView *theScrollView;

@end
