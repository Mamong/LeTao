//
//  IlluminationItem.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IlluminationItem : JSONModel

@property(nonatomic,strong)NSString *low;
@property(nonatomic,strong)NSString *high;
@property(nonatomic,strong)NSString *day;

@end
