//
//  SCGridTable.m
//  demo
//
//  Created by 罗思成 on 16/2/25.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import "SCGridTable.h"
#import "SCGridCell.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation SCGridTable

#pragma - Constructor

/**
 *  create an instance without ratio
 *
 *  @param frame  frame for this instance
 *  @param header string values for header line
 *  @param data   data for GridTable
 *
 *  @return a SCGridtable instance without ratio
 */
- (instancetype)initWithFrame:(CGRect)frame
                       header:(NSArray *)header
                         data:(NSArray *)data {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.header = header;
        self.data = data;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.scrollView.scrollEnabled = NO;
        //self.scrollView.backgroundColor = [UIColor greenColor];
        // setup Header
        [self setupHeaderViewWithWidth:CGRectGetWidth(self.frame)];
        [self.scrollView addSubview:self.headerView];
        
        // setup GridTable
        [self setupGridTableWithWidth:CGRectGetWidth(self.frame)];
        [self.scrollView addSubview:self.gridTable];
        
        [self addSubview:self.scrollView];
    }
    
    return self;
}

/**
 *  crate an instance with ratio
 *
 *  @param frame  frame for this instance
 *  @param header string values for header line
 *  @param data   data for GridTable
 *  @param ratio  ratio for each column including header
 *
 *  @return a SCGridTable instance with ratio
 */
- (instancetype)initWithFrame:(CGRect)frame
                       header:(NSArray *)header
                         data:(NSArray *)data
                        ratio:(NSArray *)ratio {
    self.ratio = ratio;
    
    return [self initWithFrame:frame header:header data:data];
}

#pragma - Data Reload

- (void)refreshWithData:(NSArray *)data {
    self.data = data;
    [self.gridTable reloadData];
}

#pragma - ScrollView Extend

- (void)extandViewWithWidth:(CGFloat)width {
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) + width, CGRectGetHeight(self.frame));
    self.scrollView.scrollEnabled = YES;
    
    [self.headerView removeFromSuperview];
    self.headerView = nil;
    [self setupHeaderViewWithWidth:self.scrollView.contentSize.width];
    [self.scrollView addSubview:self.headerView];
    
    [self.gridTable removeFromSuperview];
    self.gridTable = nil;
    [self setupGridTableWithWidth:self.scrollView.contentSize.width];
    [self.scrollView addSubview:self.gridTable];
}

#pragma - Header View

- (void)setupHeaderViewWithWidth:(CGFloat)width {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    self.headerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    self.headerView.layer.borderWidth = 1;
    self.headerView.backgroundColor = [UIColor lightGrayColor];
    
    // put all header columns
    CGFloat startPosition = 0;
    CGFloat columnWidth = CGRectGetWidth(self.frame) / [self.header count];
    
    for (int i = 0; i < [self.header count]; i++) {
        if (self.ratio) {
            columnWidth = width * [self.ratio[i] doubleValue];
        }
        
        CGRect columnFrame = CGRectMake(startPosition + 6, 6, columnWidth - 12, 30 - 12);
        UILabel *column = [[UILabel alloc] initWithFrame:columnFrame];
        [column setText:self.header[i]];
        [column setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [column setMinimumScaleFactor:0.1];
        [column setAdjustsFontSizeToFitWidth:YES];
        [column setTextAlignment:NSTextAlignmentLeft];
        [self.headerView addSubview:column];
        
        UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(startPosition, 0, 1, 30)];
        [border setImage:[self imageFromColor:UIColorFromRGB(0xdddddd)]];
        [self.headerView addSubview:border];
        
        startPosition += columnWidth;
    }
}

#pragma - Setup GridTable

- (void)setupGridTableWithWidth:(CGFloat)width {
    self.gridTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, width, CGRectGetHeight(self.frame) - 30) style:UITableViewStylePlain];
    self.gridTable.delegate = self;
    self.gridTable.dataSource = self;
    self.gridTable.separatorColor = [UIColor clearColor];
}

#pragma - UITableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SCGridCell";
    SCGridCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        if (self.ratio) {
            cell = [[SCGridCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier
                                              column:self.data[indexPath.row]
                                               ratio:self.ratio];
        } else {
            cell = [[SCGridCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier
                                              column:self.data[indexPath.row]];
        }
        
        cell.delegate = self;
        
    }
    cell.backgroundColor = indexPath.row%2==0?[UIColor whiteColor]:[UIColor lightGrayColor];

    return cell;
}

#pragma - SCGridCell Delegate

- (void)clickWithText:(NSString *)text {
    if ([self.delegate respondsToSelector:@selector(SCGridTable:clickWithText:)]) {
        [self.delegate SCGridTable:self clickWithText:text];
    }
}

#pragma - Image Work

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
