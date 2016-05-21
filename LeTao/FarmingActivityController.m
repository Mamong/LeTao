//
//  FarmingActivityController.m
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "FarmingActivityController.h"
#import "ActivityRequest.h"

@interface FarmingActivityController ()
@property (nonatomic, strong)NSMutableArray *datas;
@end

@implementation FarmingActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *header = @[@"活动项目", @"活动内容", @"时间", @"备注"];
    NSArray *ratio = @[@(0.2), @(0.2), @(0.2), @(0.4)];
    
    self.vinda = [[SCGridTable alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) header:header data:nil ratio:ratio];
    self.vinda.delegate = self;
    [self.theScrollView addSubview:self.vinda];
        
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _datas = [NSMutableArray arrayWithCapacity:3];
    [self loadData];
}

- (void)loadData
{
    [ActivityRequest getActivityDataWithParams:nil success:^(ActivityModel *act) {
        if (act) {
            //光照数据加入farmingDatas
            NSArray *items = act.record;
            
            for (ActivityItemModel *item in items) {
                [_datas addObject:@[item.acid,item.actype,item.accontent?item.accontent:@"",item.actime]];
            }
            
            //刷新tableview
            [self refreshGrid];
        }
    } failure:^(StatusModel *status) {
        
    }];
}



#pragma - SCGridTable Delegate

- (void)SCGridTable:(SCGridTable *)SCGridTalbe clickWithText:(NSString *)text {
    NSLog(@"SCGridTable: %@", text);
}


#pragma - Test Refresh

- (void)refreshGrid {
    [self.vinda refreshWithData:self.datas];
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
