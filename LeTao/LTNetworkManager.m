//
//  LTNetworkManager.m
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "LTNetworkManager.h"
#import "ResponseModel.h"

@implementation LTNetworkManager

+ (LTNetworkManager *)sharedManager {
    static dispatch_once_t onceToken;
    static LTNetworkManager *_manager = nil;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://139.129.51.132"];
        
        _manager = [[LTNetworkManager alloc] init];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _manager = [[LTNetworkManager alloc] initWithBaseURL:baseURL
                                        sessionConfiguration:config];
        //_manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });
    return _manager;
}

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure {
    
    [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    
}

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
          progress:(void (^)(NSProgress *))progress
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure {
    
    [self GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ( success && failure ) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [self requestFailure:failure data:error];
        }
        
    }];
    
}

#pragma mark - Private Methods

- (void)requestSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(StatusModel *status))failure data:(id) data {
    
    NSDictionary *responseDictionary = [data copy];
    ResponseModel *responseModel = [[ResponseModel alloc] initWithDictionary:responseDictionary error:nil];
    
    if ( responseModel && responseModel.status && 1001 == responseModel.status.code){
        if (success)
        {
            success(responseModel.result);
        }
    } else {
        
        if (failure) {
            
            if ( !responseModel || !responseModel.status) {
                StatusModel *status = [[StatusModel alloc] init];
                
                status.code = 404;
                status.msg = @"网络异常";
                
                failure(status);
            } else {
                failure(responseModel.status);
            }
        }
    }
    
}

- (void)requestFailure:(void (^)(StatusModel *status))failure data:(NSError *)error {
    
    StatusModel *status = [[StatusModel alloc] init];
    
    status.code = 404;
    status.msg = @"网络异常";
    
}


@end
