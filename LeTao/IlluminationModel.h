//
//  IlluminationModel.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "IlluminationItem.h"

@interface IlluminationModel : JSONModel

@property(nonatomic,strong)NSArray<IlluminationItem> *illitems;

@end
