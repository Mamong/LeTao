//
//  DataRequest.h
//  LeTao
//
//  Created by marco on 5/8/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"
#import "FarmingDataModel.h"
//#import "IlluminationModel.h"
//#import "HumidityModel.h"

@interface DataRequest : NSObject
//
//+ (void)getIlluminationDataWithParams:(NSDictionary*)params success:(void(^)(IlluminationModel *illu))success
//                              failure:(void(^)(StatusModel *status))failure;
//
//+ (void)getHumidityDataWithParams:(NSDictionary*)params success:(void(^)(HumidityModel *humidity))success
//                          failure:(void(^)(StatusModel *status))failure;

+ (void)getFarmingDataWithParams:(NSDictionary*)params success:(void(^)(FarmingDataModel *farming))success
                          failure:(void(^)(StatusModel *status))failure;


@end
