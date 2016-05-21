//
//  ActivityItemModel.h
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ActivityItemModel


@end

@interface ActivityItemModel : JSONModel
@property(nonatomic, strong)NSString *acid;
@property(nonatomic, strong)NSString *actype;
@property(nonatomic, strong)NSString<Optional> *accontent;
@property(nonatomic, strong)NSString *actime;

@end
