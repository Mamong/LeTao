//
//  IlluminationItem.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol IlluminationItem <NSObject>


@end

@interface IlluminationItem : JSONModel

@property(nonatomic,strong)NSString *lowwendu;
@property(nonatomic,strong)NSString *highwendu;
@property(nonatomic,strong)NSString *date;

@end
