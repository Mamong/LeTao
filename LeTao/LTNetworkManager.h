//
//  LTNetworkManager.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "StatusModel.h"

@interface LTNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;


- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure;

@end
