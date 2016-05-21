//
//  ActivityModel.h
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ActivityItemModel.h"

@interface ActivityModel : JSONModel

@property (nonatomic, strong)NSArray<ActivityItemModel>*record;
@end
