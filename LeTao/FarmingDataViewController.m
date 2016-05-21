//
//  FarmingDataViewController.m
//  LeTao
//
//  Created by marco on 4/10/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "FarmingDataViewController.h"
#import "DataRequest.h"

#import "UUChart/UUChart.h"
#import "ChartViewDataSource.h"

@interface FarmingDataViewController ()
@property(nonatomic,strong) NSMutableArray *farmingDatas;
@property(nonatomic,strong) NSMutableArray *illuDatas;
@property(nonatomic,strong) NSMutableArray *humiDatas;

@end

@implementation FarmingDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    _farmingDatas = @[@{@"items":@[
//                                  @{@"points":@[@{@"x":@"0",@"y":@"34"},@{@"x":@"1",@"y":@"56"},@{@"x":@"2",@"y":@"32"},
//                                              @{@"x":@"3",@"y":@"54"},@{@"x":@"4",@"y":@"13"},@{@"x":@"5",@"y":@"67"},
//                                              @{@"x":@"6",@"y":@"22"},@{@"x":@"7",@"y":@"44"}]},
//                                  @{@"points":@[@{@"x":@"0",@"y":@"53"},@{@"x":@"1",@"y":@"29"},@{@"x":@"2",@"y":@"65"},
//                                              @{@"x":@"3",@"y":@"45"},@{@"x":@"4",@"y":@"27"},@{@"x":@"5",@"y":@"13"},
//                                                @{@"x":@"6",@"y":@"60"},@{@"x":@"7",@"y":@"89"}]}]},
//                      @{@"items":@[
//                                 @{@"points":@[@{@"x":@"0",@"y":@"12"},@{@"x":@"1",@"y":@"90"},@{@"x":@"2",@"y":@"67"},
//                                                 @{@"x":@"3",@"y":@"33"},@{@"x":@"4",@"y":@"13"},@{@"x":@"5",@"y":@"77"},
//                                                 @{@"x":@"6",@"y":@"11"},@{@"x":@"7",@"y":@"2"}]}]}
//                     ];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _farmingDatas = [NSMutableArray arrayWithCapacity:3];
    _illuDatas = [NSMutableArray arrayWithCapacity:2];
    _humiDatas = [NSMutableArray arrayWithCapacity:1];
    [self loadData];
}

- (void)loadData
{
    [DataRequest getFarmingDataWithParams:nil success:^(FarmingDataModel *farm) {
        if (farm) {
            //光照数据加入farmingDatas
            NSArray *items = farm.illitems;
            NSMutableArray *lows = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *highs = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *shidus = [NSMutableArray arrayWithCapacity:1];

            for (FDataItemModel *item in items) {
                [lows addObject:@{@"x":item.date,@"y":item.lowwendu}];
                [highs addObject:@{@"x":item.date,@"y":item.highwendu}];
                [shidus addObject:@{@"x":item.date,@"y":item.shidu}];
            }
            [_illuDatas addObject:@{@"points":lows}];
            [_illuDatas addObject:@{@"points":highs}];
            [_farmingDatas addObject:@{@"items":_illuDatas}];
            [_humiDatas addObject:@{@"points":shidus}];
            [_farmingDatas addObject:@{@"items":_humiDatas}];
            
            //刷新tableview
            [self.tableView reloadData];
        }
    } failure:^(StatusModel *status) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_farmingDatas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_farmingDatas count]>0?1:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chartCell" forIndexPath:indexPath];
    
    // Configure the cell...
    UUChart *chartView = [cell viewWithTag:1];
    if (chartView) {
        [chartView removeFromSuperview];
    }
    ChartViewDataSource *dataSource = [ChartViewDataSource dataSourceWithDictionary:[_farmingDatas objectAtIndex:indexPath.section]];
    if (indexPath.section == 0) {
        dataSource.chartRange = CGRangeMake(50, -20);
        dataSource.chartHighlightRange = CGRangeMake(40, -10);
    }else{
        dataSource.chartRange = CGRangeMake(100, 0);
        dataSource.chartHighlightRange = CGRangeMake(75, 25);
    }
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                   dataSource:dataSource
                                        style:UUChartStyleLine];
    chartView.tag = 1;
    [chartView showInView:cell.contentView];
    
    UILabel *titleLabel = [cell viewWithTag:2];
    titleLabel.text = indexPath.section == 0 ? @"温度数据(℃)":@"湿度数据(%)";
    return cell;
}

@end
