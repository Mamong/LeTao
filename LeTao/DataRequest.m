//
//  DataRequest.m
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "DataRequest.h"
#import "LTNetworkManager.h"

#import "IlluminationModel.h"
#import "HumidityModel.h"

#define  ILLUMINATION_GET_REQUEST_URL                      @"/data/illumination"

#define  HUMIDITY_GET_REQUEST_URL                      @"/data/humidity"


@implementation DataRequest

+ (void)getIlluminationDataWithParams:(NSDictionary*)params success:(void(^)(IlluminationModel *illu))success
                              failure:(void(^)(StatusModel *status))failure
{
    [[LTNetworkManager sharedManager] getWithUrl:ILLUMINATION_GET_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        IlluminationModel *illuResult = [[IlluminationModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(illuResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getHumidityDataWithParams:(NSDictionary*)params success:(void(^)(HumidityModel *humidity))success
                          failure:(void(^)(StatusModel *status))failure
{
    [[LTNetworkManager sharedManager] getWithUrl:HUMIDITY_GET_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        HumidityModel *illuResult = [[HumidityModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(illuResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}


@end
