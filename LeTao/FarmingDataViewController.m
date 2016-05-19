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
    [self loadData];
}

- (void)loadData
{
    [DataRequest getIlluminationDataWithParams:nil success:^(IlluminationModel *illu) {
        if (illu) {
            //光照数据加入farmingDatas
            NSArray *items = illu.illitems;
            NSMutableArray *lows = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *highs = [NSMutableArray arrayWithCapacity:1];
            for (IlluminationItem *item in items) {
                [lows addObject:@{@"x":item.date,@"y":item.lowwendu}];
                [highs addObject:@{@"x":item.date,@"y":item.highwendu}];
            }
            [_illuDatas addObject:lows];
            [_illuDatas addObject:highs];
            [_farmingDatas addObject:@{@"items":_illuDatas}];
            //刷新tableview
            [self.tableView reloadData];
        }
    } failure:^(StatusModel *status) {
        
    }];
    
    
    [DataRequest getHumidityDataWithParams:nil success:^(HumidityModel *humidity) {
        if (humidity){
            //湿度数据加入farmingDatas
            
            //刷新tableview
            [self.tableView reloadData];
        }
    } failure:^(StatusModel *status) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                   dataSource:dataSource
                                        style:UUChartStyleLine];
    chartView.tag = 1;
    [chartView showInView:cell.contentView];
    
    UILabel *titleLabel = [cell viewWithTag:2];
    titleLabel.text = indexPath.section == 0 ? @"光照数据":@"湿度数据";
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
