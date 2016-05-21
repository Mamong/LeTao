//
//  ActivityRequest.m
//  LeTao
//
//  Created by marco on 5/21/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "ActivityRequest.h"
#import "LTNetworkManager.h"
#import "ActivityModel.h"

#define  ACTIVITY_DATA_GET_REQUEST_URL                      @"/zzz/record.php"

@implementation ActivityRequest

+ (void)getActivityDataWithParams:(NSDictionary*)params success:(void(^)(ActivityModel *farming))success
                          failure:(void(^)(StatusModel *status))failure
{
    [[LTNetworkManager sharedManager] getWithUrl:ACTIVITY_DATA_GET_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        ActivityModel *actResult = [[ActivityModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(actResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

@end
