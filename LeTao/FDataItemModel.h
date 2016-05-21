//
//  HumidityItem.h
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol FDataItemModel

@end

@interface FDataItemModel : JSONModel
@property (nonatomic, strong)NSString *date;
@property (nonatomic, strong)NSString *shidu;
@property(nonatomic,strong)NSString *lowwendu;
@property(nonatomic,strong)NSString *highwendu;

@end
