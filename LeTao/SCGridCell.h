//
//  SCGridCell.h
//  demo
//
//  Created by 罗思成 on 16/2/26.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCGridCellDelegate;

@interface SCGridCell : UITableViewCell

@property (nonatomic, strong) id<SCGridCellDelegate> delegate;
@property (nonatomic, strong) NSArray *ratio;
@property (nonatomic, strong) NSArray *labels;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       column:(NSArray *)column;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       column:(NSArray *)column
                        ratio:(NSArray *)ratio;

@end

@protocol SCGridCellDelegate <NSObject>

- (void)clickWithText:(NSString *)text;

@end