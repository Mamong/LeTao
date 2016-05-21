//
//  ActivityRequest.h
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"
#import "ActivityModel.h"

@interface ActivityRequest : NSObject

+ (void)getActivityDataWithParams:(NSDictionary*)params success:(void(^)(ActivityModel *farming))success
                         failure:(void(^)(StatusModel *status))failure;

@end
