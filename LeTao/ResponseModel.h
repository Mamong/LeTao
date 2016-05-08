//
//  ResponseModel.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

#import "StatusModel.h"

@interface ResponseModel : JSONModel
@property (strong, nonatomic) StatusModel* status;
@property (strong, nonatomic) NSDictionary<Optional>* result;
@end
