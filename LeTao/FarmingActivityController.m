//
//  FarmingActivityController.m
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "FarmingActivityController.h"

@interface FarmingActivityController ()

@end

@implementation FarmingActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *header = @[@"活动项目", @"活动内容", @"时间", @"备注"];
    NSArray *ratio = @[@(0.2), @(0.2), @(0.2), @(0.4)];
    
    self.vinda = [[SCGridTable alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) header:header data:[self getTestData1] ratio:ratio];
    self.vinda.delegate = self;
    [self.theScrollView addSubview:self.vinda];
    
    [self performSelector:@selector(refreshTest) withObject:self];
    [self performSelector:@selector(extendWidthTest) withObject:self];
    
    //[self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - SCGridTable Delegate

- (void)SCGridTable:(SCGridTable *)SCGridTalbe clickWithText:(NSString *)text {
    NSLog(@"SCGridTable: %@", text);
}

#pragma - Test Data

- (NSArray *)getTestData1 {
    NSMutableArray *test = [[NSMutableArray alloc] init];
    [test addObject:@[@"lily", @"165cm", @"53kg", @"修改于2016-02-13,by marco"]];
    [test addObject:@[@"Bob", @"173cm", @"72kg", @"2016-01-02"]];
    return [test copy];
}

- (NSArray *)getTestData2 {
    NSMutableArray *test = [[NSMutableArray alloc] init];
    [test addObject:@[@"lily", @"165cm", @"53kg", @"修改于2016-02-13,by marco"]];
    [test addObject:@[@"Bob", @"173cm", @"72kg", @"2016-01-02"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];
    [test addObject:@[@"John", @"180cm", @"67kg", @"2015-11-23"]];

    return [test copy];
}

#pragma - Test Refresh

- (void)refreshTest {
    [self.vinda refreshWithData:[self getTestData2]];
}

#pragma - Test Extend Width

- (void)extendWidthTest {
    [self.vinda extandViewWithWidth:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
