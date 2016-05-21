//
//  DataRequest.m
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "DataRequest.h"
#import "LTNetworkManager.h"

#import "FarmingDataModel.h"

#define  FARMING_DATA_GET_REQUEST_URL                      @"/zzz/hwd.php"


@implementation DataRequest

+ (void)getFarmingDataWithParams:(NSDictionary*)params success:(void(^)(FarmingDataModel *farming))success
                         failure:(void(^)(StatusModel *status))failure
{
        [[LTNetworkManager sharedManager] getWithUrl:FARMING_DATA_GET_REQUEST_URL parameters:params success:^(NSDictionary *result) {
    
            FarmingDataModel *farmResult = [[FarmingDataModel alloc] initWithDictionary:result error:nil];
    
            if (success) {
                success(farmResult);
            }
    
        } failure:^(StatusModel *status) {
            if (failure) {
                failure(status);
            }
        }];

}


@end
