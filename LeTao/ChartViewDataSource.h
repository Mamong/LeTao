//
//  ChartViewDataSource.h
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUChart/UUChart.h"

@interface ChartViewDataSource : NSObject<UUChartDataSource>

@property (nonatomic,strong)NSDictionary *dictionary;
/*
 {"items":["points":[{"x":"0","y":"34"},{"x":"1","y":"56"},{"x":"2","y":"32"},
            {"x":"3","y":"54"},{"x":"4","y":"13"},{"x":"5","y":"67"},
            {"x":"6","y":"22"},{"x":"7","y":"44"}],
         "points":[{"x":"0","y":"34"},{"x":"1","y":"56"},{"x":"2","y":"32"},
         {"x":"3","y":"54"},{"x":"4","y":"13"},{"x":"5","y":"67"},
         {"x":"6","y":"22"},{"x":"7","y":"44"}]
          ]
 }
 
 
 */

+(instancetype)dataSourceWithDictionary:(NSDictionary*)dict;

@end
