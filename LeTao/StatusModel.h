//
//  StatusModel.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface StatusModel : JSONModel
@property (nonatomic, assign) NSInteger code;
@property (strong, nonatomic) NSString* msg;
@end
