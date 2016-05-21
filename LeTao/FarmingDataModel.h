//
//  FarmingDataModel.h
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FDataItemModel.h"

@interface FarmingDataModel : JSONModel

@property(nonatomic,strong)NSArray<FDataItemModel> *illitems;

@end
