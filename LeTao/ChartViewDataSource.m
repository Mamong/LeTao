//
//  ChartViewDataSource.m
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "ChartViewDataSource.h"

@implementation ChartViewDataSource

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init]) {
        _dictionary = dictionary;
        self.chartRange = CGRangeMake(100, 0);
        self.chartHighlightRange = CGRangeMake(25, 75);
    }
    return self;
}

+(instancetype)dataSourceWithDictionary:(NSDictionary*)dict
{
    return [[ChartViewDataSource alloc]initWithDictionary:dict];
}


#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    NSArray *items = [_dictionary objectForKey:@"items"];
    NSArray *points = [items[0] objectForKey:@"points"];
    NSMutableArray *axisXs = [NSMutableArray arrayWithCapacity:points.count];
    for (NSDictionary *point in points) {
        [axisXs addObject:point[@"x"]];
    }
    return axisXs;
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *items = [_dictionary objectForKey:@"items"];
    NSMutableArray *axisYArr = [NSMutableArray arrayWithCapacity:2];

    for (NSDictionary *item in items) {
        NSArray *points = [item objectForKey:@"points"];
        NSMutableArray *axisYs = [NSMutableArray arrayWithCapacity:points.count];
        for (NSDictionary *point in points) {
            [axisYs addObject:point[@"y"]];
        }
        [axisYArr addObject:axisYs];
    }
    return axisYArr;
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor green],[UUColor red],[UUColor brown]];
}
//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{

    return self.chartRange;
    //return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    return self.chartHighlightRange;
    //return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return YES;
}

@end
